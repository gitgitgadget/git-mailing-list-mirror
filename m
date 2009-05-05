From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Tue, 5 May 2009 11:55:17 +0200
Message-ID: <200905051155.28985.trast@student.ethz.ch>
References: <20090505091302.GB27900@frsk.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1465569.mXkX68dU9K";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Tue May 05 12:12:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1HdD-0007xg-Rj
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 12:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbZEEKL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 06:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbZEEKL3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 06:11:29 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11613 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610AbZEEKL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 06:11:28 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2009 06:11:28 EDT
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 11:56:14 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 11:56:13 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <20090505091302.GB27900@frsk.net>
X-OriginalArrivalTime: 05 May 2009 09:56:13.0905 (UTC) FILETIME=[B9C8F410:01C9CD67]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118287>

--nextPart1465569.mXkX68dU9K
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46redrik Skolmli wrote:
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -23,6 +23,9 @@ example, be useful to remove all build products.
>  If any optional `<path>...` arguments are given, only those paths
>  are affected.
> =20
> +If no arguments are given, the cleaning is recursive, starting at the cu=
rrent
> +path.

That makes it sound as if the <path> case was not recursive, but it
is!

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1465569.mXkX68dU9K
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoADRAACgkQqUud07tmzP1c5QCfUQa7m2JScKOnHImm9GdnRh3w
UZMAniMY4tyoGWyZ0DXMUp0DRBsgWxY4
=euAc
-----END PGP SIGNATURE-----

--nextPart1465569.mXkX68dU9K--
