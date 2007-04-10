From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 00:44:44 -0700
Message-ID: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 12:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbB1t-0008Bn-7m
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 09:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbXDJHo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 03:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXDJHo0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 03:44:26 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:52377 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752145AbXDJHoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 03:44:25 -0400
Received: (qmail 15428 invoked from network); 10 Apr 2007 07:44:23 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 07:44:23 +0000
Received: (qmail 32117 invoked by uid 10000); 10 Apr 2007 00:44:44 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44116>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heya,

I'm trying to dig at various issues that are potential holdups for
migrating the Gentoo CVS tree into Git.

Since shallow checkouts are now available, there's just one more thing
that's missing: subtree checkouts. Not to be confused with sub-projects.

If the master tree has this as some example contents:
/foo
/abc/...
/bar/example
/bar/baz/some-content

We need to be able to check out arbitrary subtrees. So I might want to
check out everything (as the CVS administrator), while one of the more
focused developers just wants to check out /bar/baz/.

P.S. Does this list do some weird spam-blocking? I've tried 3 times now
to use git-send-email to send an unrelated minor patch set
(--subject-prefix for git-format-patch), and it has never shown up on
the list :-(.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGG0BsPpIsIjIzwiwRAm2FAKCj5q0wEt/yX7ql7GHPHf+5Bsbo2ACfen5J
3lr+Dcq5x5Y8VqBPycLudrQ=
=M5zm
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
