From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: Add long options for 'git describe'
Date: Sat, 26 Jul 2008 12:25:05 +0200
Message-ID: <200807261225.13949.trast@student.ethz.ch>
References: <1216980170-14136-1-git-send-email-trast@student.ethz.ch> <20080725131532.GB6701@neumann> <20080725162028.GB21117@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2224861.5xcSfJ6sOD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: SZEDER GGGbor <szeder@ira.uka.de>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 12:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMgyS-0002jU-1G
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 12:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYGZKZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 06:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYGZKZB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 06:25:01 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:43690 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbYGZKZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 06:25:00 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 26 Jul 2008 12:24:58 +0200
Received: from [192.168.0.4] ([84.75.148.145]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 26 Jul 2008 12:24:58 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080725162028.GB21117@spearce.org>
X-OriginalArrivalTime: 26 Jul 2008 10:24:58.0282 (UTC) FILETIME=[DAB0C0A0:01C8EF09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90203>

--nextPart2224861.5xcSfJ6sOD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Shawn O. Pearce wrote:
> SZEDER GGGbor <szeder@ira.uka.de> wrote:
> > >  _git_describe ()
> > >  {
> > > +	__git_has_doubledash && return
> > This line is superfluous, because 'git describe' does not have any path
> > arguments.
>=20
> Yup.  Aside from the two items described above (mising SOB line
> and the unnecessary double dash test) this patch looks fine.

I suppose you're right.  It does (empirically) attempt to parse
anything following a -- as a revision argument, but similar commands
like cherry-pick don't handle the -- specially either.

I'll resend a fixed version.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart2224861.5xcSfJ6sOD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiK+4kACgkQqUud07tmzP2pHwCfejQj2YfrL5rwSetafK4Uvk8A
2TIAn2knwXT3s34r5N/SwGi909YO9B7B
=d/bE
-----END PGP SIGNATURE-----

--nextPart2224861.5xcSfJ6sOD--
