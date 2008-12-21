From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sun, 21 Dec 2008 15:13:22 -0600
Message-ID: <200812211513.26808.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <200812211359.31991.bss@iguanasuicide.net> <7vwsdtmg5m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2102758.dhLRhiygNJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 22:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEVeD-0006z9-6r
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbYLUVNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYLUVNN
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:13:13 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57486 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYLUVNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:13:13 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEVbq-0001iE-Ge; Sun, 21 Dec 2008 21:13:10 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vwsdtmg5m.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103710>

--nextPart2102758.dhLRhiygNJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 2008 December 21 14:23:17 Junio C Hamano wrote:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > Then why not have "-m 1" be assumed instead of forcing the user to
> > specify it?
>
> The reason we don't is because until very recently we did not even allow
> you to revert a merge relative to any parent.  We wanted to avoid
> surprising people who are _relying on_ that behaviour to make sure that
> they do not revert a merge by accident.

That makes sense.

> We could certainly do what you suggest to imply "-m 1" when the commit
> requested to be reverted happens to be a merge, but we shouldn't be doing
> that without thinking things through.  It will break people's longstanding
> expectations.

I wasn't really suggesting that.  I was pointing out what I thought was an=
=20
inconsistency: making the user specify the parent but not making the commit=
=20
message specify the parent.

I still think the parent we are reverting to should be mentioned in the=20
automatically generated commit message, even if it is the first parent.  Ev=
en=20
if it is decided to elide that information for the first parent, I agree=20
that, at least for now, the "-m" should still be required when reverting a=
=20
merge commit.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2102758.dhLRhiygNJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklOsXYACgkQdNbfk+86fC2vhQCdF53UEgo1YlvwwudpXo7D1ehY
5VcAn0Hwbl3BHI5LvMcRkk4IyRFhfXTM
=P/tW
-----END PGP SIGNATURE-----

--nextPart2102758.dhLRhiygNJ--
