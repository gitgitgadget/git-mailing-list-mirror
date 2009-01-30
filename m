From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 22:52:13 +0100
Message-ID: <200901302252.18051.trast@student.ethz.ch>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com> <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com> <adf1fd3d0901300449x7f6a2f5bq920068b46994c92e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15440714.yAM7GAJTkY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT26y-0006VY-Ex
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZA3Wn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZA3Wn5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:43:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8397 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbZA3Wnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:43:55 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <adf1fd3d0901300449x7f6a2f5bq920068b46994c92e@mail.gmail.com>
X-OriginalArrivalTime: 30 Jan 2009 22:43:51.0407 (UTC) FILETIME=[38F3C7F0:01C9832C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107876>

--nextPart15440714.yAM7GAJTkY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Santi B=E9jar wrote:
> 2009/1/30 Frank Li <lznuaa@gmail.com>:
> > Does it conflict with --parents?
> > When I use --follow and --parents together,  parents can't rewrite.
> > without --follow, parent can rewrite.
>=20
> I think there are no obvious reasons to conflict and they could work
> together, but as Jakub just said, --follow is quite new and only works
> well with simple history and simple cases.

You might find this useful:

  $ git config alias.renames
  !GIT_PAGER=3D"grep -v '^$' | sort -u" git --paginate log --follow --name-=
only --pretty=3Dformat:"" --

Slow and hacky, but works nice enough in practice.  The intended use
case is like

  $ gitk --complicated-rev-options $(git renames git-svn.perl)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart15440714.yAM7GAJTkY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDdpIACgkQqUud07tmzP1GvQCcCwHe+7yQ0R/40R3cE+qC8MmT
HPsAn1P6+8U9+26JeyfSEzOVAJUbyfIr
=CkDG
-----END PGP SIGNATURE-----

--nextPart15440714.yAM7GAJTkY--
