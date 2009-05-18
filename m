From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Pretty date option for git tag?
Date: Mon, 18 May 2009 23:11:37 +0200
Message-ID: <200905182311.41876.trast@student.ethz.ch>
References: <20090518151440.GA10536@andros.its.yale.edu> <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain> <20090518174547.GA14509@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1685695.ucjARfUJjF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	dloewenherz@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 18 23:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6A8T-0000HN-4G
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 23:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZERVM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbZERVM1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 17:12:27 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:40279 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbZERVM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 17:12:26 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 23:12:20 +0200
Received: from thomas.localnet ([84.75.148.203]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 23:12:25 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <20090518174547.GA14509@sigill.intra.peff.net>
X-OriginalArrivalTime: 18 May 2009 21:12:25.0275 (UTC) FILETIME=[579378B0:01C9D7FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119464>

--nextPart1685695.ucjARfUJjF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> It seems like you should be able to script around for-each-ref and
> remain efficient, but I don't think there is a way to convince it to
> dereference tags.

Actually there's the * operator.  For example

  git$ git for-each-ref --format=3D"%(objecttype) %(*objecttype)" refs/tags=
/v1.6.0
  tag commit

Does that solve the problem at hand?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1685695.ucjARfUJjF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoRzw0ACgkQqUud07tmzP131gCgjdPxx0iKQSkkcWdJ8N7BBiLQ
vBoAn3fS7T9C++pvc3XAnuPkebX6dDSb
=/yk7
-----END PGP SIGNATURE-----

--nextPart1685695.ucjARfUJjF--
