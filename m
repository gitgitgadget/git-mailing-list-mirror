From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 16:39:33 +0100
Message-ID: <200902171639.35926.trast@student.ethz.ch>
References: <20090217060944.488184b0.chriscool@tuxfamily.org> <43d8ce650902170711r1edb1e40udfacce4b9123b0a5@mail.gmail.com> <alpine.DEB.1.00.0902171630130.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2530276.6s5Mxqv8GI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZS4t-00028J-Ak
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZBQPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBQPjt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:39:49 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24948 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315AbZBQPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:39:48 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 16:39:47 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 16:39:46 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902171630130.6185@intel-tinevez-2-302>
X-OriginalArrivalTime: 17 Feb 2009 15:39:47.0034 (UTC) FILETIME=[F65C13A0:01C99115]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110403>

--nextPart2530276.6s5Mxqv8GI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> > unsigned int log2_integer_approximate(unsigned int n){
[...]
> That assumes that your floats are IEEE floats, right?

=46or extra weird code, you could the standard 5-line bit order inverter
and apply ffs().

;-)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2530276.6s5Mxqv8GI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkma2jcACgkQqUud07tmzP3yBgCfXqgvPYXPVN3+qNWEvW2MrNhy
2/EAn2kHNol2bTfg+fZmeBSlgz1K/4Gl
=yLah
-----END PGP SIGNATURE-----

--nextPart2530276.6s5Mxqv8GI--
