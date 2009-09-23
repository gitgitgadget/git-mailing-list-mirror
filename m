From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 3/9] moving some license files and META-INF
Date: Wed, 23 Sep 2009 23:16:04 +0200
Message-ID: <1253740570-10718-3-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCK-0004af-9i
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZIWVP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZIWVP6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:15:58 -0400
Received: from n8.bullet.re3.yahoo.com ([68.142.237.93]:36789 "HELO
	n8.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752842AbZIWVP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:15:57 -0400
Received: from [68.142.230.28] by n8.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:01 -0000
Received: from [216.252.111.168] by t1.bullet.re2.yahoo.com with NNFMP; 23 Sep 2009 21:15:59 -0000
Received: from [127.0.0.1] by omp103.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:15:59 -0000
X-Yahoo-Newman-Id: 898640.3727.bm@omp103.mail.re3.yahoo.com
Received: (qmail 22218 invoked from network); 23 Sep 2009 21:15:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=JHZSwf6C7D3I4d3XQAPlHpxAIgNttw1mDZCHL05Td+IhwMP/EJZCTc7U/yuRQwOVFpRe75UXphQf1BvtEVg69VRSocyXnbbIv1kxB4/YX+IbzG6ytq+1EyuY06oTjqyxXXN+WPgneGUKijioXuPAzFO7veDtmBjrhnsSjMUHA10=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:15:58 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: 5xKCZX4VM1kYsr8UM0L8oSL5Qrqxf1lMVdPkMKLXc7ATtrxEyxkRoHQB.qT_DG.9bQRHDCSxpbMaja30eRzIhyFK1UM0KxekqvuJpGYfz5.v31M_8exxn.3s2go8Nh0TyH3jQEV3PpL6Eb4qf8MXfDtnUR9K1As45GBUAWj2Ox8f2KjWwmLWaVo1sU_K7veUqY7qc3Xwt5lo1VNh9YAWGjI.GFqoUVxETF4flG.88Wx7Vel5ZBKgFwGeS0cQkdQ3UnvgUDWu22aHHya9jDFVqQsqZNpagGNgsTgx7RpBly2TxuZAe58hLnR2yo8Muu_pmdIyoemm.7MB17RFWSM9jp_FkN3X5lA0A0AR
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-2-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129004>

Signed-off-by: Mark Struberg <struberg@yahoo.de>

removed LICENSE files from submodules. One in the parent folder is enough.
---
 org.spearce.jgit.test/LICENSE => LICENSE           |    0
 NOTICE                                             |    7 ++++
 .../lib => licenses}/JSch.LICENSE.txt              |    0
 org.spearce.jgit/LICENSE                           |   34 --------------------
 org.spearce.jgit/lib/jsch-0.1.37.jar               |  Bin 206178 -> 0 bytes
 org.spearce.jgit/lib/jsch-0.1.37.zip               |  Bin 268804 -> 0 bytes
 .../{ => src/main/resources}/META-INF/MANIFEST.MF  |    0
 7 files changed, 7 insertions(+), 34 deletions(-)
 rename org.spearce.jgit.test/LICENSE => LICENSE (100%)
 create mode 100644 NOTICE
 rename {org.spearce.jgit/lib => licenses}/JSch.LICENSE.txt (100%)
 delete mode 100644 org.spearce.jgit/LICENSE
 delete mode 100644 org.spearce.jgit/lib/jsch-0.1.37.jar
 delete mode 100644 org.spearce.jgit/lib/jsch-0.1.37.zip
 rename org.spearce.jgit/{ => src/main/resources}/META-INF/MANIFEST.MF (100%)

diff --git a/org.spearce.jgit.test/LICENSE b/LICENSE
similarity index 100%
rename from org.spearce.jgit.test/LICENSE
rename to LICENSE
diff --git a/NOTICE b/NOTICE
new file mode 100644
index 0000000..c19fbc3
--- /dev/null
+++ b/NOTICE
@@ -0,0 +1,7 @@
+JGIT Java native GIT core library
+
+see LICENSE for mor information
+
+This product uses the library jsch-0.1.38.jar as binary, 
+home page of the project is http://www.jcraft.com/jsch/ 
+
diff --git a/org.spearce.jgit/lib/JSch.LICENSE.txt b/licenses/JSch.LICENSE.txt
similarity index 100%
rename from org.spearce.jgit/lib/JSch.LICENSE.txt
rename to licenses/JSch.LICENSE.txt
diff --git a/org.spearce.jgit/LICENSE b/org.spearce.jgit/LICENSE
deleted file mode 100644
index 2917c22..0000000
--- a/org.spearce.jgit/LICENSE
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
diff --git a/org.spearce.jgit/lib/jsch-0.1.37.jar b/org.spearce.jgit/lib/jsch-0.1.37.jar
deleted file mode 100644
index e38c4b3..0000000
Binary files a/org.spearce.jgit/lib/jsch-0.1.37.jar and /dev/null differ
diff --git a/org.spearce.jgit/lib/jsch-0.1.37.zip b/org.spearce.jgit/lib/jsch-0.1.37.zip
deleted file mode 100644
index 63f3575..0000000
Binary files a/org.spearce.jgit/lib/jsch-0.1.37.zip and /dev/null differ
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/src/main/resources/META-INF/MANIFEST.MF
similarity index 100%
rename from org.spearce.jgit/META-INF/MANIFEST.MF
rename to org.spearce.jgit/src/main/resources/META-INF/MANIFEST.MF
-- 
1.6.2.5
