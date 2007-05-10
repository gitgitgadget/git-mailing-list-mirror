From: Johan Herland <johan@herland.net>
Subject: [PATCH] user-manual: Use "git config --global" instead of editing
 ~/.gitconfig
Date: Thu, 10 May 2007 23:53:31 +0200
Message-ID: <200705102353.31821.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart1593349.7RYHhPn3ap;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 23:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGZw-0002me-FN
	for gcvg-git@gmane.org; Thu, 10 May 2007 23:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbXEJVxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755263AbXEJVxf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 17:53:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47694 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbXEJVxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 17:53:35 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHU00L01I59LF00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 23:53:33 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU00F58I585530@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 23:53:32 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU004MCI58HT20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 23:53:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46903>

--nextPart1593349.7RYHhPn3ap
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Use git-config for setting global user.name and user.email rather than
telling the user to edit ~/.gitconfig directly. This brings=20
user-manual.txt in line with tutorial.txt.

Signed-off-by: Johan Herland <johan@herland.net>
=2D--
 Documentation/user-manual.txt |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt=20
b/Documentation/user-manual.txt
index 13db969..23e2f45 100644
=2D-- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -158,11 +158,8 @@ Making changes
 Make sure git knows who to blame:
=20
 ------------------------------------------------
=2D$ cat >>~/.gitconfig <<\EOF
=2D[user]
=2D	name =3D Your Name Comes Here
=2D	email =3D you@yourdomain.example.com
=2DEOF
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
=20
 Select file contents to include in the next commit, then make the
=2D-=20
1.5.0.7


--nextPart1593349.7RYHhPn3ap
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGQ5RbBHj4kl4fT1wRAhxdAJ4rC1YVsTGiPVpiK3uKpQf7XfZvmwCcD7b/
L8NlS0kLLzhAPqAZoZTR10Q=
=n2Dz
-----END PGP SIGNATURE-----

--nextPart1593349.7RYHhPn3ap--
