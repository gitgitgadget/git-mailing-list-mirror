From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 21:03:06 +0100
Message-ID: <20060323200306.GG31387@lug-owl.de>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 21:04:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMW2K-0004nA-D8
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWCWUDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 15:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWCWUDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 15:03:09 -0500
Received: from lug-owl.de ([195.71.106.12]:28098 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1422670AbWCWUDH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 15:03:07 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id 87748F003D; Thu, 23 Mar 2006 21:03:06 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17866>


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 17:28:23 -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 22 Mar 2006, Linus Torvalds wrote:
> > This one-liner to cvsps.c seems to make sure we have an ancestor branch=
=20
> > for that "gdb-4.18-branch" branch, at least according to the cvsps outp=
ut.=20
>=20
> The "git cvsimport" is still running, but at least it seems to be happily=
=20
> running further past the point it broke earlier.

I've started it once again, too, with the one-liner added to Debian
unstable's version of cvsps:

Fetching gas/ChangeLog   v 1.479
Update gas/ChangeLog: 250329 bytes
Tree ID a6b48ebac02a4158d37bab17c54c667223ecd971
Parent ID 4cabd2962031fd7ec6416580d84fb30a304969f3
Committed patch 3742 (origin 2000-07-29 03:23:31)
Commit ID 1910c20a44455db916a5c040663716a7389219bc
Fetching winsup/cygwin/fhandler.h   v 1.16
Update winsup/cygwin/fhandler.h: 25992 bytes
Fetching winsup/cygwin/include/cygwin/cygwin_dll.h   v 1.2
Update winsup/cygwin/include/cygwin/cygwin_dll.h: 3050 bytes
Fetching winsup/cygwin/lib/cygwin_crt0.c   v 1.5
Update winsup/cygwin/lib/cygwin_crt0.c: 926 bytes
Tree ID 0c2c7e9d0846e5f42b0bebad8b27ce439ddefb73
Parent ID 1910c20a44455db916a5c040663716a7389219bc
Committed patch 3743 (origin 2000-07-29 04:19:24)
Commit ID a15aac16f12061fbfef1be8f21b80a5076c8d605
Fetching winsup/cygwin/ChangeLog   v 1.235
Update winsup/cygwin/ChangeLog: 75391 bytes
Fetching winsup/cygwin/dtable.cc   v 1.11
Update winsup/cygwin/dtable.cc: 14399 bytes
Fetching winsup/cygwin/environ.cc   v 1.17
Update winsup/cygwin/environ.cc: 17190 bytes
Fetching winsup/cygwin/winsup.h   v 1.22
Update winsup/cygwin/winsup.h: 15828 bytes
Tree ID f777977c2b138952bc5a9bc431eec3de99a5f7db
Parent ID a15aac16f12061fbfef1be8f21b80a5076c8d605
Committed patch 3744 (origin 2000-07-29 16:01:23)
Commit ID 38b0ed94ef1c402b7b78ac6cad6c89ce189cd223
Switching from origin to #CVSPS_NO_BRANCH
usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<=
sha3>]])
read-tree failed: 33024

It seems there's a patch like
http://www.gelato.unsw.edu.au/archives/git/0602/16278.html is missing?
=2E..or we need a better cvsps.  Shall I add it and try again / try to
continue, or give up on it for now?  Though it would be nice to have
these two large and important source trees under GIT control :-)

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

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEIv76Hb1edYOZ4bsRAmtXAJ4k2XUVqDH9AJolZiiee5uWtSRmVwCgjigD
OLtNBGByxD0RZi8o3SgRfyM=
=KK/B
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
