From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] fix doc typos
Date: Tue, 29 Jan 2008 20:38:55 +0100
Message-ID: <87myqoxvzk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwIx-0000mu-IB
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 20:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934213AbYA2TjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 14:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934211AbYA2Ti7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 14:38:59 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:45031 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934204AbYA2Ti5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 14:38:57 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DC78D17B59E
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 20:38:55 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BA2F717B56C
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 20:38:55 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7822319DE
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 20:38:55 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71988>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/RelNotes-1.5.3.3.txt   |    2 +-
 Documentation/git-config.txt         |    2 +-
 Documentation/git-cvsserver.txt      |    4 ++--
 Documentation/git-rev-parse.txt      |    6 +++---
 Documentation/technical/racy-git.txt |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.3.txt b/Documentation/RelNotes-1.5.3.3.txt
index 2a7bfdd..d213846 100644
--- a/Documentation/RelNotes-1.5.3.3.txt
+++ b/Documentation/RelNotes-1.5.3.3.txt
@@ -12,7 +12,7 @@ Fixes since v1.5.3.2
  * The default shell on some FreeBSD did not execute the
    argument parsing code correctly and made git unusable.

- * git-svn incorrectly spawned pager even when the user user
+ * git-svn incorrectly spawned pager even when the user
    explicitly asked not to.

  * sample post-receive hook overquoted the envelope sender
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e4d0e47..fa16171 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -130,7 +130,7 @@ See also <<FILES>>.

 -z, --null::
 	For all options that output values and/or keys, always
-	end values with with the null character (instead of a
+	end values with the null character (instead of a
 	newline). Use newline instead as a delimiter between
 	key and value. This allows for secure parsing of the
 	output without getting confused e.g. by values that
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index d75e401..c831548 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -204,7 +204,7 @@ about `DBI->connect()`.

 gitcvs.dbname::
 	Database name. The exact meaning depends on the
-	used database driver, for SQLite this is a filename.
+	selected database driver, for SQLite this is a filename.
 	Supports variable substitution (see below). May
 	not contain semicolons (`;`).
 	Default: '%Ggitcvs.%m.sqlite'
@@ -215,7 +215,7 @@ gitcvs.dbdriver::
 	with 'DBD::SQLite', reported to work with
 	'DBD::Pg', and reported *not* to work with 'DBD::mysql'.
 	Please regard this as an experimental feature. May not
-	contain double colons (`:`).
+	contain colons (`:`).
 	Default: 'SQLite'

 gitcvs.dbuser::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5d9c369..af98882 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -229,13 +229,13 @@ blobs contained in a commit.
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
   index at the given path.  Missing stage number (and the colon
-  that follows it) names an stage 0 entry. During a merge, stage
+  that follows it) names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.

 Here is an illustration, by Jon Loeliger.  Both node B and C are
-a commit parents of commit node A.  Parent commits are ordered
+commit parents of commit node A.  Parent commits are ordered
 left-to-right.

     G   H   I   J
@@ -291,7 +291,7 @@ and its parent commits exists.  `r1{caret}@` notation means all
 parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
 its all parents.

-Here are a handful examples:
+Here are a handful of examples:

    D                G H D
    D F              G H I J D F
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 5030d9f..6bdf034 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -184,7 +184,7 @@ In a large project where raciness avoidance cost really matters,
 however, the initial computation of all object names in the
 index takes more than one second, and the index file is written
 out after all that happens.  Therefore the timestamp of the
-index file will be more than one seconds later than the the
+index file will be more than one seconds later than the
 youngest file in the working tree.  This means that in these
 cases there actually will not be any racily clean entry in
 the resulting index.
--
1.5.4.rc5.1.ge6bfe
