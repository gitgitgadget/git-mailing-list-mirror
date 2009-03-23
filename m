From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 2/5] Documentation: minor grammatical fixes and rewording in git-bundle.txt.
Date: Sun, 22 Mar 2009 18:00:14 -0700
Message-ID: <1237770017-7168-3-git-send-email-dmellor@whistlingcat.com>
References: <1237770017-7168-1-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 02:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYZ7-0004Ed-Eb
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbZCWBA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757226AbZCWBA0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:00:26 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:43709 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004AbZCWBAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:00:21 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 03378488006;
	Sun, 22 Mar 2009 18:00:19 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 6CD1938E757F;
	Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 1051117A5C; Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114224>

This commit also converts all reference specifications to a monospaced font,
as the embedded ~ character used in some of the references sometimes causes
the text up to the next ~ to be displayed incorrectly as a subscript when the
HTML pages are generated. This was tested with asciidoc 8.2.5.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-bundle.txt |   86 +++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 57590b1..aee7e4a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -19,13 +19,13 @@ DESCRIPTION
 
 Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
-be directly connected so the interactive git protocols (git, ssh,
-rsync, http) cannot be used.  This command provides support for
+be directly connected, and therefore the interactive git protocols (git,
+ssh, rsync, http) cannot be used.  This command provides support for
 'git-fetch' and 'git-pull' to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
 another repository using 'git-fetch' and 'git-pull'
 after moving the archive by some means (i.e., by sneakernet).  As no
-direct connection between repositories exists, the user must specify a
+direct connection between the repositories exists, the user must specify a
 basis for the bundle that is held by the destination repository: the
 bundle assumes that all objects in the basis are already in the
 destination repository.
@@ -43,7 +43,7 @@ verify <file>::
        bundle format itself as well as checking that the prerequisite
        commits exist and are fully linked in the current repository.
        'git-bundle' prints a list of missing commits, if any, and exits
-       with non-zero status.
+       with a non-zero status.
 
 list-heads <file>::
        Lists the references defined in the bundle.  If followed by a
@@ -53,14 +53,14 @@ list-heads <file>::
 unbundle <file>::
        Passes the objects in the bundle to 'git-index-pack'
        for storage in the repository, then prints the names of all
-       defined references. If a reflist is given, only references
-       matching those in the given list are printed. This command is
+       defined references. If a list of references is given, only
+       references matching those in the list are printed. This command is
        really plumbing, intended to be called only by 'git-fetch'.
 
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git-rev-parse' and
-       'git-rev-list', that specify the specific objects and references
-       to transport.  For example, "master~10..master" causes the
+       'git-rev-list', that specifies the specific objects and references
+       to transport.  For example, `master\~10..master` causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -71,24 +71,24 @@ unbundle <file>::
        A list of references used to limit the references reported as
        available. This is principally of use to 'git-fetch', which
        expects to receive only those references asked for and not
-       necessarily everything in the pack (in this case, 'git-bundle' is
-       acting like 'git-fetch-pack').
+       necessarily everything in the pack (in this case, 'git-bundle' acts
+       like 'git-fetch-pack').
 
 SPECIFYING REFERENCES
 ---------------------
 
 'git-bundle' will only package references that are shown by
 'git-show-ref': this includes heads, tags, and remote heads.  References
-such as master~1 cannot be packaged, but are perfectly suitable for
+such as `master\~1` cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g., ^master~10), or implicitly (e.g.,
-master~10..master, --since=10.days.ago master).
+specified explicitly (e.g. `^master\~10`), or implicitly (e.g.
+`master\~10..master`, `--since=10.days.ago master`).
 
 It is very important that the basis used be held by the destination.
-It is okay to err on the side of conservatism, causing the bundle file
-to contain objects already in the destination as these are ignored
+It is okay to err on the side of caution, causing the bundle file
+to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
 EXAMPLE
@@ -97,13 +97,13 @@ EXAMPLE
 Assume you want to transfer the history from a repository R1 on machine A
 to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
-but we can move data from A to B via some mechanism (CD, email, etc).
-We want to update R2 with developments made on branch master in R1.
+but we can move data from A to B via some mechanism (CD, email, etc.).
+We want to update R2 with development made on the branch master in R1.
 
-To bootstrap the process, you can first create a bundle that doesn't have
-any basis. You can use a tag to remember up to what commit you sent out
-in order to make it easy to later update the other repository with
-incremental bundle,
+To bootstrap the process, you can first create a bundle that does not have
+any basis. You can use a tag to remember up to what commit you last
+processed, in order to make it easy to later update the other repository
+with an incremental bundle:
 
 ----------------
 machineA$ cd R1
@@ -111,17 +111,17 @@ machineA$ git bundle create file.bundle master
 machineA$ git tag -f lastR2bundle master
 ----------------
 
-Then you sneakernet file.bundle to the target machine B. Because you don't
-have to have any object to extract objects from such a bundle, not only
-you can fetch/pull from a bundle, you can clone from it as if it was a
-remote repository.
+Then you transfer file.bundle to the target machine B. If you are creating
+the repository on machine B, then you can clone from the bundle as if it
+were a remote repository instead of creating an empty repository and then
+pulling or fetching objects from the bundle:
 
 ----------------
 machineB$ git clone /home/me/tmp/file.bundle R2
 ----------------
 
 This will define a remote called "origin" in the resulting repository that
-lets you fetch and pull from the bundle. $GIT_DIR/config file in R2 may
+lets you fetch and pull from the bundle. The $GIT_DIR/config file in R2 will
 have an entry like this:
 
 ------------------------
@@ -130,12 +130,12 @@ have an entry like this:
     fetch = refs/heads/*:refs/remotes/origin/*
 ------------------------
 
-You can fetch/pull to update the resulting mine.git repository after
-replacing the bundle you store at /home/me/tmp/file.bundle with incremental
-updates from here on.
+To update the resulting mine.git repository, you can fetch or pull after
+replacing the bundle stored at /home/me/tmp/file.bundle with incremental
+updates.
 
-After working more in the original repository, you can create an
-incremental bundle to update the other:
+After working some more in the original repository, you can create an
+incremental bundle to update the other repository:
 
 ----------------
 machineA$ cd R1
@@ -143,8 +143,8 @@ machineA$ git bundle create file.bundle lastR2bundle..master
 machineA$ git tag -f lastR2bundle master
 ----------------
 
-and sneakernet it to the other machine to replace /home/me/tmp/file.bundle,
-and pull from it.
+You then transfer the bundle to the other machine to replace
+/home/me/tmp/file.bundle, and pull from it.
 
 ----------------
 machineB$ cd R2
@@ -152,49 +152,49 @@ machineB$ git pull
 ----------------
 
 If you know up to what commit the intended recipient repository should
-have the necessary objects for, you can use that knowledge to specify the
+have the necessary objects, you can use that knowledge to specify the
 basis, giving a cut-off point to limit the revisions and objects that go
 in the resulting bundle. The previous example used lastR2bundle tag
-for this purpose, but you can use other options you would give to
+for this purpose, but you can use any other options that you would give to
 the linkgit:git-log[1] command. Here are more examples:
 
-You can use a tag that is present in both.
+You can use a tag that is present in both:
 
 ----------------
 $ git bundle create mybundle v1.0.0..master
 ----------------
 
-You can use a basis based on time.
+You can use a basis based on time:
 
 ----------------
 $ git bundle create mybundle --since=10.days master
 ----------------
 
-Or you can use the number of commits.
+You can use the number of commits:
 
 ----------------
 $ git bundle create mybundle -10 master
 ----------------
 
 You can run `git-bundle verify` to see if you can extract from a bundle
-that was created with a basis.
+that was created with a basis:
 
 ----------------
 $ git bundle verify mybundle
 ----------------
 
 This will list what commits you must have in order to extract from the
-bundle and will error out if you don't have them.
+bundle and will error out if you do not have them.
 
 A bundle from a recipient repository's point of view is just like a
-regular repository it fetches/pulls from. You can for example map
-refs, like this example, when fetching:
+regular repository which it fetches or pulls from. You can, for example, map
+references when fetching:
 
 ----------------
 $ git fetch mybundle master:localRef
 ----------------
 
-Or see what refs it offers.
+You can also see what references it offers.
 
 ----------------
 $ git ls-remote mybundle
-- 
1.6.2.1
