From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sun, 15 Feb 2009 17:11:40 +0100
Message-ID: <200902151711.45099.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2047639.jZVmdqvNCi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 17:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYjcS-00030y-88
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 17:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZBOQL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 11:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbZBOQL4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 11:11:56 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28109 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbZBOQLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 11:11:55 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 17:11:53 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 17:11:53 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 15 Feb 2009 16:11:53.0584 (UTC) FILETIME=[1DD8C700:01C98F88]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110019>

--nextPart2047639.jZVmdqvNCi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > +	MSG=3D3 test_must_fail git notes edit
>=20
> test_must_fail is a shell function, and we have precedence 2d60615 (tests:
> Avoid single-shot environment export for shell function invocation,
> 2009-01-26) to avoid this construct.

Bah.  I really have a bad memory, don't I?

Is there a "bare minimum" POSIX shell that I can run the tests under,
to save myself such embarassment in the future?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2047639.jZVmdqvNCi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmYPsEACgkQqUud07tmzP22nACbBINaq5vP6M4bhVMl6fUdwtvc
wIIAoKOPEf0phGJdl/shceC8f4VRDsWK
=cozl
-----END PGP SIGNATURE-----

--nextPart2047639.jZVmdqvNCi--
