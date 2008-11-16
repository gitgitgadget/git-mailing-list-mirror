From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 resend] Documentation: tutorial: add information about
 "git help" at the beginning
Date: Sun, 16 Nov 2008 18:10:06 +0100
Message-ID: <20081116181006.c237f5e2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1l7m-0005Ng-Ii
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYKPRIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYKPRIF
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:08:05 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:43797 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbYKPRIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:08:02 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B458D1AB34E;
	Sun, 16 Nov 2008 18:08:00 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 474D61AB2BE;
	Sun, 16 Nov 2008 18:08:00 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101142>

Talking about "git help" is useful because it has a few more
features (like when using it without arguments or with "-a") and
it may work on non unix like platforms.

Also add a few links to git-help(1) in "See also" sections.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitcore-tutorial.txt |    1 +
 Documentation/gittutorial-2.txt    |    1 +
 Documentation/gittutorial.txt      |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

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
index 384972c..2859a21 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -23,9 +23,22 @@ First, note that you can get documentation for a command such as
 `git log --graph` with:
 
 ------------------------------------------------
+$ git help log
+------------------------------------------------
+
+or:
+
+------------------------------------------------
 $ man git-log
 ------------------------------------------------
 
+linkgit:git-help[1] has a few more features and is self-documenting
+using:
+
+------------------------------------------------
+$ git help help
+------------------------------------------------
+
 It is a good idea to introduce yourself to git with your name and
 public email address before doing any operation.  The easiest
 way to do so is:
@@ -653,6 +666,7 @@ linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
+linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
-- 
1.6.0.4.617.g39d03
