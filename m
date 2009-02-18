From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 18:05:36 +0100
Message-ID: <200902181805.44145.trast@student.ethz.ch>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org> <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com> <F21AE3A2-480B-4311-81E7-32B75B49A356@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2903955.pk0e24Epaa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZptQ-0005Cm-4J
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZBRRF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755201AbZBRRFz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:05:55 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:43991 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009AbZBRRFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:05:54 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 18:05:53 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 18:05:52 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <F21AE3A2-480B-4311-81E7-32B75B49A356@wincent.com>
X-OriginalArrivalTime: 18 Feb 2009 17:05:52.0883 (UTC) FILETIME=[27DBD430:01C991EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110560>

--nextPart2903955.pk0e24Epaa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Wincent Colaiuta wrote:
> I'm definitely blind then, or perhaps I didn't explain myself. At =20
> least, I saw nothing in the message you linked that answers my =20
> question. Let me try again.
>=20
> - Prior to your patch, in the two hunks I quoted we set MSG to an =20
> empty string and exported it
>=20
> - After your patch, the hunks now set MSG to "1" (not the same string) =20
> and export it
>=20
> In other words, you not only changed the _style_ from "assign and =20
> export in a single step" to "assign and then export as two separate =20
> steps"; you also changed _what_ gets exported in two of those hunks.

Actually the original version was

  http://article.gmane.org/gmane.comp.version-control.git/109920

which was subsequently fixed by Junio to not use a single-shot export.
Then Brandon noticed that during the fix-up, the export line suddenly
started exporting values itself, and different ones at that.

So while Jay's patch indeed changes the semantics, the net result is
what was intended all along, except it's now (hopefully) compatible
with more shells.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2903955.pk0e24Epaa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmcP+gACgkQqUud07tmzP1dbgCfV5uj5fb3lZl2/Kf61lwSrSqF
iUwAoI13vkmtl5mFbPF5VktNXiiAHcG/
=9w9Z
-----END PGP SIGNATURE-----

--nextPart2903955.pk0e24Epaa--
