From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t2026: rename worktree prune test
Date: Tue,  6 Oct 2015 12:12:21 +0200
Message-ID: <4ede3e12b9924d218c10007ec1ad7536ee9a7866.1444126246.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 12:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjPES-0007MR-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 12:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbJFKMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 06:12:24 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36505 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751597AbbJFKMY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 06:12:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 95A2D209F2
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 06:12:23 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 06 Oct 2015 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=K4IzHOXotQGUUUoE+frW9G7iKf0=; b=fPcQAPPVk4eQjI3hMx7BWv9swBD/
	GwK8zh95qn1cGZ2UqVhJUvb79u/XZZN09ZXg0UqRNfau88t5tB/ZzWjBWyX2OT3N
	MkUw8+rN/kxr9dglF5eedJPMOfwWwE3pX3i5127VE2BebsuMLdEWLReOZ6QC0bn2
	/qVKb9I9BMUqVNY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=K4IzHOXotQGUUUoE+frW9G7iKf
	0=; b=ZNCLhioV287J/9zf8uye4YIGSHo+7lRtUsEXs+odjdmfSLoyWz+/rOj3RR
	J/4foBgext4wqkVD4TKzUjcclN+ZYzebfAvm7peJGBg7YOLHGsRzWSE/XwxtGkh0
	ZXMJZQN0g6JVz+MzB5nHdYMBskhmpo/ef9k8AS+XaHyc4/yKk=
X-Sasl-enc: OCPyTIuWm2K8QO69U8U23v0sMB1xoaQwR0qToEBP8gEl 1444126343
Received: from localhost (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 21616C00013;
	Tue,  6 Oct 2015 06:12:23 -0400 (EDT)
X-Mailer: git-send-email 2.6.1.281.g558ac77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279127>

Linked checkouts are known under the name worktree, now. Rename the test
accordingly.

Specifically, this avoids the confusion that t2026 is actually not about
pruning in or with linked checkouts aka worktress but about pruning
worktrees, i.e. about "git worktree prune" rather than "git prune".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Noted while looking into the "git prune" issue and trying to find a place
for "git prune" tests with extra worktrees.

 t/{t2026-prune-linked-checkouts.sh => t2026-worktree-prune.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2026-prune-linked-checkouts.sh => t2026-worktree-prune.sh} (100%)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-worktree-prune.sh
similarity index 100%
rename from t/t2026-prune-linked-checkouts.sh
rename to t/t2026-worktree-prune.sh
-- 
2.6.1.281.g558ac77
