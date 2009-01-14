From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] color-words: make regex configurable via attributes
Date: Wed, 14 Jan 2009 21:17:59 +0100
Message-ID: <200901142118.02041.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <1231962401-26974-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1249391.aRImQasybj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNCCm-0004o7-P1
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbZANURs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbZANURr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:17:47 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10985 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280AbZANURq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 15:17:46 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 21:17:45 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 21:17:45 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 20:17:45.0032 (UTC) FILETIME=[292D1C80:01C97685]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105698>

--nextPart1249391.aRImQasybj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> How about making this an extra paragraph?

Sure, why not.  Though I'm still in favour of taking some longer
version, possibly from my old series.

> On Wed, 14 Jan 2009, Thomas Rast wrote:
> > +- `cpp` suitable for source code in the C and C++ languages.
> > +
>=20
> How about "written in C or C++"?

I was just trying to be consistent with all other items; all
programming languages are listed as "Foo language".

> > +A built-in pattern is provided for all languages listed in the last
> > +section.
>=20
> Wow.  But how about "previous section"?

Indeed, thanks.

> > +#define PATTERNS(name, pattern, wordregex)			\
> > +	{ name, NULL, -1, { pattern, REG_EXTENDED }, NULL, wordregex }
>=20
> You could get rid of that NULL if...
[...]
> ... you inserted word_regex before textconv.  In a way, I find this more=
=20
> logical, since both funcname and word_regex have sensible defaults=20
> (provided by you), whereas textconv is strictly a user's option.

Ok, I'll do that.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1249391.aRImQasybj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluSHoACgkQqUud07tmzP0AsACgoSQWfb7tdkO6looqfACOwAGf
QhIAniDwWyzNwY8DMRpm9bnEqks+Znbt
=tVRj
-----END PGP SIGNATURE-----

--nextPart1249391.aRImQasybj--
