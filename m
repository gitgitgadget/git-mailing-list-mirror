From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 01:47:46 +0100
Message-ID: <200810270147.52490.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com> <200810261955.10536.jnareb@gmail.com>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13630594.3rsucW0HAm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, SLONIK.AZ@gmail.com,
	git@vger.kernel.org
To: mercurial@selenic.com
X-From: git-owner@vger.kernel.org Mon Oct 27 01:49:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuGII-0007vX-4m
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 01:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYJ0AsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 20:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYJ0AsA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 20:48:00 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36458 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYJ0AsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 20:48:00 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5694AF524953;
	Mon, 27 Oct 2008 01:47:58 +0100 (CET)
Received: from [217.227.126.165] (helo=fluss.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuGGz-0000Vt-00; Mon, 27 Oct 2008 01:47:58 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <200810261955.10536.jnareb@gmail.com>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX18VoYLWwIRxQzgCE3sFZ5uewZxdcuAHb06/mXEs
	/FMCmo5DFPKcOYfKRWn7/2fppQeMA1+cJqAmURCLuF71Jq3gk8
	6wrjYbg6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99195>

--nextPart13630594.3rsucW0HAm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
> I agree, and I think it is at least partially because of Git having
> cleaner design, even if you have to understand more terms at first.

What do you mean by "cleaner design"?=20

=46rom what I see (and in my definition of "design"), Mercurial is designed=
 as=20
VCS with very clear and clean design, which even keeps things like streamin=
g=20
disk access in mind.=20

Also, looking at git, git users still have to garbage collect regularly, wh=
ich=20
shows to me that the design wasn't really cleaner.=20

As an example: If I want some revision in hg, my repository just reads the=
=20
files in the store, jumps to the latest snapshots, adds the changes after=20
these and has the data.=20

In git is has to check all changesets which affect the file.=20

If you read the hgbook, you'll find one especially nice comment:=20

"Unlike many revision control systems, the concepts upon which Mercurial is=
=20
built are simple enough that it=E2=80=99s easy to understand how the softwa=
re really=20
works. Knowing this certainly isn=E2=80=99t necessary, but I find it useful=
 to have a=20
=E2=80=9Cmental model=E2=80=9D of what=E2=80=99s going on."
=2D http://hgbook.red-bean.com/hgbookch4.html

I really like that, and in my opinion it is a great compliment to hg, for t=
wo=20
reasons:=20

1) Hg is easy to understand
2) You don't have to understand it to use it

And both are indications of a good design, the first of the core, the secon=
d=20
of the UI.=20

Best wishes,=20
Arne

=2D- My stuff: http://draketo.de - stories, songs, poems, programs and stuf=
f :)
=2D- Infinite Hands: http://infinite-hands.draketo.de - singing a part of t=
he=20
history of free software.
=2D- Ein W=C3=BCrfel System: http://1w6.org - einfach saubere (Rollenspiel-=
) Regeln.

=2D- PGP/GnuPG: http://draketo.de/inhalt/ich/pubkey.txt

--nextPart13630594.3rsucW0HAm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkFD7gACgkQMwdGm/6WxASn1gCg1Urys7fJFoAkQ8OqyejBNR1V
ev8AoIP2A9efSwPuyvWIQgkBtC+bCdLH
=evGQ
-----END PGP SIGNATURE-----

--nextPart13630594.3rsucW0HAm--
