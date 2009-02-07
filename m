From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] doc/bundle: Use the more conventional suffix '.bundle'
Date: Sat,  7 Feb 2009 23:21:49 +0100
Message-ID: <1234045309-3626-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 23:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvaG-0000X3-ST
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 23:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbZBGWWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 17:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZBGWWF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 17:22:05 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:48621 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbZBGWWC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 17:22:02 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1098088fkf.5
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 14:22:00 -0800 (PST)
Received: by 10.223.115.12 with SMTP id g12mr310808faq.92.1234045320551;
        Sat, 07 Feb 2009 14:22:00 -0800 (PST)
Received: from localhost (p5B0D4EEB.dip.t-dialin.net [91.13.78.235])
        by mx.google.com with ESMTPS id g28sm775072fkg.18.2009.02.07.14.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 14:22:00 -0800 (PST)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108898>

Although it does not matter in general it is handled different by
"git clone", as it removes it to make the "humanish" name of the
new repository.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/git-bundle.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index ea0f6a0..57590b1 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -107,17 +107,17 @@ incremental bundle,
=20
 ----------------
 machineA$ cd R1
-machineA$ git bundle create file.bdl master
+machineA$ git bundle create file.bundle master
 machineA$ git tag -f lastR2bundle master
 ----------------
=20
-Then you sneakernet file.bdl to the target machine B. Because you don'=
t
+Then you sneakernet file.bundle to the target machine B. Because you d=
on't
 have to have any object to extract objects from such a bundle, not onl=
y
 you can fetch/pull from a bundle, you can clone from it as if it was a
 remote repository.
=20
 ----------------
-machineB$ git clone /home/me/tmp/file.bdl R2
+machineB$ git clone /home/me/tmp/file.bundle R2
 ----------------
=20
 This will define a remote called "origin" in the resulting repository =
that
@@ -126,12 +126,12 @@ have an entry like this:
=20
 ------------------------
 [remote "origin"]
-    url =3D /home/me/tmp/file.bdl
+    url =3D /home/me/tmp/file.bundle
     fetch =3D refs/heads/*:refs/remotes/origin/*
 ------------------------
=20
 You can fetch/pull to update the resulting mine.git repository after
-replacing the bundle you store at /home/me/tmp/file.bdl with increment=
al
+replacing the bundle you store at /home/me/tmp/file.bundle with increm=
ental
 updates from here on.
=20
 After working more in the original repository, you can create an
@@ -139,11 +139,11 @@ incremental bundle to update the other:
=20
 ----------------
 machineA$ cd R1
-machineA$ git bundle create file.bdl lastR2bundle..master
+machineA$ git bundle create file.bundle lastR2bundle..master
 machineA$ git tag -f lastR2bundle master
 ----------------
=20
-and sneakernet it to the other machine to replace /home/me/tmp/file.bd=
l,
+and sneakernet it to the other machine to replace /home/me/tmp/file.bu=
ndle,
 and pull from it.
=20
 ----------------
--=20
1.6.1.258.g7ff14
