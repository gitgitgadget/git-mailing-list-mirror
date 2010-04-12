From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Docs: Add -X option to git-merge's synopsis.
Date: Mon, 12 Apr 2010 12:28:13 -0400
Message-ID: <1271089693-21365-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 18:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MVP-0000nT-Kt
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab0DLQ2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:28:49 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:44834 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752123Ab0DLQ2t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 12:28:49 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o3CGSlPu029336;
	Mon, 12 Apr 2010 12:28:47 -0400
Received: by rincewind (Postfix, from userid 1000)
	id BC01F3368EA; Mon, 12 Apr 2010 12:28:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144753>

Also move -X's description next to -s's in merge-options.txt.

This makes it easier to learn how to specify merge strategy options.
---

Had to specify a merge strategy option today, and it took a little too
much work to figure out how.

 Documentation/git-merge.txt     |    3 ++-
 Documentation/merge-options.txt |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 9c9618c..ceec787 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,8 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
+'git merge' [-n] [--stat] [--no-commit] [--squash]...
+	[-s <strategy>] [-X <strategy-option>]...
 	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
 'git merge' <msg> HEAD <commit>...
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 37ce9a1..722d704 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -62,6 +62,11 @@ option can be used to override --squash.
 	is used instead ('git merge-recursive' when merging a single
 	head, 'git merge-octopus' otherwise).
 
+-X <option>::
+--strategy-option=<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
+
 --summary::
 --no-summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
@@ -76,8 +81,3 @@ ifndef::git-pull[]
 --verbose::
 	Be verbose.
 endif::git-pull[]
-
--X <option>::
---strategy-option=<option>::
-	Pass merge strategy specific option through to the merge
-	strategy.
-- 
1.7.1.rc0
