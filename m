From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: A...B shortcut for checkout and rebase
Date: Tue,  1 Jun 2010 17:16:42 +0200
Message-ID: <380480a004c2d5f80ba96324562172f3b2b42f3e.1275405181.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 17:17:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTDX-0007Ex-0y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab0FAPRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:17:18 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35489 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755823Ab0FAPRR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:17:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3CE09F8A80;
	Tue,  1 Jun 2010 11:17:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 01 Jun 2010 11:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=Z7fhH6gnjH8J00VVT7yjuybKZ8E=; b=j+Pp3dUrfpPdmYEL7Pf6PyKPzUG0zMN4oakCVtpmn9LnnlSUV0UanAKvNU9Z3lIPOgTIU/dv1aS0NxMhDEZUTFrt2t/cACl7MgOCNwuYOLCcj6gjTyaILNI3TLRaMxRg9sYxy9g0Vdmvlkoh9rQDTvLgbuL4Uq0bZJO9UekgfOI=
X-Sasl-enc: /rLGxhKupG5QNGGnq0xokhKszvoSKeKoQHrQSKyd3kVU 1275405423
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 59A934E5900;
	Tue,  1 Jun 2010 11:17:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148125>

Describe the A...B shortcuts for checkout and rebase [-i] which were
introduced in these commits:

619a64e ("checkout A...B" switches to the merge base between A and B, 2009-10-18)
61dfa1b ("rebase --onto A...B" replays history on the merge base between A and B, 2009-11-20)
230a456 (rebase -i: teach --onto A...B syntax, 2010-01-07)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The style in the two hunks is different so that it matches the surrounding
text. Talking about a style guide...

 Documentation/git-checkout.txt |    4 ++++
 Documentation/git-rebase.txt   |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4505eb6..afda5c3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -154,6 +154,10 @@ edits from your current working tree.
 As a special case, the `"@\{-N\}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
 `-` which is synonymous with `"@\{-1\}"`.
++
+As a further special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 <new_branch>::
 	Name for the new branch.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5863dec..50ba2e4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -206,6 +206,10 @@ OPTIONS
 	--onto option is not specified, the starting point is
 	<upstream>.  May be any valid commit, and not just an
 	existing branch name.
++
+As a special case, you may use "A...B" as a shortcut for the
+merge base of A and B if there is exactly one merge base. You can
+leave out at most one of A and B, in which case it defaults to HEAD.
 
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
-- 
1.7.1.351.ge2633e
