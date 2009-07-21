From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash: gitk accepts common log-shortlog options
Date: Wed, 22 Jul 2009 00:36:36 +0200
Message-ID: <200907220036.42917.trast@student.ethz.ch>
References: <1248214802-2996-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2320323.AbK2aSiHlh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jul 22 00:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTNxI-0008OA-2r
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 00:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbZGUWgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 18:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755898AbZGUWgv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 18:36:51 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52031 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbZGUWgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 18:36:50 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 00:36:49 +0200
Received: from thomas.localnet ([84.74.103.245]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 00:36:48 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <1248214802-2996-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 21 Jul 2009 22:36:48.0990 (UTC) FILETIME=[BC390FE0:01CA0A53]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123724>

--nextPart2320323.AbK2aSiHlh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor wrote:
> Commit a393777e (bash completion: refactor common log, shortlog and gitk
> options, 2009-02-16) introduced a list of command line options that go
> well with 'git log' and 'git shortlog' but not with gitk.  However,
> these options are all 'git rev-list' options, and, therefore, are
> accepted by gitk, too.
[...]
> +	--author=3D --committer=3D --grep=3D
> +	--all-match

At the time, I tried to skip options to gitk that disconnect history
in places where it really is connected.  This applies to --author,
=2D-committer and --grep, which also have a GUI equivalent.  However,
=2D-all-match doesn't, and then the other three are also needed, so I
guess this makes sense.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2320323.AbK2aSiHlh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkpmQvoACgkQqUud07tmzP1nwgCgjE2/bzJnPP+NbleDywfEGPEV
MVEAni/MiASpk2AKsSkAWA+HDn6i/xpJ
=36kN
-----END PGP SIGNATURE-----

--nextPart2320323.AbK2aSiHlh--
