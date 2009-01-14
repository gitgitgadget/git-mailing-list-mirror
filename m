From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 23:37:08 +0100
Message-ID: <200901142337.33320.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <200901142104.16134.trast@student.ethz.ch> <alpine.DEB.1.00.0901142203190.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1523082.665S7xsgra";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:39:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNENq-0005Lg-EL
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbZANWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757727AbZANWhU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:37:20 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:15872 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757601AbZANWhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:37:18 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:37:16 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:37:16 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901142203190.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:37:16.0278 (UTC) FILETIME=[A6D3E160:01C97698]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105720>

--nextPart1523082.665S7xsgra
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> > Ack on the new regex semantics, though I'd have implemented it via dyin=
g=20
> > on '\n' instead of silently splitting there (and restarting a new=20
> > match!).
>=20
> Hmm.  I'd rather not die() in the middle of it.
>=20
> Maybe we can even handle newlines correctly by replacing them with NULs=20
> which libxdiff handles just fine?

I'm not sure it's worth the effort---anyone who wants words to stick
together across newlines probably doesn't put a newline there in the
first place, don't they?  (And it just shifts the problem to another
special character.)

> Phew.  I was almost convinced you would hate me for my criticiscm.

Let's say I wasn't too happy when you asked for two rounds of
improvements and _then_ rejected.  But the end result certainly turned
out better, so the criticism was justified.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart1523082.665S7xsgra
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluaS0ACgkQqUud07tmzP1N+wCfZXw4aQK088R5x+G+mj/KTJSj
qv8AnikQjgzd1zCnravvVCP/A6X3Ezfn
=TVg5
-----END PGP SIGNATURE-----

--nextPart1523082.665S7xsgra--
