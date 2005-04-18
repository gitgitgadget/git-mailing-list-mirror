From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 13:15:25 +0200
Message-ID: <1113822925.16288.22.camel@nosferatu.lan>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	 <20050417170539.B13233@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org>
	 <4262A767.4040300@dwheeler.com>
	 <20050417192000.C13233@flint.arm.linux.org.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-B2p416qaOvOs8IsHKIPF"
Content-Transfer-Encoding: 8bit
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 13:09:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNU7A-0006GO-GI
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 13:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVDRLMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 07:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVDRLMW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 07:12:22 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:47064 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S262036AbVDRLLp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 07:11:45 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id DDFF86B39;
	Mon, 18 Apr 2005 13:11:35 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 69AEF3A26DC;
	Mon, 18 Apr 2005 13:17:48 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19808-08; Mon, 18 Apr 2005 13:17:43 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id E58AC3A26DA;
	Mon, 18 Apr 2005 13:17:42 +0200 (SAST)
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417192000.C13233@flint.arm.linux.org.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-B2p416qaOvOs8IsHKIPF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-04-17 at 19:20 +0100, Russell King wrote:
> On Sun, Apr 17, 2005 at 02:13:59PM -0400, David A. Wheeler wrote:
> > On Sun, 17 Apr 2005, Russell King wrote:
> > >>BTW, there appears to be "errors" in the history committed thus far.
> > >>I'm not sure where this came from though.  Some of them could be
> > >>UTF8 vs ASCII issues, ....>=20
> > ...
> > >>One thing which definitely needs to be considered is - what character
> > >>encoding are the comments to be stored as?
> >=20
> > Linus Torvalds replied:
> > > To git, it's just a byte stream, and you can have binary comments if =
you
> > > want to. I personally would prefer to move towards UTF eventually, bu=
t I
> > > really don't think it matters a whole lot as long as 99.9% of everyth=
ing
> > > we'd see there is still 7-bit ascii.
> >=20
> > I would _heartily_ recommend moving towards UTF-8 as the
> > internal charset for all comments.  Alternatives are possible
> > (e.g., recording the charset in the header), but they're
> > incredibly messy.  Even if you don't normally work in UTF-8,
> > it's pretty easy to set most editors up to read & write UTF-8.
> > Having the data stored as a constant charset eliminates
> > a raft of error-prone code.
>=20
> Except, I believe, MicroEMACS, which both Linus and myself use.  As
> far as I know, there aren't any patches to make it UTF-8 compliant.
>=20
> The alternative is, I suppose, iconv.  However, iconv in _my_ glibc
> seems buggy (segfaults) and my efforts for building glibc 2.3.2 for
> ARM have failed.  Effectively that means iconv is inaccessible to
> me.
>=20

OT, and probably not much help, but glibc-2.3.5 is out ...


--=20
Martin Schlemmer


--=-B2p416qaOvOs8IsHKIPF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY5bNqburzKaJYLYRAuINAJ9BTszz4MHsawD0w+zZqUnMoEFKEwCfeM1f
1qCEz9u4Wk/lwnM38xAfxQg=
=+hGH
-----END PGP SIGNATURE-----

--=-B2p416qaOvOs8IsHKIPF--

