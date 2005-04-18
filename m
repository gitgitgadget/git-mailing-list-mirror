From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 13:14:50 +0200
Message-ID: <1113822890.16288.19.camel@nosferatu.lan>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	 <1113774736.3884.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
	 <20050417231959.A30656@flint.arm.linux.org.uk>
	 <20050417235136.B30656@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
	 <20050418102332.A21081@flint.arm.linux.org.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k6dbkKhtn3ArOlnK5BDF"
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 13:08:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNU6w-0006En-W9
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 13:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVDRLMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 07:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVDRLMF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 07:12:05 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:49879 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S262035AbVDRLLL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 07:11:11 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id 7D2966AEA;
	Mon, 18 Apr 2005 13:11:02 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 72AC73A26DB;
	Mon, 18 Apr 2005 13:17:14 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27883-16; Mon, 18 Apr 2005 13:17:05 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 669533A26DA;
	Mon, 18 Apr 2005 13:17:05 +0200 (SAST)
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050418102332.A21081@flint.arm.linux.org.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-k6dbkKhtn3ArOlnK5BDF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-18 at 10:23 +0100, Russell King wrote:
> On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> > On Sun, 17 Apr 2005, Russell King wrote:
> > > I pulled it tonight into a pristine tree (which of course worked.)
> >=20
> > Goodie.
>=20
> Note the "pristine".  Now comes the real test...
>=20
> > > In doing so, I noticed that I'd messed up one of the commits - there'=
s
> > > a missing new file.  Grr.  I'll put that down to being a newbie git.
> >=20
> > Actually, you should put that down to horribly bad interface tools.  Wi=
th
> > BK, we had these nice tools that pointed out that there were files that
> > you might want to commit (ie "bk citool"), and made this very obvious.
> >=20
> > Tools absolutely matter. And it will take time for us to build up that=20
> > kind of helper infrastructure. So being newbie might be part of it, but=
=20
> > it's the smaller part, I say. Rough interfaces is a big issue.
>=20
> Ok, I just tried pulling your tree into the tree you pulled from, and
> got this:
>=20
> Tree change: e7905b2f22eb5d5308c9122b9c06c2d02473dd4f ee423ea56280512778a=
5961ee58a785a73acb7d1
> ...
> *100644->100644 blob    46f0a3caae02b4bb8f903d7ac86456aa0c37954b->ba4afd7=
956173b6f89eb6b0b9ad23b392d5c0aee      arch/arm/kernel/process.c
> *100644->100644 blob    4a36fa7192e11df36f5e0928b064239dabe1e305->ec0bc8f=
315ab5d78a4220e176e7aee76d52d1c74      arch/arm/kernel/traps.c
> *100644->100644 blob    311d19ee00208faf02359f9e7c5394577a40f253->bf923a9=
53703c6ca0c88eac3b2850cf07b838996      arch/arm/lib/changebit.S
> *100644->100644 blob    c07afa31695654e6489ec59c3f837183b325e9da->41f89b3=
a393d5af939f04f63c5bf4991b2bf6599      arch/arm/lib/clearbit.S
> ...
> Tracked branch, applying changes...
> Merging e7905b2f22eb5d5308c9122b9c06c2d02473dd4f -> ee423ea56280512778a59=
61ee58a785a73acb7d1
>         to df4449813c900973841d0fa5a9e9bc7186956e1e...
> COPYING: needs update
> CREDITS: needs update
> Documentation/00-INDEX: needs update
> Documentation/BK-usage/00-INDEX: needs update
> ...
> patching file arch/arm/kernel/process.c
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/kernel/proces=
s.c.rejpatching file arch/arm/kernel/traps.c
> Reversed (or previously applied) patch detected!  Skipping patch.
> 3 out of 3 hunks ignored -- saving rejects to file arch/arm/kernel/traps.=
c.rej
> patching file arch/arm/lib/changebit.S
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/changebit=
.S.rej
> patching file arch/arm/lib/clearbit.S
> Reversed (or previously applied) patch detected!  Skipping patch.
> 2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/clearbit.=
S.rej
>=20
> so obviously git pull isn't able to indentify what's already in the
> local repository.
>=20
> Interestingly, the files listed above as having rejects are excluded
> from the list of "needs update".  And I don't know why git is staying
> that these files need updating, because they haven't changed since
> they were initially checked out.
>=20
> This was with some random version of git-pasky-0.04.  Unfortunately,
> this version doesn't have the sha1 ID appended, so I couldn't say
> definitively that it's the latest and greatest.  It might be a day
> old.
>=20

gitmerge.sh does not yet have support for the new merge stuff as far as
I know, and if it does, then its a very recent version (ie, one that
have the sha1 ID appended).


--=20
Martin Schlemmer


--=-k6dbkKhtn3ArOlnK5BDF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY5aqqburzKaJYLYRAgQbAKCIGMsI8qOYcCLPzRc9uB+CGhJmoACeJHvh
6fugjTCYdQHEj3yx9Wau9Z4=
=vmgt
-----END PGP SIGNATURE-----

--=-k6dbkKhtn3ArOlnK5BDF--

