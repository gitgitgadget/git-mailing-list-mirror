From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 5/5] Documentation: minor grammatical fix in git-check-ref-format.txt.
Date: Sun, 22 Mar 2009 18:00:17 -0700
Message-ID: <1237770017-7168-6-git-send-email-dmellor@whistlingcat.com>
References: <1237770017-7168-1-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-3-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-4-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-5-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 02:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYZ9-0004Ed-1t
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbZCWBAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757160AbZCWBAb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:00:31 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:48160 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbZCWBAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:00:21 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 88FB5488009;
	Sun, 22 Mar 2009 18:00:19 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 82D0538E758C;
	Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 1FC3C17A63; Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237770017-7168-5-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114220>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-check-ref-format.txt |   40 ++++++++++++++++----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 034223c..171b683 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -3,7 +3,7 @@ git-check-ref-format(1)
 
 NAME
 ----
-git-check-ref-format - Make sure ref name is well formed
+git-check-ref-format - Ensures that a reference name is well formed
 
 SYNOPSIS
 --------
@@ -11,40 +11,40 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Checks if a given 'refname' is acceptable, and exits non-zero if
-it is not.
+Checks if a given 'refname' is acceptable, and exits with a non-zero
+status if it is not.
 
 A reference is used in git to specify branches and tags.  A
-branch head is stored under `$GIT_DIR/refs/heads` directory, and
-a tag is stored under `$GIT_DIR/refs/tags` directory.  git
-imposes the following rules on how refs are named:
+branch head is stored under the `$GIT_DIR/refs/heads` directory, and
+a tag is stored under the `$GIT_DIR/refs/tags` directory.  git
+imposes the following rules on how references are named:
 
-. It can include slash `/` for hierarchical (directory)
+. They can include slash `/` for hierarchical (directory)
   grouping, but no slash-separated component can begin with a
-  dot `.`;
+  dot `.`.
 
-. It cannot have two consecutive dots `..` anywhere;
+. They cannot have two consecutive dots `..` anywhere.
 
-. It cannot have ASCII control character (i.e. bytes whose
+. They cannot have ASCII control characters (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
   caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
-  or open bracket `[` anywhere;
+  or open bracket `[` anywhere.
 
-. It cannot end with a slash `/`.
+. They cannot end with a slash `/`.
 
-These rules makes it easy for shell script based tools to parse
-refnames, pathname expansion by the shell when a refname is used
+These rules make it easy for shell script based tools to parse
+reference names, pathname expansion by the shell when a reference name is used
 unquoted (by mistake), and also avoids ambiguities in certain
-refname expressions (see linkgit:git-rev-parse[1]).  Namely:
+reference name expressions (see linkgit:git-rev-parse[1]):
 
-. double-dot `..` are often used as in `ref1..ref2`, and in some
-  context this notation means `{caret}ref1 ref2` (i.e. not in
-  ref1 and in ref2).
+. A double-dot `..` is often used as in `ref1..ref2`, and in some
+  contexts this notation means `{caret}ref1 ref2` (i.e. not in
+  `ref1` and in `ref2`).
 
-. tilde `~` and caret `{caret}` are used to introduce postfix
+. A tilde `~` and caret `{caret}` are used to introduce the postfix
   'nth parent' and 'peel onion' operation.
 
-. colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
+. A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
   value and store it in dstref" in fetch and push operations.
   It may also be used to select a specific object such as with
   'git-cat-file': "git cat-file blob v1.3.3:refs.c".
-- 
1.6.2.1
