From: Martin Uecker <muecker@gmx.de>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful documents]
Date: Sun, 12 Jun 2005 16:53:42 +0200
Message-ID: <20050612145342.GA9882@macavity>
References: <20050612082555.GB6620@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: zooko@zooko.com
X-From: git-owner@vger.kernel.org Sun Jun 12 16:51:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhTnv-0008Tr-KN
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 16:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVFLOzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVFLOzm
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 10:55:42 -0400
Received: from dialin-145-254-144-014.arcor-ip.net ([145.254.144.14]:2060 "EHLO
	macavity") by vger.kernel.org with ESMTP id S262616AbVFLOz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 10:55:28 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DhTqI-0002cu-OM; Sun, 12 Jun 2005 16:53:42 +0200
To: git@vger.kernel.org
Mail-Followup-To: Martin Uecker <muecker@gmx.de>, git@vger.kernel.org,
	zooko@zooko.com
Content-Disposition: inline
In-Reply-To: <20050612082555.GB6620@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2005 at 10:25:55AM +0200, Petr Baudis wrote:
> ----- Forwarded message from zooko@zooko.com -----
>=20
> There is nothing theoretically surprising about this, but hopefully its
> concreteness and the accompanying scenario will make an impression on peo=
ple
> on people.  The same technique should work to generate two documents with
> identical SHA1 hashes.
>=20
> http://www.cits.rub.de/MD5Collisions/
>=20
> ----- End forwarded message -----
>=20
> I expected the two postscript files differing in some huge binary blob,
> but it turns out the binary part is very small (about 256 bytes) and
> only few (about nine) bytes are different, contrary to how people have
> predicted the collisions. This is much more close to finding a collision
> between similar pure C files, I think. Rather unsettling.
>=20

This attack scenario doesn't demonstrate the danger of hash
collisions but the danger of signing documents you do not
understand. The same technique works exactly in the same way
with postscript files which are actually identical but produce
different output under different conditions (time, fonts
installed on the printer whatever).

Never sign anything but plain text or documents which are
created in a controlled way and avoid signing documents
you did not create yourself.


Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFCrEx2YDJInvULMKYRAhn1AJirlb5BtQcJSDLQgnXkpt8EIhYzAKCEI8Jb
Ra9dpqOLpMa485/tvriB3g==
=abx9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
