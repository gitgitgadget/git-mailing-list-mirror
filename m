From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/6] Comment some empty blocks that should be empty
Date: Tue,  5 Feb 2008 01:15:29 +0100
Message-ID: <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtq-0001DL-KR
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbYBEAmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbYBEAmI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:08 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18376 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755831AbYBEAmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:04 -0500
X-Greylist: delayed 1587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2008 19:42:04 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 94A0680068F;
	Tue,  5 Feb 2008 01:15:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RzSmh9mlYH6R; Tue,  5 Feb 2008 01:15:35 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 0A2AB80068E;
	Tue,  5 Feb 2008 01:15:33 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 151CF28375; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72598>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/core/test/Activator.java  |    1 +
 .../internal/actions/AbstractOperationAction.java  |    1 +
 .../egit/ui/internal/dialogs/CommitDialog.java     |    3 +++
 .../ui/internal/preferences/GitPreferencePage.java |    1 +
 .../spearce/jgit/lib/AbstractIndexTreeVisitor.java |    4 ++++
 .../org/spearce/jgit/lib/TopologicalSorter.java    |    1 +
 6 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java
index 9807c84..10d7d94 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java
@@ -18,6 +18,7 @@ public class Activator extends Plugin {
 	 * The constructor
 	 */
 	public Activator() {
+		// Empty
 	}
 
 	/*
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
index c3f347e..0e96323 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
@@ -73,6 +73,7 @@ public abstract class AbstractOperationAction implements IObjectActionDelegate {
 	 * A method to invoke when the operation is finished.
 	 */
 	protected void postOperation() {
+		// Empty
 	}
 
 	public void run(final IAction act) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 3778b94..064a2dc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -212,6 +212,7 @@ public class CommitDialog extends Dialog {
 			}
 		
 			public void widgetDefaultSelected(SelectionEvent arg0) {
+				// Empty
 			}
 		});
 		
@@ -242,9 +243,11 @@ public class CommitDialog extends Dialog {
 
 			public void inputChanged(Viewer viewer, Object oldInput,
 					Object newInput) {
+				// Empty
 			}
 
 			public void dispose() {
+				// Empty
 			}
 
 			public Object[] getElements(Object inputElement) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitPreferencePage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitPreferencePage.java
index 780375b..8e6d3f3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitPreferencePage.java
@@ -36,5 +36,6 @@ public class GitPreferencePage extends PreferencePage implements
 	}
 
 	public void init(final IWorkbench workbench) {
+		// Empty
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
index 40b42dd..6f5ede4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
@@ -31,17 +31,21 @@ import org.spearce.jgit.lib.GitIndex.Entry;
 public class AbstractIndexTreeVisitor implements IndexTreeVisitor {
 	public void finishVisitTree(Tree tree, Tree auxTree, int i, String curDir)
 			throws IOException {
+		// Empty
 	}
 
 	public void finishVisitTree(Tree tree, int i, String curDir)
 			throws IOException {
+		// Empty
 	}
 
 	public void visitEntry(TreeEntry treeEntry, Entry indexEntry, File file)
 			throws IOException {
+		// Empty
 	}
 
 	public void visitEntry(TreeEntry treeEntry, TreeEntry auxEntry,
 			Entry indexEntry, File file) throws IOException {
+		// Empty
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
index 7b59490..c33334e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
@@ -292,6 +292,7 @@ public class TopologicalSorter<T> {
 		private int number = -1;
 
 		Lane() {
+			// Empty
 		}
 
 		@Override
-- 
1.5.4.rc4.25.g81cc
