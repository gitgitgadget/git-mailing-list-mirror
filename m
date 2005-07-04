From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 16:36:37 +0200
Message-ID: <20050704143637.GB32098@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de> <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050704135327.GA32098@kiste.smurf.noris.de> <20050704134611.GM18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
X-From: git-owner@vger.kernel.org Mon Jul 04 16:38:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpS5C-0002j6-L1
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 16:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVGDOho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVGDOhn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 10:37:43 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:59266 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261207AbVGDOhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 10:37:23 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DpS3q-0008D8-Af
	for git@vger.kernel.org; Mon, 04 Jul 2005 16:36:51 +0200
Received: (nullmailer pid 30086 invoked by uid 501);
	Mon, 04 Jul 2005 14:36:37 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050704134611.GM18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> > Because my code doesn't support compressed cvs connections:
> > a -z that doesn't work except for the rlog part would be a lie.
>=20
> I was talking about the cvsps '-z' option (see current git-cvsimport-scri=
pt).
> Are you saying you want to reserve that option to signify compressed
> cvs connections ?
>=20
Sorry, I was confused -- with cvsps, -capital-Z says to compress.

Ideally, I'd prefer to recycle standard CVS options as much as possible,=20
but given that the confusion is already there (worse: cvs' -z wants an
argument (compression level), cvsps' -Z doesn't) that may not actually
make sense. *Shrug*

I'm too happy when other people improve my tools to get hung up on
details like that. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You'll feel much better once you've given up hope.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCyUl18+hUANcKr/kRApD/AKCj9s5U0BwuhWfggqmWDxUZYz9gugCghmWm
eg1c+/zJglsCD25zzzD7Zy4=
=UhxR
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
