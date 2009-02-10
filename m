From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 23:26:46 +0100
Message-ID: <200902102326.49780.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de> <200902102316.56348.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1707963.5VMaFVjXei";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX15c-0001c5-EM
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbZBJW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbZBJW05
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:26:57 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:29165 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbZBJW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:26:57 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:26:55 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:26:55 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902102316.56348.trast@student.ethz.ch>
X-OriginalArrivalTime: 10 Feb 2009 22:26:55.0374 (UTC) FILETIME=[ADE4B2E0:01C98BCE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109324>

--nextPart1707963.5VMaFVjXei
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Sure, one problem is that the index reading code is inherently written
> for a single index state.  However, all notes consumers I can
> currently think of (show, log, anything that displays commit messages)
> do not have to access the "real" index.
[...]
> At a (*very*) cursory glance at read-cache.c, it seems that there is
> even support for having several index structures in memory at once,
> making this easy.  And it looks like reading the cache is more or less
> memcpy() if xmmap() is fast (Windows would suffer once again).

Note to self: do not write mail on bus, then pick up later at home.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1707963.5VMaFVjXei
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmR/ykACgkQqUud07tmzP1iCACfTsQuFKFrTo5S+WjpaVoynT9S
sQIAmwSXN5rv6Mv0ZpFXtesXhPpNrpDa
=GBQf
-----END PGP SIGNATURE-----

--nextPart1707963.5VMaFVjXei--
