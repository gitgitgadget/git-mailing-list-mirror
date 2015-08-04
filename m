From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] Documentation/git-worktree: fix reference to 'locked' file
Date: Tue,  4 Aug 2015 14:27:58 +0200
Message-ID: <1438691278-31609-2-git-send-email-ps@pks.im>
References: <1438691278-31609-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbKt-0006Ns-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933476AbbHDM2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:28:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41263 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933444AbbHDM2p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 08:28:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B2B1520AC4
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 08:28:44 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 04 Aug 2015 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=R9It
	nFORSAWiSbAiFMC/kRZo5JA=; b=D/cI3ooRd0Wtz0CRxqgGMaB4Rh19xQdbTANv
	yN7l4lhx01c6/GvcO+JyKEdp3RJl5qhnfyJ2QNNOTMY5/v8wjVfqjLsekcAmvZFg
	SgA+hmY316cBhrN9/+SLK8pCsB6HEjK67w1sQ4yjODmuXSRkvPo2b5lQOGPlHXB7
	T2FkA/k=
X-Sasl-enc: RNuhatQ5/HJlVnuz/fH/pRtdxJnDXkn3wBBIb6GdlohW 1438691324
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3B593C00018;
	Tue,  4 Aug 2015 08:28:44 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438691278-31609-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275251>

The documentation of git-worktree refers to the 'locked' file as
'lock'. Fix this to say 'locked' instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 566ca92..3fedd9e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
 
 If a linked working tree is stored on a portable device or network share
 which is not always mounted, you can prevent its administrative files from
-being pruned by creating a file named 'lock' alongside the other
+being pruned by creating a file named 'locked' alongside the other
 administrative files, optionally containing a plain text reason that
 pruning should be suppressed. See section "DETAILS" for more information.
 
-- 
2.5.0
