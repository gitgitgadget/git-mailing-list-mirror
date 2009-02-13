From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading mbox message
Date: Sat, 14 Feb 2009 00:32:15 +0100
Message-ID: <200902140032.19922.trast@student.ethz.ch>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3331699.6D8k0qFj0A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 00:33:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY7Xg-0002ap-L1
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbZBMXc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbZBMXc3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:32:29 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:57335 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbZBMXc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:32:28 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 00:32:27 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 00:32:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
X-OriginalArrivalTime: 13 Feb 2009 23:32:26.0873 (UTC) FILETIME=[547D1690:01C98E33]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109785>

--nextPart3331699.6D8k0qFj0A
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jay Soffian wrote:
> -			if (/^(Signed-off-by|Cc): (.*)$/i) {
> -				next if ($suppress_cc{'sob'});
[...]
> +		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +			next if ($suppress_cc{'sob'});

Doesn't this actually look like a long-standing send-email bug?  Since
6564828 (git-send-email: Generalize auto-cc recipient mechanism.,
2007-12-25) they should go in separate categories, but the above lines
were just translated from the old $signed_off_cc setting.  It seems
they should distinguish between SOB and Cc.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3331699.6D8k0qFj0A
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmWAwMACgkQqUud07tmzP22IgCfXEeOJZc9wwzxKvHKWpg0feWR
lb0An24P3ArV3t1RN8VxUJcLznbk/g/P
=bRRK
-----END PGP SIGNATURE-----

--nextPart3331699.6D8k0qFj0A--
