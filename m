From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 6/6] filters: document environment variables in filter scripts
Date: Fri,  4 Mar 2011 01:31:35 +0100
Message-ID: <1299198695-23215-7-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIwH-0005if-OY
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab1CDAbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:50 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:63014 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759183Ab1CDAbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:49 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id C273658C9C6;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168421>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 filters/commit-links.sh        |   11 +++++++++++
 filters/syntax-highlighting.sh |   11 +++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/filters/commit-links.sh b/filters/commit-links.sh
index 110c609..d2cd2b3 100755
--- a/filters/commit-links.sh
+++ b/filters/commit-links.sh
@@ -3,6 +3,17 @@
 #
 # To use this script, refer to this file with either the commit-filter or the
 # repo.commit-filter options in cgitrc.
+#
+# The following environment variables can be used to retrieve the configuration
+# of the repository for which this script is called:
+# CGIT_REPO_URL        ( = repo.url       setting )
+# CGIT_REPO_NAME       ( = repo.name      setting )
+# CGIT_REPO_PATH       ( = repo.path      setting )
+# CGIT_REPO_OWNER      ( = repo.owner     setting )
+# CGIT_REPO_DEFBRANCH  ( = repo.defbranch setting )
+# CGIT_REPO_SECTION    ( = section        setting )
+# CGIT_REPO_CLONE_URL  ( = repo.clone-url setting )
+#
 
 # This expression generates links to commits referenced by their SHA1.
 regex=$regex'
diff --git a/filters/syntax-highlighting.sh b/filters/syntax-highlighting.sh
index 6b1c576..6283ce9 100755
--- a/filters/syntax-highlighting.sh
+++ b/filters/syntax-highlighting.sh
@@ -23,6 +23,17 @@
 # table.blob .kwb  { color:#830000; }
 # table.blob .kwc  { color:#000000; font-weight:bold; }
 # table.blob .kwd  { color:#010181; }
+#
+# The following environment variables can be used to retrieve the configuration
+# of the repository for which this script is called:
+# CGIT_REPO_URL        ( = repo.url       setting )
+# CGIT_REPO_NAME       ( = repo.name      setting )
+# CGIT_REPO_PATH       ( = repo.path      setting )
+# CGIT_REPO_OWNER      ( = repo.owner     setting )
+# CGIT_REPO_DEFBRANCH  ( = repo.defbranch setting )
+# CGIT_REPO_SECTION    ( = section        setting )
+# CGIT_REPO_CLONE_URL  ( = repo.clone-url setting )
+#
 
 # store filename and extension in local vars
 BASENAME="$1"
-- 
1.7.4
