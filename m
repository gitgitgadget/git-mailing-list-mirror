From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 01/26] Force all source code to UTF-8 encoding by default
Date: Mon, 11 Aug 2008 18:07:48 -0700
Message-ID: <1218503293-14057-2-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiO2-0005x2-55
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbYHLBIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbYHLBIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:16 -0400
Received: from george.spearce.org ([209.20.77.23]:38560 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYHLBIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A753038375; Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B646338375;
	Tue, 12 Aug 2008 01:08:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92033>

To keep things simple we should use a single character encoding
for all of our source files, and UTF-8 is the best choice as it
will handle any possible Unicode character but the majority of
our source is plain 'ole ASCII.

We really want to support full Unicode in our sources so we can
setup Unicode test vectors, have translations which are usually
in the standard encoding, and correctly support author names in
source code copyright comments.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 .../.settings/org.eclipse.core.resources.prefs     |    3 +++
 9 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit-feature/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit-updatesite/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.core.test/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.core/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit.ui/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.egit/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
 create mode 100644 org.spearce.jgit/.settings/org.eclipse.core.resources.prefs

diff --git a/org.spearce.egit-feature/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit-feature/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..8d266d9
--- /dev/null
+++ b/org.spearce.egit-feature/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:46:45 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.egit-updatesite/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit-updatesite/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..4ec836b
--- /dev/null
+++ b/org.spearce.egit-updatesite/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:46:54 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..84e44d8
--- /dev/null
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:47:12 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.egit.core/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit.core/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..d4ff695
--- /dev/null
+++ b/org.spearce.egit.core/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:47:03 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit.ui/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..2f242b3
--- /dev/null
+++ b/org.spearce.egit.ui/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:47:19 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.egit/.settings/org.eclipse.core.resources.prefs b/org.spearce.egit/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..78f271d
--- /dev/null
+++ b/org.spearce.egit/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:46:35 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..759548b
--- /dev/null
+++ b/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:46:23 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..a2724ba
--- /dev/null
+++ b/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:05:15 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
diff --git a/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
new file mode 100644
index 0000000..66ac15c
--- /dev/null
+++ b/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
@@ -0,0 +1,3 @@
+#Mon Aug 11 16:46:12 PDT 2008
+eclipse.preferences.version=1
+encoding/<project>=UTF-8
-- 
1.6.0.rc2.22.g71b99
