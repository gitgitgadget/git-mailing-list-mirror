From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport-in-Perl: Limit the number of arguments to git-update-cache
Date: Thu, 30 Jun 2005 20:02:24 +0200
Message-ID: <20050630180224.GW10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <pan.2005.06.30.10.34.00.807346@smurf.noris.de> <Pine.LNX.4.63.0506301249550.1667@localhost.localdomain> <Pine.LNX.4.63.0506301314280.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnOK8GJR8G8YucN8"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 19:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do3Gu-0005tF-C2
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 19:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVF3SDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVF3SDc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 14:03:32 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:31666 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261216AbVF3SDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 14:03:11 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do3Mr-0003VE-1v; Thu, 30 Jun 2005 20:02:41 +0200
Received: (nullmailer pid 11674 invoked by uid 501);
	Thu, 30 Jun 2005 18:02:24 -0000
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506301314280.1667@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--TnOK8GJR8G8YucN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Nicolas Pitre:
> That example should be:
>=20
> 	write( "| xargs git-update-cache --add --", @new)
>=20
> of course.
>=20
Actually, 'local $\ =3D "\0";' and 'xargs -0', which is roughly the point
where doing it all in Perl starts being more readable. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The only secure computer is one that's unplugged, locked in a safe,
and buried 20 feet under the ground in a secret location... and I'm
not even too sure about that one.
		-- Dennis Huges, FBI.

--TnOK8GJR8G8YucN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxDOw8+hUANcKr/kRAt14AJ4sRX34u8xy7JsYZ8nsWHs1g6cZ2QCdFzG0
LuNiHSV7DALSutbIKzA9pwQ=
=WJy8
-----END PGP SIGNATURE-----

--TnOK8GJR8G8YucN8--
