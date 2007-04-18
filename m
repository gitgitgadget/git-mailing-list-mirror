From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Cloning of git-svn repos?
Date: Wed, 18 Apr 2007 02:29:16 -0700
Message-ID: <20070418092916.GI31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 11:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He6TX-0001Jz-Lt
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 11:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbXDRJ3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 05:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXDRJ3L
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 05:29:11 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:43892 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422720AbXDRJ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 05:29:09 -0400
Received: (qmail 20133 invoked from network); 18 Apr 2007 09:29:06 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 18 Apr 2007 09:29:06 +0000
Received: (qmail 23946 invoked by uid 10000); 18 Apr 2007 02:29:16 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44878>


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(This is completely unrelated to my previous posts about using git for
Gentoo, it's not the only placing I'm looking at implementing Git).

Is there a sane and git-recommended way to clone repos created with
git-svn?

If I do: 'git-svn clone ....', and then git-clone of that directory, the
second clone cannot use git-svn to follow the original SVN or feed stuff
back to the original SVN.

If I create them separately (or by plain copying the first one to create
the second), then pulling between them works fine.

The copying just feels messy compared to the initial git-clone
functionality.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGJeTsPpIsIjIzwiwRAk1TAKC5+3heQK4OEqlmyEhCFbKZ0KmkIgCffDVR
vrLCXK2seoaCxBB9HNf139k=
=Lasc
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
