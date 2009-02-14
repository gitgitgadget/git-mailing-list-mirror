From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading mbox message
Date: Sat, 14 Feb 2009 17:57:14 +0100
Message-ID: <200902141757.17983.trast@student.ethz.ch>
References: <200902140032.19922.trast@student.ethz.ch> <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1447749.e83vWaDMoR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYO0x-0001RS-0H
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbZBNQ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 11:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbZBNQ52
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:57:28 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:3301 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbZBNQ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:57:28 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 17:57:27 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 17:57:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
X-OriginalArrivalTime: 14 Feb 2009 16:57:26.0506 (UTC) FILETIME=[5061D4A0:01C98EC5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109883>

--nextPart1447749.e83vWaDMoR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jay Soffian wrote:
> From: Jay Soffian <jaysoffian@gmail.com>
>=20
> On Fri, Feb 13, 2009 at 6:32 PM, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> > Jay Soffian wrote:
> >> -                     if (/^(Signed-off-by|Cc): (.*)$/i) {
> >> -                             next if ($suppress_cc{'sob'});
> > [...]
> >> +             if (/^(Signed-off-by|Cc): (.*)$/i) {
> >> +                     next if ($suppress_cc{'sob'});
> >
> > Doesn't this actually look like a long-standing send-email bug?  Since
> > 6564828 (git-send-email: Generalize auto-cc recipient mechanism.,
> > 2007-12-25) they should go in separate categories, but the above lines
> > were just translated from the old $signed_off_cc setting.  It seems
> > they should distinguish between SOB and Cc.
>=20
> This is fixed by the last patch in this series. While I was working on
> it I noticed two other minor issues, which is the first two patches.

Thanks for the fix, and sorry if this was the comment that inspired
your venting earlier.  I should've tried a patch myself, but it was
already past midnight.  I'll send a slightly improved version of 3/3
shortly.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1447749.e83vWaDMoR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmW9+0ACgkQqUud07tmzP1qVwCcDlM1O7nwIQ+ZdgiJ9o+D2VQT
cCsAoKKgNizVH7xxz2kQqOFdbx91kBY/
=YyHn
-----END PGP SIGNATURE-----

--nextPart1447749.e83vWaDMoR--
