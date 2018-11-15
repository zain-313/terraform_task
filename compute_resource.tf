resource "google_compute_instance" "default" {
	name = "jenkins"
	machine_type = "n1-standard-1"
	zone = "us-east1-b"
	tags = ["jenkins"]
	boot_disk {
		initialize_params {
		image = "centos-7"
	}
}

network_interface {
	network = "default"
	access_config {
		// Ephemeral IP
	}
  }

metadata {
	sshKeys = "terraform:${file("~/.ssh/id_rsa.pub")}"
}

connection = {
	type = "ssh"
	user = "terraform"
	private_key = "${file("~/.ssh/id_rsa")}"
}

provisioner "remote-exec" {
	scripts = [
		"scripts/script_one", 
		"scripts/script_two"
		]
}

}
