From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Documentation: tutorial: add information about
 "git help" at the beginning
Date: Fri, 14 Nov 2008 13:27:22 +0100
Message-ID: <20081114132722.c98c4db1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 13:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0xkr-0004az-So
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 13:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbYKNMZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 07:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYKNMZN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 07:25:13 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:47928 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYKNMZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 07:25:12 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id ECDFA12B713;
	Fri, 14 Nov 2008 13:25:10 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id AC36412B6E3;
	Fri, 14 Nov 2008 13:25:10 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100967>

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
1.6.0.4.617.g621cb
