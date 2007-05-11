From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/1] Document -S option to git-log.
Date: Fri, 11 May 2007 02:11:21 +0200
Message-ID: <200705110211.24929.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart1806811.bzy0fpGzMu;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 02:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmIjP-0000gy-9f
	for gcvg-git@gmane.org; Fri, 11 May 2007 02:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbXEKAL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755600AbXEKAL3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 20:11:29 -0400
Received: from smtp.getmail.no ([84.208.20.33]:42246 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbXEKAL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 20:11:29 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHU00501OJ38W00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 02:11:27 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU007BHOJ1T0C0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 02:11:25 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU00CWDOJ1QV30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 02:11:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46919>

--nextPart1806811.bzy0fpGzMu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The -S option to git-log is used early on in the user manual. This
indicates that it is probably one of the more used options to git-log,
and should therefore be part of the git-log manual page.

Signed-off-by: Johan Herland <johan@herland.net>
=2D--
 Documentation/git-log.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 49bb539..a10ec54 100644
=2D-- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -51,6 +51,9 @@ include::pretty-formats.txt[]
 	a record about how the tip of a reference was changed.
 	See also gitlink:git-reflog[1].
=20
+-S<string>::
+	Show commits where the difference contains the change in <string>.
+
 <paths>...::
 	Show only commits that affect the specified paths.
=20
=2D-=20
1.5.0.7


--nextPart1806811.bzy0fpGzMu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGQ7SsBHj4kl4fT1wRAjaqAKCQmTV6VfeDDUUnNQA01qA2qCsh1ACfeKd5
lCmR2oI+HOS2BvKsh3MqWdg=
=Q8zt
-----END PGP SIGNATURE-----

--nextPart1806811.bzy0fpGzMu--
