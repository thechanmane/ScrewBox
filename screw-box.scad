// OpenSCAD definitions
pad = 0.01;
smooth = 16;
$fn = smooth;

// Printer configuration and model optmization
layer_h = 0.6;
first_layer_h = 0.3;
nozzle_d = 0.8;
line_w = nozzle_d * 1.0; // Use a factor of 0.9 to encourage more "pure" perimeters (trying to avoid zig-zag infill)
perimeters = 2;
perimeter_w = perimeters * line_w;
bottom_layers = 2;
bottom_h = first_layer_h + (bottom_layers * layer_h);

// Model configuration
box_w = 130;
box_l = box_w;
box_h = 18;

// Predefined "modular" sizes for S, M, and L screw boxes
small_w = box_w/6;
small_l = box_l/6;
medium_w = box_w/3;
medium_l = small_l;
large_w = box_w/2;
large_l = medium_l;

// The main entry point for the ScrewBox model
union(){
	// Main/container box
	roundedRectOutline(box_w, box_l, 8);

	// Row 1 (bottom)
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([2 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([3 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([4 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([5 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);
	}

	// Row 2
	translate([0,1 * small_w, 0])
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([2 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([3 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([4 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);

		translate([5 * small_w,0,0])
		roundedRectOutline(small_w, small_l, 3);
	}

	// Row 3
	translate([0,2 * small_w, 0])
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(medium_w, medium_l, 3);

		translate([medium_w,0,0])
		roundedRectOutline(medium_w, medium_l, 3);

		translate([2 * medium_w,0,0])
		roundedRectOutline(medium_w, medium_l, 3);
	}

	// Row 4
	translate([0,3 * small_w, 0])
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(medium_w, medium_l, 3);

		translate([medium_w,0,0])
		roundedRectOutline(medium_w, medium_l, 3);

		translate([2 * medium_w,0,0])
		roundedRectOutline(medium_w, medium_l, 3);
	}

	// Row 5
	translate([0,4 * small_w, 0])
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(large_w, large_l, 3);

		translate([3 * small_w, 0, 0])
		roundedRectOutline(large_w, large_l, 3);
	}


	// Row 6 (top)
	translate([0,5 * small_w, 0])
	union()
	{
		// start at bottom left corner
		translate([0,0,0])
		roundedRectOutline(large_w, large_l, 3);

		translate([3 * small_w, 0, 0])
		roundedRectOutline(large_w, large_l, 3);
	}
}

module roundedRect(size, r) {

	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
	    // The circles are placed so that the outside bounding box matches the incoming x and y
	    // bottom left
	    translate([r, r, 0])
	    circle(r=r);

	    // bottom right
	    translate([(x) - r, r, 0])
	    circle(r=r);

	    // top left
	    translate([r, (y) - r, 0])
	    circle(r=r);

	    // top right
	    translate([(x) - r, (y) - r, 0])
	    circle(r=r);
	}
}

module roundedRectOutline(w, l, r)
{
	difference(){
		roundedRect([w,l,box_h],r);
		translate([perimeter_w, perimeter_w, bottom_h])
			roundedRect([w - 2 * perimeter_w, l - 2 * perimeter_w,box_h],r-1);
	}
}