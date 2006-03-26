From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Add git-explode-packs
Date: Sun, 26 Mar 2006 14:54:50 +0200
Message-ID: <20060326125450.GT31387@lug-owl.de>
References: <11432881443149-git-send-email-matlads@dsmagic.com> <7vwtehpwdd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OowMmFE4aK71mEhh"
Cc: Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 14:54:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNUlk-0000cN-Nq
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 14:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCZMyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 07:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWCZMyw
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 07:54:52 -0500
Received: from lug-owl.de ([195.71.106.12]:23985 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932073AbWCZMyw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 07:54:52 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id E8C65F0032; Sun, 26 Mar 2006 14:54:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtehpwdd.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18038>


--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-03-25 22:12:46 -0800, Junio C Hamano <junkio@cox.net> wrote:
> Martin Atukunda <matlads@dsmagic.com> writes:
> > This script does the opposite of git repack -a -d.
>=20
> The script seems to do what it claims to, but now why would one
> need to use this?  In other words what's the situation one would
> find this useful?

It's possibly useful if you oftenly access old objects with
git-cat-file or git-ls-tree.

Not being a Perl hacker, a friend and I eg. started to hack GIT
support into LXR. I've just posted some very early patches on the LXR
mailing list
(http://sourceforge.net/mailarchive/forum.php?forum_id=3D1734). What
would be even more interesting is to not unpack _all_ objects, but
only those belonging to specifically mentioned commits or tags. I
think LXR could make _good_ use of that.

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

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEJo8aHb1edYOZ4bsRAgjCAKCAXZapOEp44a+qkhbbeCJ/w7A8TwCfVbDP
JIhmRiq60suCIvFBG83OZio=
=M9HJ
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--
