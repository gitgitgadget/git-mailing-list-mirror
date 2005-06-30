From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 18:30:00 +0200
Message-ID: <20050630163000.GT10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nvGWocd+jzj7I/La"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:25:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do1pK-0000E4-6j
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVF3QbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVF3QbI
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:31:08 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:40110 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262995AbVF3QbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 12:31:00 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do1vQ-0000AP-Vo; Thu, 30 Jun 2005 18:30:22 +0200
Received: (nullmailer pid 9536 invoked by uid 501);
	Thu, 30 Jun 2005 16:30:00 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050630161423.GC26808@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--nvGWocd+jzj7I/La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> I'll wait for your update to do further checking.
>=20
Ah, found it -- that was my slightly modified version of cvsps, which
happens not to print an extra empty line at the end. cvs2git.c dutifully
strips these.

Duh. Will post an incremental patch shortly.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
As I learn to trust the universe, I no longer need to carry a gun.

--nvGWocd+jzj7I/La
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxB4I8+hUANcKr/kRAjGtAJ9gHQCyzchFpCihuyncVmRSk6KLiwCgpmTF
7pv+ybHeaKSnA3S1+OMAayw=
=KBi7
-----END PGP SIGNATURE-----

--nvGWocd+jzj7I/La--
