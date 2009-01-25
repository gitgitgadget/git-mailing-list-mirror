From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] rebase -i --root: simplify code
Date: Mon, 26 Jan 2009 00:53:03 +0100
Message-ID: <200901260053.06315.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901260029480.14855@racer> <alpine.DEB.1.00.0901260031460.14855@racer> <200901260049.25563.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3047796.B9pkgpXj1m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREoE-0006pE-58
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZAYXxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZAYXxK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:53:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:28789 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbZAYXxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:53:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 00:53:07 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 00:53:07 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <200901260049.25563.trast@student.ethz.ch>
X-OriginalArrivalTime: 25 Jan 2009 23:53:07.0739 (UTC) FILETIME=[1240F6B0:01C97F48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107142>

--nextPart3047796.B9pkgpXj1m
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
>           test ! -s "$DOTEST"/upstream && REBASE_ROOT=3Dt

Actually, I think that test never worked (and it's clearly my fault).

The corresponding 'echo $UPSTREAM > "$DOTEST"/upstream' just expanded
to 'echo > ...', resulting in a file containing a single newline, but
never a zero-length file.  Duh.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3047796.B9pkgpXj1m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl8+2IACgkQqUud07tmzP0oPgCeIhhSnoVjv9XWPZ7wbHL+kOJG
o8QAnR4DQt+I765uGg+m1Unq1YiiACzO
=9Z6d
-----END PGP SIGNATURE-----

--nextPart3047796.B9pkgpXj1m--
