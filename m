From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: gitk: cache line for unreachable rev causing error
Date: Wed, 1 Jul 2009 20:24:47 +0200
Message-ID: <200907012024.52287.trast@student.ethz.ch>
References: <200906291119.10897.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1623160.eFGLx0UXgj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM4UZ-0004wL-Af
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 20:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbZGASY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZGASY5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 14:24:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:43349 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbZGASY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 14:24:56 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 20:24:59 +0200
Received: from thomas.localnet ([77.58.131.161]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 20:24:58 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.95; x86_64; ; )
In-Reply-To: <200906291119.10897.trast@student.ethz.ch>
X-OriginalArrivalTime: 01 Jul 2009 18:24:58.0958 (UTC) FILETIME=[3DAE26E0:01C9FA79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122590>

--nextPart1623160.eFGLx0UXgj
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
>=20
> Running gitk in one of my repositories always results in the error
>=20
>   can't read "arcnos()": no such element in array
[...]
> Unfortunately, this repository contains problem sets for an ACM-style
> exam that I'm working on, so I cannot share it, and rewriting+pruning
> it in any way lets the bug disappear.

Thanks to another suggestion by Ilari, this history is now available
in a tree- and message-less form at

  http://thomasrast.ch/download/gitk-arcnos-bug.tar.bz2

Just unpack it and invoke 'gitk', it should show the above error.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1623160.eFGLx0UXgj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkpLqfQACgkQqUud07tmzP060QCeKjYHbyL9NDP2IcyQjXeQc2jC
WogAoKJUutB7jDiMMOP4gNA7B3xiIK4d
=m6+f
-----END PGP SIGNATURE-----

--nextPart1623160.eFGLx0UXgj--
