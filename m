From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 2/3] INSTALL: Reorder dependencies, split shell and Perl
Date: Tue,  8 Sep 2009 21:51:00 -0400
Message-ID: <1252461061-75840-3-git-send-email-brian@gernhardtsoftware.com>
References: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 03:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlCLP-0003XZ-Kr
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 03:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZIIBvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 21:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZIIBvR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 21:51:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47422 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZIIBvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 21:51:17 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5D0AB1FFC08C; Wed,  9 Sep 2009 01:51:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	by silverinsanity.com (Postfix) with ESMTPA id 8F8E21FFC087;
	Wed,  9 Sep 2009 01:50:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
In-Reply-To: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128053>

The most important and non-optional dependencies should go first, so put
them there.  While we're moving them, the descriptions for shell and perl
were archaic, referring to "bare-bones Porcelainish scripts" that have
become powerful and essential.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Split from v1's 2/2 so the changes don't get confused with the re-order.

 I kept the shell and perl re-wordings here since they're also somewhat of
 a factual error instead of 3/3's additions.

 INSTALL |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 5267468..7ab2580 100644
--- a/INSTALL
+++ b/INSTALL
@@ -52,6 +52,15 @@ Issues of note:
 
 	- "zlib", the compression library. Git won't build without it.
 
+	- "ssh" is used to push and pull over the net.
+
+	- A POSIX-compliant shell is required to run many scripts needed
+	  for everyday use (e.g. "bisect", "pull").
+
+	- "Perl" is needed to use some of the features (e.g. preparing a
+	  partial commit using "git add -i/-p", interacting with svn
+	  repositories with "git svn").
+
 	- "openssl".  Unless you specify otherwise, you'll get the SHA1
 	  library from here.
 
@@ -70,11 +79,6 @@ Issues of note:
         - "wish", the Tcl/Tk windowing shell is used in gitk to show the
           history graphically, and in git-gui.
 
-	- "ssh" is used to push and pull over the net
-
-	- "perl" and POSIX-compliant shells are needed to use most of
-	  the bare-bones Porcelainish scripts.
-
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
-- 
1.6.4.2.420.g30ecf
