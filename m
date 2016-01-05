From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: [PATCH] Expand documentation describing --signoff
Date: Tue, 05 Jan 2016 14:20:26 -0500 (EST)
Message-ID: <E1aGX9e-0002m1-55@rmm6prod02.runbox.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 20:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGXTD-0006zC-3X
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 20:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbcAETkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 14:40:36 -0500
Received: from aibo.runbox.com ([91.220.196.211]:50959 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbcAETke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2016 14:40:34 -0500
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2016 14:40:34 EST
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1aGX9e-00052A-5Y
	for git@vger.kernel.org; Tue, 05 Jan 2016 20:20:26 +0100
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1aGX9e-0002m1-55
	for git@vger.kernel.org; Tue, 05 Jan 2016 20:20:26 +0100
Content-Disposition: inline
Received: from [Authenticated user (258406)] by secure.runbox.com with
 http (RMM6); for <git@vger.kernel.org>; Tue, 05 Jan 2016 19:20:26 GMT
X-Mailer: RMM6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283396>

Modify various document (man page) files to explain
in more detail what --signoff means.

This was inspired by https://lwn.net/Articles/669976/ where
paulj noted, "adding [the] '-s' argument to [a] git commit
doesn't really mean you have even heard of the DCO...".
Extending git's documentation will make it easier to argue
that developers understood --signoff when they use it.

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
---
 Documentation/git-am.txt           | 1 +
 Documentation/git-cherry-pick.txt  | 1 +
 Documentation/git-commit.txt       | 6 +++++-
 Documentation/git-format-patch.txt | 1 +
 Documentation/git-revert.txt       | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 452c1fe..13cdd7f 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -35,6 +35,7 @@ OPTIONS
 --signoff::
 	Add a `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
+	See the signoff option in linkgit:git-commit[1] for more information.
 
 -k::
 --keep::
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 77da29a..6154e57 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -100,6 +100,7 @@ effect to your index in a row.
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
+	See the signoff option in linkgit:git-commit[1] for more information.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7f34a5b..9ec6b3c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -154,7 +154,11 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
 
 -n::
 --no-verify::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e3cdaeb..b149e09 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -109,6 +109,7 @@ include::diff-options.txt[]
 --signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
+	See the signoff option in linkgit:git-commit[1] for more information.
 
 --stdout::
 	Print all commits to the standard output in mbox format,
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index b15139f..573616a 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -89,6 +89,7 @@ effect to your index in a row.
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
+	See the signoff option in linkgit:git-commit[1] for more information.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
-- 
2.5.3
