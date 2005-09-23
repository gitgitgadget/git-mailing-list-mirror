From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 0/6] More fetch fixes
Date: Fri, 23 Sep 2005 16:27:54 +0400
Message-ID: <20050923122754.GB2197@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImf6-00077W-Qs
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVIWM2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVIWM2M
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:12 -0400
Received: from mivlgu.ru ([81.18.140.87]:50156 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750919AbVIWM2L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:11 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id E0EE1180114; Fri, 23 Sep 2005 16:27:54 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9185>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Here are some more patches for the fetch.c common code:

1) Disable building of object ref lists (as in git-rev-list)
2) Fix leak of tree entry names

And then some fixes for git-local-fetch:

3) Fix missing closedir() and check for success of opendir()
4) Avoid close(-1) (not exactly a bug, but Valgrind does not like it)
5) Fix "git-local-fetch -s" not working with packed repositories
6) Avoid confusing "cannot open" error messages before fetching a pack

--=20
Sergey Vlasov

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDM/TKW82GfkQfsqIRAqiNAJ9utVGxSlCZveJLXAUHGvm8Ig5tCACff61V
1zSP9ncbUPYa7aDfCQnOfNk=
=EZOP
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
