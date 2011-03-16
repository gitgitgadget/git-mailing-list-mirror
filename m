From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] RelNotes/1.7.5.txt: typo and language fixes
Date: Wed, 16 Mar 2011 10:23:23 +0100
Message-ID: <aa605c2fe8bd57fdb9dc9f4876ba192e664e982d.1300267366.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 10:27:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzn0U-00070e-TY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab1CPJ1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:27:02 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35776 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167Ab1CPJ1A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 05:27:00 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EFEE020729;
	Wed, 16 Mar 2011 05:26:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 16 Mar 2011 05:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=EQVGa/gthnTJItUgMj+4NBkE60c=; b=tw5L2oyGuRCpXQ6Ggw/9e0QHcNA0ayUriSjAUWZzU1wWQ37fIxhpwN7WwVvmH8ES1w73kFl1u+i0yE5dtAtFhxbOm7glkAr35LHhG76RTnKf00GNvzYgnO0mx0DK6DEDjXwmqH+7peO1tCkagUDYzzHHB0Iwyr3vyswWdY5jJRM=
X-Sasl-enc: /me0OtQoVwWDZKT5HdznBJQCotpaIQfP6gV9ftikKzSY 1300267619
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4BFC64485CA;
	Wed, 16 Mar 2011 05:26:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169125>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    to be applied now or squashed in with more substantial updates

 Documentation/RelNotes/1.7.5.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/RelNotes/1.7.5.txt b/Documentation/RelNotes/1.7.5.txt
index 2c96f4d..2a80b03 100644
--- a/Documentation/RelNotes/1.7.5.txt
+++ b/Documentation/RelNotes/1.7.5.txt
@@ -25,11 +25,11 @@ Updates since v1.7.4
  * "git checkout --detach <commit>" is a more user friendly synonym for
    "git checkout <commit>^0".
 
- * "git checkout" performed on detached HEAD gives a warning and an
+ * "git checkout" performed on detached HEAD gives a warning and
    advice when the commit being left behind will become unreachable from
    any branch or tag.
 
- * "git cherry-pick" and "git revert" can be told to use custom merge
+ * "git cherry-pick" and "git revert" can be told to use a custom merge
    strategy, similar to "git rebase".
 
  * "git cherry-pick" remembers which commit failed to apply when it is
@@ -43,10 +43,10 @@ Updates since v1.7.4
  * "git grep --no-index" did not honor pathspecs correctly, returning
    paths outside the specified area.
 
- * "git log" family of commands now understand globbing pathspecs.  You
+ * "git log" type commands now understand globbing pathspecs.  You
    can say "git log -- '*.txt'" for example.
 
- * "git rev-list --objects $revs -- $pathspec" would limit the objects listed
+ * "git rev-list --objects $revs -- $pathspec" now limits the objects listed
    in its output properly with the pathspec, in preparation for narrow
    clones.
 
@@ -54,8 +54,8 @@ Updates since v1.7.4
    "tracking" is used as the push.default semantics or there is no remote
    configured yet.
 
- * "git rerere" learned a new subcommand "remaining", that is similar to
-   "status" that lists the paths that had conflicts that are known to
+ * "git rerere" learned a new subcommand "remaining" that is similar to
+   "status" and lists the paths that had conflicts which are known to
    rerere, but excludes the paths that have already been marked as
    resolved in the index from its output.  "git mergetool" has been
    updated to use this facility.
@@ -91,17 +91,17 @@ release, unless otherwise noted.
  * "git diff --stat -B" ran on binary files counted the changes in lines,
    which was nonsensical (jk/diffstat-binary).
 
- * "git diff -M" opportunisticly detected copies, which was not
+ * "git diff -M" opportunistically detected copies, which was not
    necessarily a good thing, especially when it is internally run by
    recursive merge.
 
- * "git merge" triggers prepare-commit-msg hook.  Earlier, only "git
+ * "git merge" now triggers the prepare-commit-msg hook.  Earlier, only "git
    commit" to conclude an interrupted merge triggered the hook, leading to
    an inconsistent overall user experience (js/maint-merge-use-prepare-commit-msg-hook).
 
- * "git submodule update" used to honor --merge/--rebase option (or
+ * "git submodule update" used to honor the --merge/--rebase option (or
    corresponding configuration variables) even for a newly cloned
-   subprojects, which made no sense (so/submodule-no-update-first-time).
+   subproject, which made no sense (so/submodule-no-update-first-time).
 
 ---
 exec >/var/tmp/1
-- 
1.7.4.1.404.g62d316
