From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 20:58:56 +0100
Message-ID: <200901142059.09005.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <87ljtdk9b3.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart41069163.AEifkUtaSX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBuT-0005Qg-Iu
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbZANT6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbZANT6y
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:58:54 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:8260 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbZANT6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:58:53 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 20:58:52 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 20:58:51 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87ljtdk9b3.fsf@iki.fi>
X-OriginalArrivalTime: 14 Jan 2009 19:58:51.0955 (UTC) FILETIME=[85CF4830:01C97682]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105690>

--nextPart41069163.AEifkUtaSX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Teemu Likonen wrote:
>     -aaa (aaa)
>     +aaa (aaa) aaa

Bug aside, examples like this one make me wonder if we should force a
"last resort" match for `[^[:space:]]`.  For example,

      -aaa [aaa]
      +aaa (aaa) aaa

would still give you

      aaa (aaa)<GREEN> aaa<RESET>

which may be unexpected.

Of course, when diffing a language where something other than the
"usual" whitespace should be ignored, this behaviour would be useful.


=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch




--nextPart41069163.AEifkUtaSX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluRAwACgkQqUud07tmzP11cACeLZR8oB+gUpjHIXnboh8nK1fN
57IAoICBcaqajNlOigVTBvK3WKnv5q+X
=atd2
-----END PGP SIGNATURE-----

--nextPart41069163.AEifkUtaSX--
