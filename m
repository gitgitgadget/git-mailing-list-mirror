From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git has modified files after clean checkout
Date: Thu, 1 Jan 2009 20:48:11 +0100
Message-ID: <200901012048.13630.trast@student.ethz.ch>
References: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com> <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com> <81bfc67a0901010048l7a4a8fa1h42f7cd448dfc704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2348157.3rTgSgzC7f";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Caleb Cushing" <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 20:49:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LITXl-0004HO-Cl
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 20:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbZAATsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 14:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbZAATsB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 14:48:01 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:41046 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbZAATsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 14:48:01 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 20:47:58 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 20:47:57 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <81bfc67a0901010048l7a4a8fa1h42f7cd448dfc704@mail.gmail.com>
X-OriginalArrivalTime: 01 Jan 2009 19:47:58.0005 (UTC) FILETIME=[D8A7AE50:01C96C49]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104313>

--nextPart2348157.3rTgSgzC7f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Caleb Cushing wrote:
> >  The files you mention contain CRLF.  Do you have core.autocrlf set
> >  globally somewhere, perhaps in your ~/.gitconfig?
>=20
> yes I have it set to input

Do you have any .gitattributes?  A few days ago, ludde on IRC bumped
into the problem that git-checkout applies the .gitattributes that are
present in the tree *before* the checkout.  Naturally this means that
the .gitattributes do not apply at all during the first checkout at
the end of cloning.  In ludde's case, this caused git-blame to think
the file had all line endings changed compared to the index version.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart2348157.3rTgSgzC7f
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkldHf0ACgkQqUud07tmzP1fjQCfQnbgJ2VOm9i2tnjNMokziDxK
tcMAn0yx5fNsOw9aKYyxZYz9oLAoo90K
=6QZq
-----END PGP SIGNATURE-----

--nextPart2348157.3rTgSgzC7f--
