From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/6] git-reset.txt: clarify branch vs. branch head
Date: Wed, 15 Sep 2010 22:47:39 +0200
Message-ID: <3ad8c4b01449e4d4563193bce9fd10365c59cccb.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 22:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovyun-0005JE-Il
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab0IOUrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:43 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45797 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997Ab0IOUrm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:42 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 924105F7;
	Wed, 15 Sep 2010 16:47:42 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 15 Sep 2010 16:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Nnh7dkvaOdTEgkxLe6+iTlSQH9c=; b=LJhbvz/JCybcQDSAGqooXNyMKZ5wycrkAxb38dNuMEtwWU0PEE6F4rP2DffNY/0f/DI5/lxjupkMcuMRuFTnrTbFic0ndXR4yt6ewowtOyyXuke/H21aorynBJtaTPIqtCDvdMLkRBLNO+X+KHKwJqpHKD3rTl/EzKgFdUU9RL4=
X-Sasl-enc: lpaYm9iIuYAJP8EtcaYk3rFwIGaf8jjJBUD4Ue9RCu/7 1284583661
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD34D400500;
	Wed, 15 Sep 2010 16:47:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284582409.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156252>

"Change the branch" can be misunderstood to mean "change which branch is
checked out". Make it clearer that git-reset changes the branch head of
the currently checked out branch.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 9cf3148..91bd2e9 100644
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
+	This form resets the current branch head to <commit> and then
 	updates index and working tree according to <mode>, which must
 	be one of the following:
 +
-- 
1.7.3.rc1.215.g6997c
