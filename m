From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: cg-restore
Date: Sat, 24 Sep 2005 01:36:03 +0200
Message-ID: <20050923233603.GE1495@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
X-From: git-owner@vger.kernel.org Sat Sep 24 01:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIx6B-0007IP-99
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 01:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVIWXg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 19:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVIWXg5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 19:36:57 -0400
Received: from wg.technophil.ch ([213.189.149.230]:21444 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751346AbVIWXg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 19:36:56 -0400
Received: (qmail 19128 invoked by uid 1000); 23 Sep 2005 23:36:03 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9213>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What I did:
------------------------
[1:25] hydrogenium:cinit% cg-restore contrib+tools/cinit.graph.text.c=20
git-checkout-cache: contrib+tools/cinit.graph.text.c already exists
Makefile: locally modified
contrib+tools/Makefile: locally modified
contrib+tools/cinit.graph.text.c: locally modified
[1:25] hydrogenium:cinit% rm contrib+tools/cinit.graph.text.c=20
[1:26] hydrogenium:cinit% cg-restore contrib+tools/cinit.graph.text.c
Makefile: locally modified
contrib+tools/Makefile: locally modified
[1:26] hydrogenium:cinit%
------------------------

Is this the wanted behaviour of cg-restore or should it overwrite
the specified changed file?

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzSRY7OTBMvCUbrlAQIgIhAAlj79QOYxJxDVUPNPHjzRZ2oPCZOrRqGa
yCMb06DvbdQRoNRjNQIJ+593aI0gq+PvgQGOSl+KhT5cMFpBWdW8/Bq/6EWvkPXd
6MkYj5cuGlakQELF/dHNPqhTJzzQOnmenuXjcLdSo+0s3EkPfyHPHRI0etTUSV9p
nx8jDM0P9GA+8HkE4XR+im1eWH7nz7BcVUMqjbgiTshqC1eDG8qCti2/sN5hf2vx
b6BuoExWgj+GrKJnJ7JAzlXFLJy9c0Cdy1sWNO+juA7IZ9zgou5XSSWGEONw+yVf
IyVlRF5MNlhRl+6kQOg9uFlgrP6tP7xnMfS/dnU0NlkaDZm+rIeZviUhse9PdNeZ
qoPFOb8u0euMjjMhAAcSEqF44QDzrOS89+j8yZS/NYREIe+vIp0qTZ7BEqWfgffI
+o65/yVIWinLpCxge0XlCIsy5ABp/GMO9jhXVf6b+iTANp2UkbOBOvxEUzGgKbBp
etbocsnxcMTvU7EN8G+Ek1nwY0p2kXg5FIhk89j4cIzZGLe+kCsSW61akHmVDLqI
yDI0Rok8xvpA4B77OMYh8BcYgDwNgTEhq4+TzQFD23Jj/yBOovMpRG6h9DhS3PYP
F8SrahBSJ9ykDY5hYFPO0pfKuj86saFLyWzqcrn1L7bLdXXfIkgBDLCROIauVBxz
Dl52Mxyh6qc=
=Eouf
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
