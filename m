From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional regular expression describing words
Date: Thu, 15 Jan 2009 09:30:35 +0100
Message-ID: <200901150930.38100.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901150211120.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901150235122.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart123204225.GDLkxNI1Ue";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNNdk-0006em-4W
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 09:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114AbZAOIaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 03:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756933AbZAOIaW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 03:30:22 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:25744 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638AbZAOIaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 03:30:21 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:30:19 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:30:19 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901150235122.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Jan 2009 08:30:19.0193 (UTC) FILETIME=[7FE5D290:01C976EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105773>

--nextPart123204225.GDLkxNI1Ue
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> If a hunk header '@@ -2 +1,0 @@' is found that logically should be
> '@@ -2 +2,0 @@', diff_words got confused.
[...]
> This might be a libxdiff issue, though.

Looks like it's just bug-for-bug compatible with diff.  At least my
GNU diffutils 2.8.7 show the same behaviour.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart123204225.GDLkxNI1Ue
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklu9C4ACgkQqUud07tmzP36ywCgkIU55RSxxIZHokN/20TD0Xfs
m3EAn23WYO6Te6uzEewtd/lM4aX06OMd
=aEBM
-----END PGP SIGNATURE-----

--nextPart123204225.GDLkxNI1Ue--
