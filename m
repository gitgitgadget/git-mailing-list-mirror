From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: remove '\' from front of options in githooks doc
Date: Tue, 30 Sep 2008 17:56:32 +0200
Message-ID: <200809301756.41518.trast@student.ethz.ch>
References: <1222781831-6620-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1562838.2T7jxY3G6L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:58:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkhbo-0002sL-1E
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbYI3P4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYI3P4p
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:56:45 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:22002 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbYI3P4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:56:44 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 17:56:39 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 17:56:40 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1222781831-6620-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 30 Sep 2008 15:56:40.0221 (UTC) FILETIME=[206F24D0:01C92315]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97129>

--nextPart1562838.2T7jxY3G6L
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

SZEDER G=C3=A1bor wrote:
> ... because they show up in the man and html outputs.
=2E..
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
=2E..
> @@ -66,7 +66,7 @@ pre-commit
>  ----------
> =20
>  This hook is invoked by 'git-commit', and can be bypassed
> -with `\--no-verify` option.  It takes no parameter, and is
> +with `--no-verify` option.  It takes no parameter, and is
>  invoked before obtaining the proposed commit log message and
>  making a commit.  Exiting with non-zero status from this script
>  causes the 'git-commit' to abort.

This must be checked against older asciidocs to verify that it does
not turn the unescaped sequence -- into an em-dash.  The \-- traces
back to e1ccf53 ([PATCH] Escape asciidoc's built-in em-dash
replacement, 2005-09-12), which indicates that it _was_ a problem in
the past.  (The asciidoc 8.2.5 on my system does not use an em-dash in
either case.)

ACK on all single-dash cases though, which are indeed wrong and were
apparently introduced later in 8089c85 (git-commit: add a
prepare-commit-msg hook, 2008-02-05).

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart1562838.2T7jxY3G6L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjiTDkACgkQqUud07tmzP0K2gCeMmm2iHsCguLaD2nDmG22DQk2
LEgAoJHqFa8FJBEyvNBGynWwHQUAPOV6
=SKRQ
-----END PGP SIGNATURE-----

--nextPart1562838.2T7jxY3G6L--
