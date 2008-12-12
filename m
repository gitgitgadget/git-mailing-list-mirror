From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Fix typos in comments / testcase output
Date: Fri, 12 Dec 2008 10:55:57 +0000
Message-ID: <1229079357-19167-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 11:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB5YE-0001W8-1j
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 11:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYLLKqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 05:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYLLKqA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 05:46:00 -0500
Received: from [82.109.193.99] ([82.109.193.99]:5120 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750719AbYLLKp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 05:45:59 -0500
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id B8CBA1C7C83; Fri, 12 Dec 2008 10:55:57 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102893>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---

Is it me, or is the actual maintainer of JGIT/EGIT not actually
mentioned anywhere? Apologies if I've got the to and cc round
the wrong way 8-)

This patch is the product of
find . -name "*.java" -type f -exec aspell --mode=ccpp -c {} \;

I would post my aspell wordlists but they're polluted by other
projects...

Possibly also s/packes to/packs so/ in README?

 .../org/spearce/egit/core/GitMoveDeleteHook.java   |    2 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 +-
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |    2 +-
 .../spearce/jgit/transport/BundleWriterTest.java   |    2 +-
 .../spearce/jgit/transport/FetchConnection.java    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
index cc4059c..7faa65a 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
@@ -122,7 +122,7 @@ public boolean moveFolder(final IResourceTree tree, final IFolder source,
 			final IFolder destination, final int updateFlags,
 			final IProgressMonitor monitor) {
 		// TODO: Implement this. Should be relatively easy, but consider that
-		// Eclipse thinks folders are real thinsgs, while Git does not care.
+		// Eclipse thinks folders are real things, while Git does not care.
 		return FINISH_FOR_ME;
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 8937145..9e48fde 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -94,7 +94,7 @@ protected void configure() {
 
 	/**
 	 * Utility method to delete a directory recursively. It is
-	 * also used internally. If a file or directory cannote be removed
+	 * also used internally. If a file or directory cannot be removed
 	 * it throws an AssertionFailure.
 	 *
 	 * @param dir
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
index 805e29e..9b95924 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
@@ -226,7 +226,7 @@ public void testParse_explicit_bad_encoded() throws Exception {
 	 *
 	 * What happens here is that an encoding us given, but data is not encoded
 	 * that way (and we can detect it), so we try other encodings. Here data could
-	 * actually be decoded in the stated encoding, but we overide using UTF-8.
+	 * actually be decoded in the stated encoding, but we override using UTF-8.
 	 *
 	 * @throws Exception
 	 */
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
index 3cfb8b1..f13d25c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/BundleWriterTest.java
@@ -117,7 +117,7 @@ assertEquals(db.resolve("c").name(), newRepo.resolve("refs/heads/cc")
 			// Check that we actually needed the first bundle
 			Repository newRepo2 = createNewEmptyRepo();
 			fetchResult = fetchFromBundle(newRepo2, bundle);
-			fail("We should not be able to fetch from bundle with prerequisistes that are not fulfilled");
+			fail("We should not be able to fetch from bundle with prerequisites that are not fulfilled");
 		} catch (MissingBundlePrerequisiteException e) {
 			assertTrue(e.getMessage()
 					.indexOf(db.resolve("refs/heads/a").name()) >= 0);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
index 461ad71..a56ca6c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
@@ -126,7 +126,7 @@ public void fetch(final ProgressMonitor monitor, final Collection<Ref> want)
 	 * able to supply a fully connected graph to the client (although it may
 	 * only be transferring the parts the client does not yet have). Its faster
 	 * to assume such remote peers are well behaved and send the correct
-	 * response to the client. In such tranports this method returns false.
+	 * response to the client. In such transports this method returns false.
 	 *
 	 * @return true if the last fetch had to perform a connectivity check on the
 	 *         client side in order to succeed; false if the last fetch assumed
-- 
1.6.0.2
