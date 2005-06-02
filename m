From: Christian Meder <chris@absolutegiganten.org>
Subject: [PATCH] Miniscule correction of diff-format.txt
Date: Thu, 02 Jun 2005 11:55:03 +0200
Message-ID: <1117706103.3279.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 11:56:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdmQc-0003hY-Gi
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 11:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFBJ6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 05:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFBJ6K
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 05:58:10 -0400
Received: from shadow.prohost.de ([216.71.84.228]:35064 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261359AbVFBJz0
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 05:55:26 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j529t6110745;
	Thu, 2 Jun 2005 11:55:06 +0200
To: torvalds@osdl.org
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add missing "space" element to the description of the diff-format.

Signed-off-by: Christian Meder <chris@absolutegiganten.org>

---
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -36,12 +36,13 @@ That is, from the left to the right:
   (6) sha1 for "src"; 0{40} if creation or unmerged.
   (7) a space.
   (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
-  (9) status, followed by optional "score" number.
- (10) a tab or a NUL when '-z' option is used.
- (11) path for "src"
- (12) a tab or a NUL when '-z' option is used; only exists for C or R.
- (13) path for "dst"; only exists for C or R.
- (14) an LF or a NUL when '-z' option is used, to terminate the record.
+  (9) a space.
+ (10) status, followed by optional "score" number.
+ (11) a tab or a NUL when '-z' option is used.
+ (12) path for "src"
+ (13) a tab or a NUL when '-z' option is used; only exists for C or R.
+ (14) path for "dst"; only exists for C or R.
+ (15) an LF or a NUL when '-z' option is used, to terminate the record.

 <sha1> is shown as all 0's if new is a file on the filesystem
 and it is out of sync with the cache.  Example:



-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

