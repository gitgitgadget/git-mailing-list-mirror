From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Typos in comments
Date: Fri, 22 Aug 2008 16:49:48 +0100
Message-ID: <dec3599179bfffb2491396cdb80d070a05c14057.1219418949.git.mike@abacus.co.uk>
References: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
 <1e418f42e4bc863890e274df6c4ee10c01e76598.1219418949.git.mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYnP-0007AD-68
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYHVPmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYHVPmZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:42:25 -0400
Received: from [82.109.193.99] ([82.109.193.99]:2957 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751915AbYHVPmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:42:20 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id CC80C1BD809; Fri, 22 Aug 2008 16:49:48 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
In-Reply-To: <1e418f42e4bc863890e274df6c4ee10c01e76598.1219418949.git.mike@abacus.co.uk>
In-Reply-To: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
References: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93313>

---
 .../spearce/egit/core/op/PushOperationResult.java  |    2 +-
 .../egit/core/op/PushOperationSpecification.java   |    2 +-
 .../src/org/spearce/egit/ui/UIIcons.java           |    4 ++--
 .../spearce/egit/ui/internal/GitResourceNode.java  |    2 +-
 .../egit/ui/internal/components/RefSpecPanel.java  |    2 +-
 .../ui/internal/dialogs/BranchSelectionDialog.java |    2 +-
 .../egit/ui/internal/dialogs/CommitDialog.java     |   12 ++++++------
 .../ui/internal/factories/GitAdapterFactory.java   |    2 +-
 .../spearce/jgit/transport/PushProcessTest.java    |    2 +-
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |    2 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |    8 ++++----
 .../src/org/spearce/jgit/lib/RepositoryState.java  |    2 +-
 .../src/org/spearce/jgit/lib/TreeEntry.java        |    2 +-
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    2 +-
 .../src/org/spearce/jgit/transport/RefSpec.java    |    2 +-
 .../src/org/spearce/jgit/transport/Transport.java  |    2 +-
 .../spearce/jgit/transport/WalkPushConnection.java |    2 +-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    2 +-
 .../org/spearce/jgit/transport/WalkTransport.java  |    2 +-
 .../src/org/spearce/jgit/util/Base64.java          |   12 ++++++------
 21 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
index 992ed57..6ffe998 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
@@ -64,7 +64,7 @@ public void addOperationResult(final URIish uri, final String errorMessage) {
 	}
 
 	/**
-	 * @return set of remote repositories URIis. Set is ordered in addition
+	 * @return set of remote repositories URIish. Set is ordered in addition
 	 *         sequence, which is usually the same as that from
 	 *         {@link PushOperationSpecification}.
 	 */
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
index 8ed7708..5e0be18 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationSpecification.java
@@ -57,7 +57,7 @@ public void addURIRefUpdates(final URIish uri,
 	}
 
 	/**
-	 * @return set of remote repositories URIis. Set is ordered in addition
+	 * @return set of remote repositories URIish. Set is ordered in addition
 	 *         sequence.
 	 */
 	public Set<URIish> getURIs() {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 7fe6e36..4be2faa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -21,10 +21,10 @@
 	/** Decoration for resource added to index but not yet committed. */
 	public static final ImageDescriptor OVR_PENDING_ADD;
 
-	/** Decoratoin for resource removed from the index but not commit. */
+	/** Decoration for resource removed from the index but not commit. */
 	public static final ImageDescriptor OVR_PENDING_REMOVE;
 
-	/** Decoration for resource tracked and commited in git. */
+	/** Decoration for resource tracked and committed in git. */
 	public static final ImageDescriptor OVR_SHARED;
 
 	/** Decoration for tracked resource with a merge conflict.  */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
index c15237d..3e8aa8b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
@@ -26,7 +26,7 @@
 import org.spearce.jgit.lib.TreeEntry;
 
 /**
- * A resource node is for letting Eclipse access data in the git repo in a hierachical
+ * A resource node is for letting Eclipse access data in the git repo in a hierarchical
  * fashion, e.g. for the compare editor.
  */
 public class GitResourceNode extends BufferedContent implements IStructureComparator, ITypedElement {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
index 125d0fb..0dc27a5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -577,7 +577,7 @@ public void clearRefSpecs() {
 	 * <p>
 	 * Listeners are notified on events caused by both operations invoked by
 	 * external calls and user interaction. Listener method(s) is always called
-	 * from UI thread and shouln't perform long computations.
+	 * from UI thread and shouldn't perform long computations.
 	 * <p>
 	 * Order of adding listeners is significant. This method is not thread-safe.
 	 * Listeners should be set up before panel usage.
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 13d8963..158738c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -47,7 +47,7 @@
 	private boolean showResetType = true;
 	
 	/**
-	 * Construct a dilog to select a branch to reset to or check out
+	 * Construct a dialog to select a branch to reset to or check out
 	 * @param parentShell
 	 * @param repo
 	 */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 4d7945b..4f932f2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -310,7 +310,7 @@ public String getCommitMessage() {
 	}
 
 	/**
-	 * Preset a commit message. This might be for ammending a commit.
+	 * Preset a commit message. This might be for amending a commit.
 	 * @param s the commit message
 	 */
 	public void setCommitMessage(String s) {
@@ -376,7 +376,7 @@ if (selectedItems.isEmpty() && !amending) {
 	}
 
 	/**
-	 * Set the total list of changed resourcess, including additions and
+	 * Set the total list of changed resources, including additions and
 	 * removals
 	 *
 	 * @param files potentially affected by a new commit
@@ -430,14 +430,14 @@ public void setSignedOff(boolean signedOff) {
 	}
 
 	/**
-	 * @return whether the last commit is to be ammended
+	 * @return whether the last commit is to be amended
 	 */
 	public boolean isAmending() {
 		return amending;
 	}
 
 	/**
-	 * Pre-set whether the last commit is going to be ammended
+	 * Pre-set whether the last commit is going to be amended
 	 *
 	 * @param amending
 	 */
@@ -446,7 +446,7 @@ public void setAmending(boolean amending) {
 	}
 
 	/**
-	 * Set the message from the previous commit for ammending.
+	 * Set the message from the previous commit for amending.
 	 *
 	 * @param string
 	 */
@@ -455,7 +455,7 @@ public void setPreviousCommitMessage(String string) {
 	}
 
 	/**
-	 * Set whether the previous commit may be ammended
+	 * Set whether the previous commit may be amended
 	 *
 	 * @param amendAllowed
 	 */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
index d9ae73b..53e303b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
@@ -13,7 +13,7 @@
 import org.spearce.egit.ui.GitHistoryPageSource;
 
 /**
- * This class is an intellgest "cast" operation for getting
+ * This class is an intelligent "cast" operation for getting
  * an instance of a suitable object from another for a specific
  * purpose.
  */
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
index 357e6b7..eafd89c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
@@ -231,7 +231,7 @@ public void testUpdateUnexpectedRemoteVsForce() throws IOException {
 	}
 
 	/**
-	 * Test for remote ref udpate, when connection rejects update.
+	 * Test for remote ref update, when connection rejects update.
 	 *
 	 * @throws IOException
 	 */
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index b23d96c..cc683d7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -182,7 +182,7 @@ if (actLen != expLen)
 	}
 
 	/**
-	 * Is it possible for this entry to be accidently assumed clean?
+	 * Is it possible for this entry to be accidentally assumed clean?
 	 * <p>
 	 * The "racy git" problem happens when a work file can be updated faster
 	 * than the filesystem records file modification timestamps. It is possible
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 0439656..32bf738 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -502,7 +502,7 @@ for (ObjectToPack otp : list)
 	 * At first, this method collects and sorts objects to pack, then deltas
 	 * search is performed if set up accordingly, finally pack stream is
 	 * written. {@link ProgressMonitor} tasks {@value #SEARCHING_REUSE_PROGRESS}
-	 * (only if resueDeltas or reuseObjects is enabled) and
+	 * (only if reuseDeltas or reuseObjects is enabled) and
 	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
 	 * </p>
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 628136d..f176271 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -185,7 +185,7 @@ public File getDirectory() {
 	}
 
 	/**
-	 * @return the directory containg the objects owned by this repository.
+	 * @return the directory containing the objects owned by this repository.
 	 */
 	public File getObjectsDirectory() {
 		return objectsDirs[0];
@@ -1010,7 +1010,7 @@ if (new File(gitDir,"BISECT_LOG").exists())
 	}
 
 	/**
-	 * Check validty of a ref name. It must not contain character that has
+	 * Check validity of a ref name. It must not contain character that has
 	 * a special meaning in a Git object reference expression. Some other
 	 * dangerous characters are also excluded.
 	 *
@@ -1055,10 +1055,10 @@ if (i == len -1)
 	}
 
 	/**
-	 * String work dir and return normalized repository path
+	 * Strip work dir and return normalized repository path
 	 *
 	 * @param wd Work dir
-	 * @param f File whose path shall be stripp off it's workdir
+	 * @param f File whose path shall be stripped of its workdir
 	 * @return normalized repository relative path
 	 */
 	public static String stripWorkDir(File wd, File f) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
index 63e0815..c32c381 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryState.java
@@ -39,7 +39,7 @@
 
 /**
  * Important state of the repository that affects what can and cannot bed
- * done. This is things like unhandles conflicted merges and unfinished rebase.
+ * done. This is things like unhandled conflicted merges and unfinished rebase.
  */
 public enum RepositoryState {
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index 3cb6126..85dda1d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -246,7 +246,7 @@ if (treeEntry instanceof FileTreeEntry)
 	 * Helper for accessing tree/blob/index methods.
 	 *
 	 * @param i
-	 * @return '/' for Tre entries and NUL for non-treeish objects
+	 * @return '/' for Tree entries and NUL for non-treeish objects
 	 */
 	final public static int lastChar(Entry i) {
 		// FIXME, gitlink etc. Currently Trees cannot appear in the
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 77f1d1a..9d30018 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -307,7 +307,7 @@ if (nameB < 0)
 	 * of commits.
 	 * 
 	 * @return identity of the committer (name, email) and the time the commit
-	 *         was made by the comitter; null if no committer line was found.
+	 *         was made by the committer; null if no committer line was found.
 	 */
 	public final PersonIdent getCommitterIdent() {
 		final byte[] raw = buffer;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index bce31d5..521110b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -233,7 +233,7 @@ if (isWildcard(r.srcName) != isWildcard(r.dstName))
 	 * Get the destination ref description.
 	 * <p>
 	 * During a fetch this is the local tracking branch that will be updated
-	 * with the new ObjectId after feching is complete. During a push this is
+	 * with the new ObjectId after fetching is complete. During a push this is
 	 * the remote ref that will be updated by the remote's receive-pack process.
 	 * <p>
 	 * If null during a fetch no tracking branch should be updated and the
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 862ba9f..65f2c6b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -618,7 +618,7 @@ if (cfgSrc.equals(reqSrc) && cfgDst != null) {
 	 * @return information about results of remote refs updates, tracking refs
 	 *         updates and refs advertised by remote repository.
 	 * @throws NotSupportedException
-	 *             this transport implementation does not support pusing
+	 *             this transport implementation does not support pushing
 	 *             objects.
 	 * @throws TransportException
 	 *             the remote connection could not be established or object
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index b417b6e..7497bca 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -147,7 +147,7 @@ if (AnyObjectId.equals(ObjectId.zeroId(), u.getNewObjectId()))
 		}
 
 		// If we have any updates we need to upload the objects first, to
-		// prevent creating refs pointing at non-existant data. Then we
+		// prevent creating refs pointing at non-existent data. Then we
 		// can update the refs, and the info-refs file for dumb transports.
 		//
 		if (!updates.isEmpty())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 31d72e9..54dd581 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -60,7 +60,7 @@
  * <p>
  * Implementations are responsible for resolving path names relative to the
  * <code>objects/</code> subdirectory of a single remote Git repository or
- * nake object database and make the content available as a Java input stream
+ * naked object database and make the content available as a Java input stream
  * for reading during fetch. The actual object traversal logic to determine the
  * names of files to retrieve is handled through the generic, protocol
  * independent {@link WalkFetchConnection}.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
index b3ea4aa..87949a6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
@@ -44,7 +44,7 @@
 /**
  * Canonical implementation of an object transport walking transport.
  * <p>
- * Implementations of WalkTransport transfer individual objects one at a a time
+ * Implementations of WalkTransport transfer individual objects one at a time
  * from the loose objects directory, or entire packs if the source side does not
  * have the object as a loose object.
  * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
index 31eeeea..8c45539 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
@@ -32,7 +32,7 @@
  *   Added the ability to "suspend" encoding in the Output Stream so
  *   you can turn on and off the encoding if you need to embed base64
  *   data in an otherwise "normal" stream (like an XML file).</li>
- *  <li>v1.5 - Output stream pases on flush() command but doesn't do anything itself.
+ *  <li>v1.5 - Output stream passes on flush() command but doesn't do anything itself.
  *      This helps when using GZIP streams.
  *      Added the ability to GZip-compress objects before encoding them.</li>
  *  <li>v1.4 - Added helper methods to read/write files.</li>
@@ -213,7 +213,7 @@ private Base64(){}
      * anywhere along their length by specifying
      * <var>srcOffset</var> and <var>destOffset</var>.
      * This method does not check to make sure your arrays
-     * are large enough to accomodate <var>srcOffset</var> + 3 for
+     * are large enough to accommodate <var>srcOffset</var> + 3 for
      * the <var>source</var> array or <var>destOffset</var> + 4 for
      * the <var>destination</var> array.
      * The actual number of significant bytes in your array is
@@ -527,7 +527,7 @@ if( breakLines && lineLength == MAX_LINE_LENGTH )
                     e++;
                     lineLength = 0;
                 }   // end if: end of line
-            }   // en dfor: each piece of array
+            }   // end for: each piece of array
 
             if( d < len )
             {
@@ -565,7 +565,7 @@ catch (java.io.UnsupportedEncodingException uue)
      * anywhere along their length by specifying
      * <var>srcOffset</var> and <var>destOffset</var>.
      * This method does not check to make sure your arrays
-     * are large enough to accomodate <var>srcOffset</var> + 4 for
+     * are large enough to accommodate <var>srcOffset</var> + 4 for
      * the <var>source</var> array or <var>destOffset</var> + 3 for
      * the <var>destination</var> array.
      * This method returns the actual number of bytes that
@@ -1315,7 +1315,7 @@ if( suspendEncoding )
             {
                 super.out.write( theByte );
                 return;
-            }   // end if: supsended
+            }   // end if: suspended
 
             // Encode?
             if( encode )
@@ -1376,7 +1376,7 @@ if( suspendEncoding )
             {
                 super.out.write( theBytes, off, len );
                 return;
-            }   // end if: supsended
+            }   // end if: suspended
 
             for( int i = 0; i < len; i++ )
             {
-- 
1.5.6.4
