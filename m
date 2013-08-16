From: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
Subject: [PATCH] CET is only one hour ahead of UTC
Date: Fri, 16 Aug 2013 12:53:49 +0200
Message-ID: <1376650429-2329-1-git-send-email-maandree@operamail.com>
References: <1376649800-442-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 12:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAHfO-0004zI-DF
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 12:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab3HPKx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 06:53:57 -0400
Received: from smtp-3.sys.kth.se ([130.237.48.192]:54403 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3HPKx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 06:53:57 -0400
Received: from mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169])
	by smtp-3.sys.kth.se (Postfix) with ESMTP id 4FDAC2352;
	Fri, 16 Aug 2013 12:53:55 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-3.sys.kth.se ([130.237.48.192])
	by mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169]) (amavisd-new, port 10024)
	with LMTP id YA0gDug-ah9E; Fri, 16 Aug 2013 12:53:54 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-3.sys.kth.se (Postfix) with ESMTPSA id F1C8E216;
	Fri, 16 Aug 2013 12:53:53 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1376649800-442-1-git-send-email-maandree@operamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232417>

Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
---
 date-formats.txt     | 4 ++--
 git-commit-tree.html | 4 ++--
 git-commit.html      | 4 ++--
 git-tag.html         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/date-formats.txt b/date-formats.txt
index c000f08..4dbaafa 100644
--- a/date-formats.txt
+++ b/date-formats.txt
@@ -11,11 +11,11 @@ Git internal format::
 	It is `<unix timestamp> <timezone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
 	`<timezone offset>` is a positive or negative offset from UTC.
-	For example CET (which is 2 hours ahead UTC) is `+0200`.
+	For example CET (which is 1 hour ahead UTC) is `+0100`.
=20
 RFC 2822::
 	The standard email format as described by RFC 2822, for example
-	`Thu, 07 Apr 2005 22:13:13 +0200`.
+	`Thu, 07 Apr 2005 22:13:13 +0100`.
=20
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
diff --git a/git-commit-tree.html b/git-commit-tree.html
index 825de94..c3571ce 100644
--- a/git-commit-tree.html
+++ b/git-commit-tree.html
@@ -883,7 +883,7 @@ Git internal format
         It is <code>&lt;unix timestamp&gt; &lt;timezone offset&gt;</co=
de>, where <code>&lt;unix
         timestamp&gt;</code> is the number of seconds since the UNIX e=
poch.
         <code>&lt;timezone offset&gt;</code> is a positive or negative=
 offset from UTC.
-        For example CET (which is 2 hours ahead UTC) is <code>+0200</c=
ode>.
+        For example CET (which is 1 hour ahead UTC) is <code>+0100</co=
de>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
@@ -892,7 +892,7 @@ RFC 2822
 <dd>
 <p>
         The standard email format as described by RFC 2822, for exampl=
e
-        <code>Thu, 07 Apr 2005 22:13:13 +0200</code>.
+        <code>Thu, 07 Apr 2005 22:13:13 +0100</code>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
diff --git a/git-commit.html b/git-commit.html
index 5123765..8890397 100644
--- a/git-commit.html
+++ b/git-commit.html
@@ -1341,7 +1341,7 @@ Git internal format
         It is <code>&lt;unix timestamp&gt; &lt;timezone offset&gt;</co=
de>, where <code>&lt;unix
         timestamp&gt;</code> is the number of seconds since the UNIX e=
poch.
         <code>&lt;timezone offset&gt;</code> is a positive or negative=
 offset from UTC.
-        For example CET (which is 2 hours ahead UTC) is <code>+0200</c=
ode>.
+        For example CET (which is 1 hour ahead UTC) is <code>+0100</co=
de>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
@@ -1350,7 +1350,7 @@ RFC 2822
 <dd>
 <p>
         The standard email format as described by RFC 2822, for exampl=
e
-        <code>Thu, 07 Apr 2005 22:13:13 +0200</code>.
+        <code>Thu, 07 Apr 2005 22:13:13 +0100</code>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
diff --git a/git-tag.html b/git-tag.html
index d26be17..4b65bb0 100644
--- a/git-tag.html
+++ b/git-tag.html
@@ -1149,7 +1149,7 @@ Git internal format
         It is <code>&lt;unix timestamp&gt; &lt;timezone offset&gt;</co=
de>, where <code>&lt;unix
         timestamp&gt;</code> is the number of seconds since the UNIX e=
poch.
         <code>&lt;timezone offset&gt;</code> is a positive or negative=
 offset from UTC.
-        For example CET (which is 2 hours ahead UTC) is <code>+0200</c=
ode>.
+        For example CET (which is 1 hour ahead UTC) is <code>+0100</co=
de>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
@@ -1158,7 +1158,7 @@ RFC 2822
 <dd>
 <p>
         The standard email format as described by RFC 2822, for exampl=
e
-        <code>Thu, 07 Apr 2005 22:13:13 +0200</code>.
+        <code>Thu, 07 Apr 2005 22:13:13 +0100</code>.
 </p>
 </dd>
 <dt class=3D"hdlist1">
--=20
1.8.3.4
