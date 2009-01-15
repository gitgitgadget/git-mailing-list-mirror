From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional regular expression describing words
Date: Thu, 15 Jan 2009 01:32:11 +0100
Message-ID: <200901150132.14106.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142142120.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142145200.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7043887.G65GsccR0n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGAl-0004Wr-MX
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760785AbZAOAb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759153AbZAOAb7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:31:59 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42968 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757294AbZAOAb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:31:58 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:31:57 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:31:57 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901142145200.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Jan 2009 00:31:57.0163 (UTC) FILETIME=[AC279BB0:01C976A8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105739>

--nextPart7043887.G65GsccR0n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> 	This basically contains the fix I sent earlier.

Unfortunately I found another case where it breaks.  It even comes
with a fairly neat test case:

  $ g diff --no-index test_a test_b
  diff --git 1/test_a 2/test_b
  index 289cb9d..2d06f37 100644
  --- 1/test_a
  +++ 2/test_b
  @@ -1 +1 @@
  -(:
  +(
  $ g diff --no-index --color-words=3D'.' test_a test_b
  diff --git 1/test_a 2/test_b
  index 289cb9d..2d06f37 100644
  --- 1/test_a
  +++ 2/test_b
  @@ -1 +1 @@
  :(

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart7043887.G65GsccR0n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluhA4ACgkQqUud07tmzP0+NACgnXdhCdpd3R4sRF3vxb8Lrtl6
7zoAnj5Bw2BovtQB8WhfbbTxOblMYSNa
=8L9P
-----END PGP SIGNATURE-----

--nextPart7043887.G65GsccR0n--
