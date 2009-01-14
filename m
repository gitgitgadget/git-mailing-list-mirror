From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 21:04:13 +0100
Message-ID: <200901142104.16134.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2046782.oNptaVG3nY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBzT-0007N2-Uw
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbZANUED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZANUEB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:04:01 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:54136 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836AbZANUEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 15:04:00 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 21:03:59 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 21:03:59 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 20:03:59.0084 (UTC) FILETIME=[3CDF72C0:01C97683]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105694>

--nextPart2046782.oNptaVG3nY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> The only "funny" thing I realized is that the lines which are output
> by emit_line() add a RESET at the end of the line, and I do not do that
> in color_fwrite_lines().

Umm.... but you seem to do?

Ack on the new regex semantics, though I'd have implemented it via
dying on '\n' instead of silently splitting there (and restarting a
new match!).  [I actually _have_ implemented it, but your patch beat
me to it. :-)]

Thus, Ack on 4/4 once the boundary bug is fixed.  Thanks for your
work!

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart2046782.oNptaVG3nY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluRUAACgkQqUud07tmzP3ZoACglHQF3yvEHD7//0cipbSgx/h8
PWMAn2qidPcLNLYUEQZQE2rdqMHakHZk
=gNch
-----END PGP SIGNATURE-----

--nextPart2046782.oNptaVG3nY--
