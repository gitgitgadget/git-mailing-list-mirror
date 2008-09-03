From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix passwd(5) ref and reflect that commit doens't use
	commit-tree
Date: Wed, 3 Sep 2008 10:50:43 +0200
Message-ID: <20080903085043.GA23406@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 10:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kao5g-00068T-Uy
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbYICIur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYICIur
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:50:47 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:53351 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbYICIuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:50:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4022C19BBD8
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 10:50:45 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28513-04 for <git@vger.kernel.org>; Wed,  3 Sep 2008 10:50:43 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id EC54B19BBD6
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 10:50:43 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id C9A706E0709
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 10:47:48 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D76B01DE5C4; Wed,  3 Sep 2008 10:50:43 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94765>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-commit-tree.txt |    4 ++--
 Documentation/git-var.txt         |    6 +++---
 Documentation/i18n.txt            |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 92ab3ab..b8834ba 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -79,9 +79,9 @@ Diagnostics
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
-    The password(5) gecos field is longer than a giant static buffer.
+    The passwd(5) gecos field is longer than a giant static buffer.
 Your sysadmin must hate you!::
-    The password(5) name field is longer than a giant static buffer.
+    The passwd(5) name field is longer than a giant static buffer.
 
 Discussion
 ----------
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 3647dd6..e2f4c09 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -20,7 +20,7 @@ OPTIONS
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of 'git-config -l'.)
+	is deprecated in favor of 'git config -l'.)
 
 EXAMPLE
 --------
@@ -41,9 +41,9 @@ Diagnostics
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
-    The password(5) gecos field is longer than a giant static buffer.
+    The passwd(5) gecos field is longer than a giant static buffer.
 Your sysadmin must hate you!::
-    The password(5) name field is longer than a giant static buffer.
+    The passwd(5) name field is longer than a giant static buffer.
 
 SEE ALSO
 --------
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index fb0d7da..d2970f8 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -21,7 +21,7 @@ project find it more convenient to use legacy encodings, git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
-. 'git-commit-tree' (hence, 'git-commit' which uses it) issues
+. 'git-commit' and 'git-commit-tree' issues
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
-- 
1.6.0.336.ga07ba

-- 
Jonas Fonseca
