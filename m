From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Remove unnecessary URL quoting
Date: Fri, 20 Mar 2009 16:19:50 +0100
Message-ID: <200903201619.56600.trast@student.ethz.ch>
References: <200903200012.10454.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2896757.WYo4RRqq4M";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 16:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkgY3-0003NR-Ht
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 16:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbZCTPUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756394AbZCTPUd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 11:20:33 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:51926 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213AbZCTPUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 11:20:32 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 16:20:29 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 16:20:29 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.27.19-3.2-default; KDE/4.2.1; x86_64; ; )
In-Reply-To: <200903200012.10454.johan@herland.net>
X-OriginalArrivalTime: 20 Mar 2009 15:20:29.0287 (UTC) FILETIME=[67182770:01C9A96F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113971>

--nextPart2896757.WYo4RRqq4M
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johan Herland wrote:
> Embedding the URL in '+++' causes AsciiDoc (v8.4.1) to generate invalid X=
ML.
> None of the other URLs in Git's documentation are quoted in this manner.
> There's no reason to treat this URL differently.
>=20
> Signed-off-by: Johan Herland <johan@herland.net>
[...]
> -* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
> +* Clone it with `git clone file:///path/to/repo`.  The clone

I deliberately wrote it that way because *not* quoting it, at least on
my box, formats the entire paragraph in monospace.  Apparently it
treats the ` as part of an autodetected URL or some such.  This is
independent of my choice of ASCIIDOC8 or DOCBOOK_XSL_172 settings.  Am
I missing another flag that avoids this problem?

I have these packages installed from opensuse:

  asciidoc-8.2.7-29.10
  docbook_4-4.5-111.8
  docbook-xsl-stylesheets-1.74.0-1.35

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2896757.WYo4RRqq4M
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAknDtBwACgkQqUud07tmzP0SVwCfU1SWr1KOwR9XqYqcqDfs227x
h0YAnjIEFCbcX77sVyMkYjlSRqaqmU6B
=Wyxq
-----END PGP SIGNATURE-----

--nextPart2896757.WYo4RRqq4M--
