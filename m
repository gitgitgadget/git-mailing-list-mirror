From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 18:24:07 +0200
Message-ID: <20060709162407.GV22573@lug-owl.de>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <20060709095114.GQ22573@lug-owl.de> <7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net> <200607091441.16161.michal.rokos@nextsoft.cz> <86ejwuuba2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cqG5pBpskktEuCrX"
Cc: Michal Rokos <michal.rokos@nextsoft.cz>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 18:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzc4s-0007OV-Tg
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 18:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWGIQYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 12:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGIQYK
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 12:24:10 -0400
Received: from lug-owl.de ([195.71.106.12]:1483 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751311AbWGIQYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 12:24:09 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 916F7F0260; Sun,  9 Jul 2006 18:24:07 +0200 (CEST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86ejwuuba2.fsf@blue.stonehenge.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23558>


--cqG5pBpskktEuCrX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-09 07:02:13 -0700, Randal L. Schwartz <merlyn@stonehenge.co=
m> wrote:
> >>>>> "Michal" =3D=3D Michal Rokos <michal.rokos@nextsoft.cz> writes:
>=20
> Michal> I have no problem with that. I can set $PATH.
> Michal> But then I'd suggest to change magic #!
> Michal> from #!/usr/bin/perl
> Michal> to #!/usr/bin/env perl
> Michal> for *.perl
>=20
> Michal> It that what you meant?
>=20
> No, don't do that.  Use the path to Perl that they chose during
> configuration because
>=20
> (a) it might not be the first one in PATH

If you want to execute some binary that's not first in path, you'd
better *always* call that explicit.

> (b) even if it's the first one in *my* path, it might not be the
>     first one in *everyone's* path

Communication problem. Machine's administrator should offer a working
git installation. If a user chooses to build his own git, he'd better
make sure that all the environment is properly set-up, too.

> (c) env requires an *extra* fork/exec

Only an extra exec.

> (d) some systems don't have env

Huh? Show me a system that has no /usr/bin/env, but a working POSIX
shell in /bin/sh .

> The env hack is a nice hack, but it's just a hack.  Don't
> rely on it when the right thing is nearby.

What's the right thing? The right thing is to explicitely call the
interpreter, not using the shellbang at all.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--cqG5pBpskktEuCrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsS2nHb1edYOZ4bsRAmelAKCRXxhuMvCcN6HdTRUrrVMUqtt9ZwCdErGT
B4RD4GZZfmoUSTeNQ3Iten0=
=3hCH
-----END PGP SIGNATURE-----

--cqG5pBpskktEuCrX--
