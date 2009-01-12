From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [kde] kde konsole color settings in terminal
Date: Mon, 12 Jan 2009 16:18:48 -0600
Message-ID: <200901121618.52636.bss@iguanasuicide.net>
References: <82fa9e310901121335p4bd1e223x8eea1881c0add364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4783728.gItxm6Mc30";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: kde@mail.kde.org, git@vger.kernel.org
To: mark <markkicks@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMV8a-0003Sw-Hh
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbZALWSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbZALWSQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:18:16 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:47857 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZALWSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:18:15 -0500
Received: from [63.167.79.33]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMV6p-0004BO-5Q; Mon, 12 Jan 2009 22:18:11 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <82fa9e310901121335p4bd1e223x8eea1881c0add364@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105401>

--nextPart4783728.gItxm6Mc30
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 15:35:08 mark wrote:
>i am using kde konsole, and i am getting weird output for colors, for
>example for git log i get the following output
>
>git log
>ESC[33mcommit 8b918256d944221f741e5d7300873810e31466a6ESC[m

Looks like konsole isn't interpreting the color codes.  However, it also lo=
oks=20
like git doesn't use termcap/terminfo/etc. to determine the correct way to=
=20
write colors for your terminal and just defaults to ANSI.

Do you get odd output from:
grep --color=3Dalways o <<< foo
or are the "o"s properly colored red?

>settings in my bash and git.
>
>export | grep -i term
>declare -x TERM=3D"xterm-256color"

So you have a /usr/share/terminfo/k/konsole-256color file?  If so, it might=
 be=20
better to use TERM=3D"konsole-256color".

I never use 256 color mode, so I'm not clear on how that works.  However, w=
hat=20
git is outputting look more like ANSI 16-color codes.

Does this work as you expect in other terminal applications (like rxvt or=20
xterm or gnome-terminal) with the same settings for TERM?

Just to let you know, it works here (openSUSE 11.1) with Konsole 1.6.6 (KDE=
=20
3.5.10) running git 1.6.0.2 inside screen 4.00.02
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4783728.gItxm6Mc30
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklrwcwACgkQdNbfk+86fC1dXgCfUIe8Sjw8pVrsRtXEjJ654+qT
jbAAn2u6s3amRRCnXeFX14/bQAQ2DhmG
=zpF5
-----END PGP SIGNATURE-----

--nextPart4783728.gItxm6Mc30--
