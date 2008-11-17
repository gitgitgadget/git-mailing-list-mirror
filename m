From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 v2] Documentation: tutorial: add information about
 "git help" at the beginning
Date: Mon, 17 Nov 2008 16:43:04 +0100
Message-ID: <20081117164304.a3d68b1c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 16:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L26F2-0004EH-RD
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 16:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYKQPlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 10:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYKQPlE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 10:41:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:33102 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbYKQPlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 10:41:03 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A9BEC1AB38E;
	Mon, 17 Nov 2008 16:41:00 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7586D1AB30C;
	Mon, 17 Nov 2008 16:41:00 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101228>

Talking about "git help" is useful because it has a few more
features (like when using it without arguments or with "-a") and
it may work on non unix like platforms.

Also add a few links to git-help(1) in "See also" sections.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitcore-tutorial.txt |    1 +
 Documentation/gittutorial-2.txt    |    1 +
 Documentation/gittutorial.txt      |   10 ++++++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 61fc5d7..96bf353 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1693,6 +1693,7 @@ SEE ALSO
 linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
+linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index bab0f34..a057b50 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -425,6 +425,7 @@ linkgit:gittutorial[7],
 linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
+linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 384972c..7892244 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -26,6 +26,15 @@ First, note that you can get documentation for a command such as
 $ man git-log
 ------------------------------------------------
 
+or:
+
+------------------------------------------------
+$ git help log
+------------------------------------------------
+
+With the latter, you can use the manual viewer of your choice; see
+linkgit:git-help[1] for more information.
+
 It is a good idea to introduce yourself to git with your name and
 public email address before doing any operation.  The easiest
 way to do so is:
@@ -653,6 +662,7 @@ linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
+linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
-- 
1.6.0.4.617.g621cb
