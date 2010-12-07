From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-rm.txt: Fix quoting
Date: Tue,  7 Dec 2010 10:07:11 +0100
Message-ID: <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
References: <4CFDF388.6060907@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 10:09:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPtYJ-0006li-Kt
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 10:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab0LGJJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 04:09:33 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59628 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990Ab0LGJJc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 04:09:32 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9ED8E599;
	Tue,  7 Dec 2010 04:09:31 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 07 Dec 2010 04:09:31 -0500
X-Sasl-enc: 3yrzVdTUfNBLwwwon1ddx14o8rU3hm5xYLVyn7elWp/j 1291712971
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1CEB35E6F4C;
	Tue,  7 Dec 2010 04:09:31 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.660.g7cc83
In-Reply-To: <4CFDF388.6060907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163072>

Literal " produces typographically incorrect quotations, but "works" in
most circumstances. In the subheadings of git-rm.txt, it "works" for the
html backend but not for the docbook conversion to nroff: double "" and
spurious double spaces appear in the output.

Replace "incorrect" quotations by ``correct'' ones, and fix other
"quotations" which are really `code fragments`.

This should make git-rm.txt "-clean.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
We still have a lingering inconsistency for denoting code fragments.
Single backticks merely are a literal monospaced environment; html outputcolors
this, nroff does not indicate it at all. I'm staying consistent with the
surrounding text here.

 Documentation/git-rm.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 71e3d9f..dd61ebd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -89,7 +89,7 @@ the paths that have disappeared from the filesystem. However,
 depending on the use case, there are several ways that can be
 done.
 
-Using "git commit -a"
+Using ``git commit -a''
 ~~~~~~~~~~~~~~~~~~~~~
 If you intend that your next commit should record all modifications
 of tracked files in the working tree and record all removals of
@@ -98,7 +98,7 @@ files that have been removed from the working tree with `rm`
 automatically notice and record all removals.  You can also have a
 similar effect without committing by using `git add -u`.
 
-Using "git add -A"
+Using ``git add -A''
 ~~~~~~~~~~~~~~~~~~
 When accepting a new code drop for a vendor branch, you probably
 want to record both the removal of paths and additions of new paths
@@ -111,8 +111,8 @@ tree using this command:
 git ls-files -z | xargs -0 rm -f
 ----------------
 
-and then "untar" the new code in the working tree. Alternately
-you could "rsync" the changes into the working tree.
+and then `untar` the new code in the working tree. Alternately
+you could `rsync` the changes into the working tree.
 
 After that, the easiest way to record all removals, additions, and
 modifications in the working tree is:
-- 
1.7.3.2.660.g7cc83
