From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/8] Support coverage testing with GCC/gcov
Date: Mon, 16 Feb 2009 12:09:28 +0100
Message-ID: <200902161209.34188.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch> <fb1e427bf56f5061634bc57fe6837f75e36c6cb2.1234736374.git.trast@student.ethz.ch> <vpq3aeeoh53.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2197367.CDGSA61Dj4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 16 12:11:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ1Ny-0007i2-Iv
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 12:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbZBPLJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 06:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbZBPLJu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 06:09:50 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:31469 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075AbZBPLJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 06:09:47 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 12:09:45 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 12:09:45 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <vpq3aeeoh53.fsf@bauges.imag.fr>
X-OriginalArrivalTime: 16 Feb 2009 11:09:45.0681 (UTC) FILETIME=[13300C10:01C99027]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110167>

--nextPart2197367.CDGSA61Dj4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Matthieu Moy wrote:
> detail:
>=20
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > With gcc's --coverage option, we can perform automatic coverage data
>=20
> I don't think gcc has a --coverage ...

Mine does:

  --coverage
    This option is used to compile and link code instrumented for
    coverage analysis.  The option is a synonym for -fprofile-arcs
    -ftest-coverage (when compiling) and -lgcov (when linking).  See
    the documentation for those options for more details.

> > +COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
> > +COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
>=20
> ... and this is not the one you are using anyway.

Indeed, I guess the log message is somewhat misleading.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2197367.CDGSA61Dj4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmZSW4ACgkQqUud07tmzP0ufgCgjkERasjk83f0yAjTb9ZkkHx6
DfgAnAovXyEng6Y+tozZRgvvIxMgaE3i
=JM6T
-----END PGP SIGNATURE-----

--nextPart2197367.CDGSA61Dj4--
