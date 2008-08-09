From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Sat, 9 Aug 2008 11:35:25 +0200
Message-ID: <200808091135.28249.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <7viqub9dzi.fsf@gitster.siamese.dyndns.org> <200808091125.48897.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3472915.EjgLGiJvko";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 11:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRks2-00008p-UK
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 11:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbYHIJfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 05:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbYHIJfU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 05:35:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:29600 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYHIJfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 05:35:19 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 11:35:18 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 11:35:17 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200808091125.48897.trast@student.ethz.ch>
X-OriginalArrivalTime: 09 Aug 2008 09:35:17.0838 (UTC) FILETIME=[3BFD96E0:01C8FA03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91759>

--nextPart3472915.EjgLGiJvko
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Junio C Hamano wrote:
> >=20
> > Perhaps --full-history is needed to the rev-list call (and the recent
>=20
> But --full-history cannot solve this problem; it would entirely defeat
> the point of --subdirectory-filter.  (I haven't looked into what
> --simplify-merges does yet.)

Actually, on this point I stand corrected, in some tests it has a good
effect.  I'll look into it.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart3472915.EjgLGiJvko
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkidZOAACgkQqUud07tmzP2x2ACgitAne8qO1jHJbJOdOsYbqnnr
HV0AmgKlbICriMzRa8nDH2VmCYZp2Xs5
=VW5L
-----END PGP SIGNATURE-----

--nextPart3472915.EjgLGiJvko--
