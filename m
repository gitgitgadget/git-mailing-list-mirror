From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 3/3] glossary: remove definition of refspec and pathspec
Date: Sun, 7 Apr 2013 17:11:26 +0200 (CEST)
Message-ID: <1013848876.1719712.1365347486383.JavaMail.ngmail@webmail09.arcor-online.net>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrFl-0006L8-2G
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933892Ab3DGPL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:11:29 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40684 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933885Ab3DGPL2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 11:11:28 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 7228F197571;
	Sun,  7 Apr 2013 17:11:26 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 6237F33F6D4;
	Sun,  7 Apr 2013 17:11:26 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5756635A2A1;
	Sun,  7 Apr 2013 17:11:26 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net 5756635A2A1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1365347486; bh=aVEEMRNL3awDTjCwJq2tlCHQeR3rUU35K68mvYH9IIs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=P8aD4qLZFAVQPcwhL6gow10LFLWoh822yObJw2ZKSZTmI+zUL9XTCyw/NWq3wXjnL
	 BucK74dOil3/HrGUTKiNu0FyEp4mBTvAk49r4MzVDBXdYkKAakK1oEsC/qcJKHGlnB
	 xKachdwl14GWj4Fi18U7vWC4pIhLObr4vP74D7es=
Received: from [188.98.233.28] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Sun, 7 Apr 2013 17:11:26 +0200 (CEST)
In-Reply-To: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.233.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220315>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 64 ++------------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 4dd0a52..f21678d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -268,59 +268,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	pack.
 
 [[def_pathspec]]pathspec::
-       Pattern used to specify paths.
-+
-Pathspecs are used on the command line of "git ls-files", "git
-ls-tree", "git add", "git grep", "git diff", "git checkout",
-and many other commands to
-limit the scope of operations to some subset of the tree or
-worktree.  See the documentation of each command for whether
-paths are relative to the current directory or toplevel.  The
-pathspec syntax is as follows:
-
-* any path matches itself
-* the pathspec up to the last slash represents a
-  directory prefix.  The scope of that pathspec is
-  limited to that subtree.
-* the rest of the pathspec is a pattern for the remainder
-  of the pathname.  Paths relative to the directory
-  prefix will be matched against that pattern using fnmatch(3);
-  in particular, '*' and '?' _can_ match directory separators.
-+
-For example, Documentation/*.jpg will match all .jpg files
-in the Documentation subtree,
-including Documentation/chapter_1/figure_1.jpg.
-
-+
-A pathspec that begins with a colon `:` has special meaning.  In the
-short form, the leading colon `:` is followed by zero or more "magic
-signature" letters (which optionally is terminated by another colon `:`),
-and the remainder is the pattern to match against the path. The optional
-colon that terminates the "magic signature" can be omitted if the pattern
-begins with a character that cannot be a "magic signature" and is not a
-colon.
-+
-In the long form, the leading colon `:` is followed by a open
-parenthesis `(`, a comma-separated list of zero or more "magic words",
-and a close parentheses `)`, and the remainder is the pattern to match
-against the path.
-+
-The "magic signature" consists of an ASCII symbol that is not
-alphanumeric.
-+
---
-top `/`;;
-	The magic word `top` (mnemonic: `/`) makes the pattern match
-	from the root of the working tree, even when you are running
-	the command from inside a subdirectory.
---
-+
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
-versions of Git.
-+
-A pathspec with only a colon means "there is no pathspec". This form
-should not be combined with other pathspec.
+       Pattern used to limit paths in Git commands.
 
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) list
@@ -389,15 +337,7 @@ should not be combined with other pathspec.
 [[def_refspec]]refspec::
 	A "refspec" is used by <<def_fetch,fetch>> and
 	<<def_push,push>> to describe the mapping between remote
-	<<def_ref,ref>> and local ref. They are combined with a colon in
-	the format <src>:<dst>, preceded by an optional plus sign, +.
-	For example: `git fetch $URL
-	refs/heads/master:refs/heads/origin` means "grab the master
-	<<def_branch,branch>> <<def_head,head>> from the $URL and store
-	it as my origin branch head". And `git push
-	$URL refs/heads/master:refs/heads/to-upstream` means "publish my
-	master branch head as to-upstream branch at $URL". See also
-	linkgit:git-push[1].
+	<<def_ref,ref>> and local ref. 
 
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A regular Git <<def_branch,branch>> that is used to follow changes from
-- 
1.8.1.msysgit.1


---
Thomas
