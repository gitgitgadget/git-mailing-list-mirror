From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: GPG signing for git commit?
Date: Wed, 15 Apr 2009 15:29:14 -0700
Message-ID: <20090415T220710Z@curie.orbis-terrarum.net>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> <20090415192054.GE23604@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPcKFu7Fa0A6HrUo"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 00:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuDdN-0007l8-BA
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZDOW3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbZDOW3V
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 18:29:21 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:34219 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752336AbZDOW3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 18:29:20 -0400
Received: (qmail 24787 invoked from network); 15 Apr 2009 22:29:17 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 15 Apr 2009 22:29:17 +0000
Received: (qmail 3667 invoked by uid 10000); 15 Apr 2009 15:29:14 -0700
Content-Disposition: inline
In-Reply-To: <20090415192054.GE23604@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116655>


--jPcKFu7Fa0A6HrUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2009 at 12:20:54PM -0700, Shawn O. Pearce wrote:
> > Not sure of the best route to trace this data. Signing the SHA1 makes
> > the most sense, but need to be able to do that without polluting the tag
> > namespace.
> Have the PM push over SSH, and don't ever expire reflogs on the
> central repository?  The reflog will have the old and new commits
> and the user name of the PM.
All pushing to the central repo will be git+ssh:// anyway.

I don't follow where the PM's identity is being stored, and how that's
distributed back out with the later pulls.

The other downside to relying on SSH presentation of identity directly,
is the inability to use the SSH key to uniquely identify the user during
the SSH auth (see designs like gitosis, where you always push to
git+ssh://git@host/repo).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--jPcKFu7Fa0A6HrUo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknmX7oACgkQPpIsIjIzwiz6EwCff/YwJzoA1HPSG8w9EXtW4fxB
miMAoPzHqrj9+SAUJtPNitNxtJvZqZyZ
=qUEX
-----END PGP SIGNATURE-----

--jPcKFu7Fa0A6HrUo--
