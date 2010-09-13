From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/6] git-reset.txt: clarify branch vs. branch head
Date: Mon, 13 Sep 2010 10:06:31 +0200
Message-ID: <4cb6432e6fc534231841ca8301b9022fa038946c.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:16:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4Dh-0004ll-OQ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab0IMIQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35651 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434Ab0IMIQV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:21 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2010 04:16:21 EDT
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 411951F0;
	Mon, 13 Sep 2010 04:06:36 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 13 Sep 2010 04:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=JemIq2bHSgPrQBqiuYOBq2SFHVg=; b=R8sjPUArmSuzzz7DagxjL+RxNRsNExBIoXBUh9ipg1+XlWr4ROK0GkiNM/9KPtU2NakG33sghO1Xche9KAfEyMCz3NRzDFlE39PY2beIjYSkuI3JO8U7BLDO59ukuRPNcgbahWr6ztbirBsyRaoWn4T5aHyHd6SMUBVbgO/u/lg=
X-Sasl-enc: 4Tmz+clZxBkfJv5c2u10mJi1Pbb7v0pT89ueO0cYZM69 1284365195
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B7A0B5E1BCD;
	Mon, 13 Sep 2010 04:06:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156077>

"Change the branch" can be misunderstood to mean "change which branch is
checked out". Make it clearer that git-reset changes the branch head of
the currently checked out branch.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 9cf3148..7d68b4c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 In the first and second form, copy entries from <commit> to the index.
-In the third form, set the current branch to <commit>, optionally
+In the third form, set the current branch head to <commit>, optionally
 modifying index and worktree to match.  The <commit> defaults to HEAD
 in all forms.
 
@@ -36,7 +36,7 @@ This means that `git reset -p` is the opposite of `git add -p` (see
 linkgit:git-add[1]).
 
 'git reset' [--<mode>] [<commit>]::
-	This form points the current branch to <commit> and then
+	This form sets the current branch head to <commit> and then
 	updates index and working tree according to <mode>, which must
 	be one of the following:
 +
-- 
1.7.3.rc1.215.g6997c
