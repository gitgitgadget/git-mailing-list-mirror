From: Pierre Thierry <pierre@nothos.net>
Subject: Location-agnostic submodules
Date: Fri, 27 Apr 2012 16:37:10 +0200
Message-ID: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 16:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmIS-0006Ny-G3
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 16:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760274Ab2D0OhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 10:37:14 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:22300 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823Ab2D0OhN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 10:37:13 -0400
Received: from pthierry.pck.nerim.net ([90.26.147.93])
	by mwinf5d41 with ME
	id 32dB1j00B2189LS032dBs1; Fri, 27 Apr 2012 16:37:11 +0200
Received: by pthierry.pck.nerim.net (Postfix, from userid 1000)
	id D0A1B1800FC; Fri, 27 Apr 2012 16:37:10 +0200 (CEST)
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196471>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just discovered the workings of the submodule command, and as I have
grown to like the fact that a repository is not unique with Git, and
specifically that it has no unique or central location, I'm bothered
by how submodule works.

Would there be any major issue in having (1) submodule to be able to
clone the submodules from the super repository when they are available
there and (2) having zero, one or many addresses for each submodule,
used as hints (obviously not used when (1) is satisfied)?

When the repository is not bare, the submodules would be found at
their place in the tree, nothing difficult here. When the repository
is bare, there could be a tree with the bare repositories of the
submodules.

This could be done by a new subcommand, that would take a remote as an
optional argument, its default being origin, as usual:

$ git submodule clone origin


As I see it, adding this 'clone' subcommand for the case where the
repository is not bare couldn't add any compatibility issue, so if I'm
right on this point, I'd like to try and implement this soon.

Curiously,
Pierre
--=20
pierre@nothos.net
OpenPGP 0xD9D50D8A

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+arxUACgkQxe13INnVDYrUtgCg8DToV/a8mGfJmkSzro6TsfQ6
vHgAoK5xWD9nwXCoGQ1dlCv5IMIDHBkr
=v9JE
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
