From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: minor fixes to RelNotes-1.7.0
Date: Fri, 12 Feb 2010 10:47:53 +0100
Message-ID: <8912da79892fba3404885c301b7c333a19dc6b49.1265968004.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 10:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfs7l-0005iK-KV
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0BLJrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:47:40 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45022 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752122Ab0BLJrj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 04:47:39 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 95EA0E10CF;
	Fri, 12 Feb 2010 04:47:38 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 12 Feb 2010 04:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=HVwX43PchWJ3bfieG2zvanGZ00U=; b=k6u93W9Kt9DrPKo59XEYXrP/bZ66WG7a1MbUlT8k0EMAlX0MMrFNeFOjQloMjksMUNPOoyle6+BnUQ3j2pdXXULXU5BDHA1KnxGubj+/mLXAPGUPdmBgmO0spEfZbcBHNeGsA6uYafiNs67LF/KWt8p9bSUqfjlFw3w9e8OswL8=
X-Sasl-enc: EbXMu2UqxdBZ0rqhww5GeiqAgUYJNuK9hY1f8DRbvwlD 1265968057
Received: from localhost (p3EE2A707.dip0.t-ipconnect.de [62.226.167.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6CC7E4ADF5B;
	Fri, 12 Feb 2010 04:47:37 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.186.gbb211
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139673>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Terribly sorry for chimping in so late. Ruined my desktop the other day
but recovered now...

 Documentation/RelNotes-1.7.0.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 2fedb66..0815ca1 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -4,7 +4,7 @@ Git v1.7.0 Release Notes
 Notes on behaviour change
 -------------------------
 
- * "git push" into a branch that is currently checked out (i.e. pointed by
+ * "git push" into a branch that is currently checked out (i.e. pointed at by
    HEAD in a repository that is not bare) is refused by default.
 
    Similarly, "git push $there :$killed" to delete the branch $killed
@@ -19,7 +19,7 @@ Notes on behaviour change
    patch series with more than two messages.  All messages will be sent
    as a reply to the first message, i.e. cover letter.
 
-   It has been possible to configure send-email to send "shallow thread"
+   It has been possible already to configure send-email to send "shallow thread"
    by setting sendemail.chainreplyto configuration variable to false.  The
    only thing this release does is to change the default when you haven't
    configured that variable.
@@ -30,7 +30,7 @@ Notes on behaviour change
  * "git diff" traditionally treated various "ignore whitespace" options
    only as a way to filter the patch output.  "git diff --exit-code -b"
    exited with non-zero status even if all changes were about changing the
-   ammount of whitespace and nothing else.  and "git diff -b" showed the
+   amount of whitespace and nothing else;  and "git diff -b" showed the
    "diff --git" header line for such a change without patch text.
 
    In this release, the "ignore whitespaces" options affect the semantics
@@ -106,7 +106,7 @@ Updates since v1.6.6
    defaults to the current branch, so "git fetch && git merge @{upstream}"
    will be equivalent to "git pull".
 
- * "git branch --set-upstream" can be used to update the (surprise!) upstream
+ * "git branch --set-upstream" can be used to update the (surprise!) upstream,
    i.e. where the branch is supposed to pull and merge from (or rebase onto).
 
  * "git checkout A...B" is a way to detach HEAD at the merge base between
@@ -133,7 +133,7 @@ Updates since v1.6.6
  * "git fetch --all" can now be used in place of "git remote update".
 
  * "git grep" does not rely on external grep anymore.  It can use more than
-   one threads to accelerate the operation.
+   one thread to accelerate the operation.
 
  * "git grep" learned "--quiet" option.
 
@@ -159,13 +159,13 @@ Updates since v1.6.6
  * "git rebase --onto A...B" means the history is replayed on top of the
    merge base between A and B.
 
- * "git rebase -i" learned new action "fixup", that squashes the change
+ * "git rebase -i" learned new action "fixup" that squashes the change
    but does not affect existing log message.
 
- * "git rebase -i" also learned --autosquash option, that is useful
+ * "git rebase -i" also learned --autosquash option that is useful
    together with the new "fixup" action.
 
- * "git remote" learned set-url subcommand, to update (surprise!) url
+ * "git remote" learned set-url subcommand that updates (surprise!) url
    for an existing remote nickname.
 
  * "git rerere" learned "forget path" subcommand.  Together with "git
-- 
1.7.0.rc2.186.gbb211
