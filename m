From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Thu, 18 Dec 2008 23:54:12 -0600
Message-ID: <200812182354.16269.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <200812182129.01021.bss@iguanasuicide.net> <76718490812181955u5f56180en47b3a8268c3538bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2848257.fiqbHVTsNM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 06:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDYKe-0001Ns-CB
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 06:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYLSFyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 00:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbYLSFyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 00:54:09 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52780 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYLSFyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 00:54:08 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDYJH-0006Fa-UW; Fri, 19 Dec 2008 05:54:04 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <76718490812181955u5f56180en47b3a8268c3538bb@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103547>

--nextPart2848257.fiqbHVTsNM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 18 21:55:13 Jay Soffian wrote:
> On Thu, Dec 18, 2008 at 10:29 PM, Boyd Stephen Smith Jr.
>
> <bss@iguanasuicide.net> wrote:
> > At least, it might make someone read the manpage again.  Still, I'm
> > unhappy with the message, but I didn't want to be too wordy.  A URL or
> > manpage reference would be nice, but I didn't know of a good guide that
> > explained the dangers of reverting a merge commit as well as Linus's
> > emails.
>
> Put his email in Documentation/howto/undoing-merge-commits.txt and
> reference that?

Okay, I've got a documentation patch brewing, but it's too late here to wor=
k=20
on it more.  I'll post it over the weekend.

In addition, I think a one-time-per-user warning would be nice, but I'm not=
=20
sure the best way to implement that.  My initial thoughts would be reading =
a=20
boolean config option, if unset/true issuing the warning and then if unset=
=20
set it to false.  However, that seems a bit... unclean and I fear there mig=
ht=20
be a policy against writing ~/.gitconfig configuration options from a=20
subcommand other than 'git config'.  Any suggestions on the implementation?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2848257.fiqbHVTsNM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklLNwgACgkQdNbfk+86fC3skQCeIqWh7vK4XGkyq5SWkV18+8TL
PIAAnRWUjesmkS48ZQmHIeBA7VmEWuh1
=pDKh
-----END PGP SIGNATURE-----

--nextPart2848257.fiqbHVTsNM--
