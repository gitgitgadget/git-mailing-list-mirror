From: Martin Uecker <muecker@gmx.de>
Subject: Re: space compression (again)
Date: Sat, 16 Apr 2005 16:39:05 +0200
Message-ID: <20050416143905.GA10370@macavity>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org> <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
X-From: git-owner@vger.kernel.org Sat Apr 16 16:37:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMoQ3-0001hX-8c
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVDPOke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVDPOkd
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:40:33 -0400
Received: from dialin-145-254-144-243.arcor-ip.net ([145.254.144.243]:29056
	"EHLO macavity") by vger.kernel.org with ESMTP id S262669AbVDPOkZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 10:40:25 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DMoRt-0002kD-Ge
	for git@vger.kernel.org; Sat, 16 Apr 2005 16:39:05 +0200
To: git@vger.kernel.org
Mail-Followup-To: Martin Uecker <muecker@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2005 at 12:11:43PM -0700, Linus Torvalds wrote:


> On Fri, 15 Apr 2005, C. Scott Ananian wrote:
> >=20
> > So I guess I'll have to implement this and find out, won't I? =3D)
>=20
> The best way to shup somebody up is always to just do it, and say "hey, I=
=20
> told you so". It's hard to argue with numbers.

The right thing (TM) is to switch from SHA1 of compressed
content for the complete monolithic file to a merkle hash tree
of the uncompressed content. This would make the hash
independent of the actual storage method (chunked or not).=20


Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCYSOJYDJInvULMKYRAnOGAJkB/1R7xMCYiSlEbHo0Bit8HHKmugCeIMe8
ajUErAASZFdNrz3BK+Y7j1Q=
=aj+9
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
