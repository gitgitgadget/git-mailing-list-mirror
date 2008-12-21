From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sun, 21 Dec 2008 13:59:14 -0600
Message-ID: <200812211359.31991.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <200812202111.17831.bss@iguanasuicide.net> <200812211109.36788.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9782748.Cv6txiLDXj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEUTc-0002p7-Qm
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 21:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbYLUT7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYLUT7S
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 14:59:18 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:43500 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYLUT7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 14:59:17 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEUSJ-0001fV-3x; Sun, 21 Dec 2008 19:59:15 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <200812211109.36788.robin.rosenberg.lists@dewire.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103708>

--nextPart9782748.Cv6txiLDXj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 2008 December 21 04:09:36 Robin Rosenberg wrote:
> s=F6ndag 21 december 2008 04:11:13 skrev Boyd Stephen Smith Jr.:
> > On Saturday 2008 December 20 20:37:16 Junio C Hamano wrote:
> > > Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> > > > An alternative, would be "removing changes relative to .."
> > > > (mainline).
> > >
> > > But that is exactly what "This reverts commit X" means, isn't it?
> >
> > When X is a merge commit, the phrase "the reverts commit X" is ambiguou=
s.
> >  Did you revert the tree to X^, X^2, or X^8?  I'd be fine with "This
> > reverts commit X to X^y", but we definitely need some mention of X^y.
>
> One could consider keeping the contributions from ^1 a special case and n=
ot
> mention the parent, making it look like any revert commit. I guess most
> merge reverts are like this in practice.

Then why not have "-m 1" be assumed instead of forcing the user to specify =
it? =20
If we force the user to specify that information, shouldn't we hold the cod=
e=20
to the same standard and have it output a message with that information?

I think git should mention the parent to which we reverted whenever there a=
re=20
multiple parents.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart9782748.Cv6txiLDXj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklOoCMACgkQdNbfk+86fC1nRQCeIKob9ZsWg3fDf5x3ov7nXous
+rwAnj7n21wJ9wWtpIvHAUyW2Xduzxjf
=M9K0
-----END PGP SIGNATURE-----

--nextPart9782748.Cv6txiLDXj--
