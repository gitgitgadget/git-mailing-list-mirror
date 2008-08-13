From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] rebase -i -p: handle index and workdir correctly
Date: Wed, 13 Aug 2008 12:07:29 +0200
Message-ID: <200808131207.31616.trast@student.ethz.ch>
References: <200808121116.41535.trast@student.ethz.ch> <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1538097.4o8XiOEC8V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDHG-0004CP-E4
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYHMKHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbYHMKHY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:07:24 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:54779 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbYHMKHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:07:23 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:07:22 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:07:21 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Aug 2008 10:07:21.0967 (UTC) FILETIME=[60835FF0:01C8FD2C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92203>

--nextPart1538097.4o8XiOEC8V
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> -		test $preserve =3D f || echo $sha1 > "$REWRITTEN"/$sha1
> +		output git reset --hard $sha1 ||
> +			die "Cannot fast forward to $sha1"

Doh.  I obviously shouldn't try to split patches before lunch.

Please disregard, I'll fix and resend when I get back.

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1538097.4o8XiOEC8V
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiismMACgkQqUud07tmzP0rLACeMce+TgsgFIF+bvbTlxsjuHN7
eaIAoISfh0NsuzAING7CyitHz5xnk84c
=bMLv
-----END PGP SIGNATURE-----

--nextPart1538097.4o8XiOEC8V--
