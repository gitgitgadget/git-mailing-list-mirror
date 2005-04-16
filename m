From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:13:12 +0200
Message-ID: <20050416191312.GT9461@lug-owl.de>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CMEQapY8OuP5ao1l"
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:09:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsft-00067p-RM
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVDPTNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDPTNU
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:13:20 -0400
Received: from lug-owl.de ([195.71.106.12]:27585 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261886AbVDPTNN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 15:13:13 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id F205F19026D; Sat, 16 Apr 2005 21:13:12 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-16 10:04:31 -0700, Linus Torvalds <torvalds@osdl.org>
wrote in message <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>:

> What do people think? I'm not so much worried about the data itself: the
> git architecture is _so_ damn simple that now that the size estimate has
> been confirmed, that I don't think it would be a problem per se to put
> 3.2GB into the archive. But it will bog down "rsync" horribly, so it will
> actually hurt synchronization untill somebody writes the rev-tree-like
> stuff to communicate changes more efficiently..
>=20
> IOW, it smells to me like we don't have the infrastructure to really work=
=20
> with 3GB archives, and that if we start from scratch (2.6.12-rc2), we can=
=20
> build up the infrastructure in parallell with starting to really need it.

3GB is quite some data, but I'd accept and prefer to download it from
somewhere. I think that it's worth it.

I accept that there are people out there which would love to get a
smaller archive, but at least most developers that would actually use it
for day-to-day work *do* have the bandwidth to download it. Maybe we'd
also prepare (from time to time) bzip'ed tarballs, which I expect to be
a tad smaller.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--CMEQapY8OuP5ao1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYWPIHb1edYOZ4bsRAsTHAJ9QWN62+Gn7FTteTpPcKr4U4Gd5GgCgh9ZT
zLeNdIdFUtNpJUtb3IDpdNU=
=TNp0
-----END PGP SIGNATURE-----

--CMEQapY8OuP5ao1l--
