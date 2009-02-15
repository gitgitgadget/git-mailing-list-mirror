From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sun, 15 Feb 2009 23:07:09 +0100
Message-ID: <200902152307.14571.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17400799.Q92NaQ17jn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 15 23:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpAd-0005vQ-V1
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbZBOWH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZBOWHZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:07:25 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9887 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbZBOWHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:07:24 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:07:23 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:07:22 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090215181818.GA2291@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Feb 2009 22:07:22.0678 (UTC) FILETIME=[C6FA3D60:01C98FB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110067>

--nextPart17400799.Q92NaQ17jn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> Using "dash" will catch bash-isms, and is pretty commonly available, I
> think.  But this behavior, IIRC, happens on FreeBSD's /bin/sh, which is
> derived from "ash" (so is "dash", but I they have long since diverged).

Thanks, that worked well enough.  It's not in the opensuse repos, but
hey, they track it with git, so it must be good ;-)

> So I don't think there is a catch-all shell that will help you, but some
> "ash" variant is probably your best bet.

I tried plain "ash" (which is in the opensuse repos) but that falls
down due to lack of 'cd -P'.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart17400799.Q92NaQ17jn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmYkhIACgkQqUud07tmzP1HAQCfQR0zoJLkmoc2Wcq8r34b4+9g
bCMAnAn1l67pMIXZkKXvVwIFSRBT1F6K
=jcKZ
-----END PGP SIGNATURE-----

--nextPart17400799.Q92NaQ17jn--
