From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3] send-email: --suppress-cc improvements
Date: Sat, 14 Feb 2009 23:21:11 +0100
Message-ID: <200902142321.22904.trast@student.ethz.ch>
References: <7vzlgpzfru.fsf@gitster.siamese.dyndns.org> <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1295549.zrAdzidnjz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSub-0005ay-Ms
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbZBNWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbZBNWVd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:21:33 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38870 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbZBNWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:21:32 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 23:21:31 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 23:21:30 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 22:21:31.0131 (UTC) FILETIME=[964824B0:01C98EF2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109940>

--nextPart1295549.zrAdzidnjz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I just noticed that I lost the comments after '---' due to repeated
format-patch'ing, so here goes:

Thomas Rast wrote:
> From: Jay Soffian <jaysoffian@gmail.com>
>=20
> Since 6564828 (git-send-email: Generalize auto-cc recipient
> mechanism., 2007-12-25) we can suppress automatic Cc generation
> separately for each of the possible address sources.  However,
> --suppress-cc=3Dsob suppressed both SOB lines and body (but not header)
> Cc lines, contrary to the name.
>=20
> Change --suppress-cc=3Dsob to mean only SOB lines, and add separate
> choices 'bodycc' (body Cc lines) and 'body' (both 'sob' and 'bodycc').
> The option --no-signed-off-by-cc now acts like --suppress-cc=3Dsob,
> which is not backwards compatible but matches the name of the option.
>=20
> Also update the documentation and add a few tests.
>=20
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

I tried to address Junio's comments, mostly by reformatting the docs
and expanding the tests, but also changing the handling of 'body' in
the code.  I also edited the patch message to my liking.

Of course your SOB above is now forged, so you'll have to ack it.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1295549.zrAdzidnjz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmXQ+IACgkQqUud07tmzP1hswCfda07SKqJI2sKbWWkdLmSNc+d
EncAn3Ee4p0ce0+lhlOUOTY0ng2JNeY8
=oaVb
-----END PGP SIGNATURE-----

--nextPart1295549.zrAdzidnjz--
