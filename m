From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] Documentation/git-worktree: fix duplicated 'from'
Date: Tue,  4 Aug 2015 14:27:57 +0200
Message-ID: <1438691278-31609-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbKt-0006Ns-C7
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbbHDM2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:28:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59126 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933440AbbHDM2n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 08:28:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0D12C209E3
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 08:28:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 04 Aug 2015 08:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Nri4QzfTewM5s4SjqXWVdYnVcM
	U=; b=gdQNImaej6f27J4oHiPipNnv36p0jIavv1Ysq9gEDBWDKBmV3/JZJ0iyjP
	ypIPkZRUMwVkavSVdbTdlqY+FdktOiO1GzuUOoZoXKZpCCJRc3F4Lu8HSNHD84Js
	t0RBoJQUTKGscpyrgMEbchnISz8/y82x2yqrSKGgqTBELU4vw=
X-Sasl-enc: +7VBODfF4wmI/kNq6+QQQL0ZgWHEAuWygWffd2uuCr9n 1438691322
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 892BD6801B8;
	Tue,  4 Aug 2015 08:28:42 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275250>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3387e2f..566ca92 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -124,7 +124,7 @@ thumb is do not make any assumption about whether a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
 
-To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), add a file named
 'locked' to the entry's directory. The file contains the reason in
-- 
2.5.0
