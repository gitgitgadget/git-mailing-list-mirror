From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Typos in error messages etc
Date: Fri, 22 Aug 2008 16:49:47 +0100
Message-ID: <1e418f42e4bc863890e274df6c4ee10c01e76598.1219418949.git.mike@abacus.co.uk>
References: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYnO-0007AD-Fk
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYHVPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbYHVPmV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:42:21 -0400
Received: from [82.109.193.99] ([82.109.193.99]:2955 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752106AbYHVPmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:42:20 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id C5D2C1BD607; Fri, 22 Aug 2008 16:49:48 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
In-Reply-To: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
In-Reply-To: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
References: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93311>

---
 .../spearce/egit/core/project/GitProjectData.java  |    2 +-
 .../egit/ui/internal/actions/BranchAction.java     |    2 +-
 .../egit/ui/internal/actions/CommitAction.java     |    4 ++--
 .../actions/QuickdiffBaselineOperation.java        |    2 +-
 .../egit/ui/internal/actions/ResetAction.java      |    2 +-
 .../tst/org/spearce/jgit/lib/T0007_Index.java      |    6 +++---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    4 ++--
 .../src/org/spearce/jgit/lib/TreeIterator.java     |    2 +-
 .../src/org/spearce/jgit/transport/TagOpt.java     |    2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 1ca1d03..04130db 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -316,7 +316,7 @@ if (m != null)
 					return m;
 			}
 		} catch (CoreException err) {
-			Activator.logError("Falied finding RepositoryMapping", err);
+			Activator.logError("Failed finding RepositoryMapping", err);
 		}
 		return null;
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/BranchAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/BranchAction.java
index affef46..7ca4d10 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/BranchAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/BranchAction.java
@@ -37,7 +37,7 @@ if (repository == null)
 
 		if (!repository.getRepositoryState().canCheckout()) {
 			MessageDialog.openError(getShell(), "Cannot checkout now",
-					"Respository state:"
+					"Repository state:"
 							+ repository.getRepositoryState().getDescription());
 			return;
 		}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 4956be3..8db701c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -73,7 +73,7 @@ public void run(IAction act) {
 		for (Repository repo : repos) {
 			if (!repo.getRepositoryState().canCommit()) {
 				MessageDialog.openError(getTargetPart().getSite().getShell(),
-					"Cannot commit now", "Respository state:"
+					"Cannot commit now", "Repository state:"
 							+ repo.getRepositoryState().getDescription());
 				return;
 			}
@@ -132,7 +132,7 @@ private void loadPreviousCommit() {
 			if (parentId != null)
 				previousCommit = repo.mapCommit(parentId);
 		} catch (IOException e) {
-			Utils.handleError(getTargetPart().getSite().getShell(), e, "Error during commit", "Error occurred retreiving last commit");
+			Utils.handleError(getTargetPart().getSite().getShell(), e, "Error during commit", "Error occurred retrieving last commit");
 		}
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
index 990958f..8123863 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
@@ -37,7 +37,7 @@ public void run(IProgressMonitor monitor) throws CoreException {
 		try {
 			GitQuickDiffProvider.setBaselineReference(repository, baseline);
 		} catch (IOException e) {
-			Activator.logError("Cannot set quickdiff basekine", e);
+			Activator.logError("Cannot set quickdiff baseline", e);
 		}
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetAction.java
index 7ca48af..b05cdd3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetAction.java
@@ -38,7 +38,7 @@ if (repository == null)
 		
 		if (!repository.getRepositoryState().canResetHead()) {
 			MessageDialog.openError(getShell(), "Cannot reset HEAD now",
-					"Respository state:"
+					"Repository state:"
 							+ repository.getRepositoryState().getDescription());
 			return;
 		}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
index 30412ff..a46daf3 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
@@ -54,7 +54,7 @@
 		try {
 			canrungitstatus = system(new File("."),"git --version") == 0;
 		} catch (IOException e) {
-			System.out.println("Warning: cannot invvoke native git to validate index");
+			System.out.println("Warning: cannot invoke native git to validate index");
 		} catch (InterruptedException e) {
 			e.printStackTrace();
 		}
@@ -364,7 +364,7 @@ if (!((Boolean)setExecute.invoke(nonexecFile, new Object[] { Boolean.TRUE })).bo
 			assertTrue(index2.getEntry(nonexecFile.getName()).isModified(trash));
 
 		} catch (NoSuchMethodException e) {
-			System.err.println("Test ignored when running under JDk < 1.6");
+			System.err.println("Test ignored when running under JDK < 1.6");
 			return;
 		}
 	}
@@ -416,7 +416,7 @@ if (!((Boolean)setExecute.invoke(nonexecFile, new Object[] { Boolean.TRUE })).bo
 			assertFalse(index2.getEntry(nonexecFile.getName()).isModified(trash));
 
 		} catch (NoSuchMethodException e) {
-			System.err.println("Test ignored when running under JDk < 1.6");
+			System.err.println("Test ignored when running under JDK < 1.6");
 			return;
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 2255c1a..0dc61aa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -532,7 +532,7 @@ if (!file.isDirectory())
 			if (file.length() != size)
 				return true;
 
-			// Git under windows only stores seconds so we round the timestmap
+			// Git under windows only stores seconds so we round the timestamp
 			// Java gives us if it looks like the timestamp in index is seconds
 			// only. Otherwise we compare the timestamp at millisecond prevision.
 			long javamtime = mtime / 1000000L;
@@ -689,7 +689,7 @@ throw new CorruptObjectException("Index signature is invalid: "
 						+ signature);
 			if (version != 2)
 				throw new CorruptObjectException(
-						"Unknow index version (or corrupt index):" + version);
+						"Unknown index version (or corrupt index):" + version);
 		}
 
 		void write(ByteBuffer buf) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
index 5eab1cd..2344a3c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
@@ -198,6 +198,6 @@ if (index == tree.memberCount() && !hasVisitedTree
 
 	public void remove() {
 		throw new IllegalStateException(
-				"TreeIterator does not suppport remove()");
+				"TreeIterator does not support remove()");
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TagOpt.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TagOpt.java
index 853b03b..3a233bf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TagOpt.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TagOpt.java
@@ -98,6 +98,6 @@ for (final TagOpt tagopt : values()) {
 			if (tagopt.option().equals(o))
 				return tagopt;
 		}
-		throw new IllegalArgumentException("Invald tag option: " + o);
+		throw new IllegalArgumentException("Invalid tag option: " + o);
 	}
 }
-- 
1.5.6.4
