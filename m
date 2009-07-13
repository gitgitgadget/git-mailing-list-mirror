From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Rewrite history then pull repository?
Date: Mon, 13 Jul 2009 10:58:10 +0200
Message-ID: <200907131058.15118.trast@student.ethz.ch>
References: <h3es3p$ie6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4287828.7BZUZ0GSvc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 10:58:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQHMk-0001yQ-Gq
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZGMI6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 04:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbZGMI6W
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:58:22 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42467 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbZGMI6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 04:58:22 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 10:58:20 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 10:58:19 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <h3es3p$ie6$1@ger.gmane.org>
X-OriginalArrivalTime: 13 Jul 2009 08:58:20.0010 (UTC) FILETIME=[11AF64A0:01CA0398]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123178>

--nextPart4287828.7BZUZ0GSvc
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Graeme Geldenhuys wrote:
>=20
> I pushed a repository to Github (a mirror of SubVersion repository). I=20
> then had some screwup with 'git svn rebase' when I should have used 'git=
=20
> svn fetch'.  Anyway I managed to fix the issue locally and then forced=20
> the push to GitHub. This rewrote the history for the HEAD commit and=20
> gave it a different date and SHA1.
>=20
> What will now happen to developers that cloned the repository before the=
=20
>   history rewrite and then do a 'git pull' after the history rewrite?=20

See the "Recovering From Upstream Rebase" section in man git-rebase,
also available online at

  http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html

(especially useful if your local git is older than 1.6.1 and doesn't
have this section yet).

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart4287828.7BZUZ0GSvc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkpa9ycACgkQqUud07tmzP3gvgCfcxLogCkyxcuFnBwFUHwwHBo7
e+gAoJIe3HI53dfmNIMlwHiGlo+JJm0m
=Y3m6
-----END PGP SIGNATURE-----

--nextPart4287828.7BZUZ0GSvc--
