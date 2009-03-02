From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 3/3] Documentation: minor grammatical fixes.
Date: Sun, 1 Mar 2009 22:42:44 -0800
Message-ID: <20090302163548.D6ECC17A49@sandstone.whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 02 17:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeB90-0008Ni-TH
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 17:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbZCBQfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 11:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZCBQfv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 11:35:51 -0500
Received: from quartz.whistlingcat.com ([67.223.228.111]:54875 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbZCBQfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 11:35:50 -0500
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 1400E488006;
	Mon,  2 Mar 2009 08:35:49 -0800 (PST)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id DC0B138E74F0;
	Mon,  2 Mar 2009 08:35:48 -0800 (PST)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id D6ECC17A49; Mon,  2 Mar 2009 08:35:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111946>

The final hunk in this patch corrects what appears to be a typo:

of --> or

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-apply.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 0566376..9e5baa2 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -25,7 +25,7 @@ and a work tree.
 OPTIONS
 -------
 <patch>...::
-	The files to read patch from.  '-' can be used to read
+	The files to read the patch from.  '-' can be used to read
 	from the standard input.
 
 --stat::
@@ -33,8 +33,8 @@ OPTIONS
 	input.  Turns off "apply".
 
 --numstat::
-	Similar to \--stat, but shows number of added and
-	deleted lines in decimal notation and pathname without
+	Similar to \--stat, but shows the number of added and
+	deleted lines in decimal notation and the pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.  Turns off "apply".
@@ -60,15 +60,15 @@ OPTIONS
 	causes the index file to be updated.
 
 --cached::
-	Apply a patch without touching the working tree. Instead, take the
-	cached data, apply the patch, and store the result in the index,
+	Apply a patch without touching the working tree. Instead take the
+	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies '--index'.
 
 --build-fake-ancestor=<file>::
 	Newer 'git-diff' output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
-	the original versions of the blobs is available locally,
+	the original versions of the blobs are available locally,
 	builds a temporary index containing those blobs.
 +
 When a pure mode change is encountered (which has no index information),
@@ -109,13 +109,13 @@ the information is read from the current index instead.
 	applying a diff generated with --unified=0. To bypass these
 	checks use '--unidiff-zero'.
 +
-Note, for the reasons stated above usage of context-free patches are
+Note, for the reasons stated above usage of context-free patches is
 discouraged.
 
 --apply::
 	If you use any of the options marked "Turns off
 	'apply'" above, 'git-apply' reads and outputs the
-	information you asked without actually applying the
+	requested information without actually applying the
 	patch.  Give this flag after those flags to also apply
 	the patch.
 
@@ -124,7 +124,7 @@ discouraged.
 	patch.  This can be used to extract the common part between
 	two files by first running 'diff' on them and applying
 	the result with this option, which would apply the
-	deletion part but not addition part.
+	deletion part but not the addition part.
 
 --allow-binary-replacement::
 --binary::
@@ -162,7 +162,7 @@ By default, the command outputs warning messages but applies the patch.
 When `git-apply` is used for statistics and not applying a
 patch, it defaults to `nowarn`.
 +
-You can use different `<action>` to control this
+You can use different `<action>` values to control this
 behavior:
 +
 * `nowarn` turns off the trailing whitespace warning.
@@ -170,7 +170,7 @@ behavior:
   patch as-is (default).
 * `fix` outputs warnings for a few such errors, and applies the
   patch after fixing them (`strip` is a synonym --- the tool
-  used to consider only trailing whitespaces as errors, and the
+  used to consider only trailing whitespace characters as errors, and the
   fix involved 'stripping' them, but modern gits do more).
 * `error` outputs warnings for a few such errors, and refuses
   to apply the patch.
@@ -195,7 +195,7 @@ behavior:
 	adjusting the hunk headers appropriately).
 
 --directory=<root>::
-	Prepend <root> to all filenames.  If a "-p" argument was passed, too,
+	Prepend <root> to all filenames.  If a "-p" argument was also passed,
 	it is applied before prepending the new root.
 +
 For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
@@ -221,7 +221,7 @@ ignored, i.e., they are not required to be up-to-date or clean and they
 are not updated.
 
 If --index is not specified, then the submodule commits in the patch
-are ignored and only the absence of presence of the corresponding
+are ignored and only the absence or presence of the corresponding
 subdirectory is checked and (if possible) updated.
 
 Author
-- 
1.6.1.3
