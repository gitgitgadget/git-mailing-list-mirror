From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/6] git-reset.txt: reset --soft is not a no-op
Date: Mon, 13 Sep 2010 10:06:33 +0200
Message-ID: <f30121dda2c44d2a87f2d2bf651d6a0adfa8c955.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4DG-0004Wz-0J
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0IMIQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60318 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920Ab0IMIQV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:21 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E8032201;
	Mon, 13 Sep 2010 04:06:39 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 13 Sep 2010 04:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=2WHOkLFeQErtN93iaCW18Gmmq7g=; b=NDw5m7ZHZFb7V5svzpBSHOzQXr0kMvXBhjPBrG8Zy+/gKDE+yJAj/7CljL2Iv1z+xufVRkMYXsRN2tzUHzNqB6VvB9Dv1iFPyP1f18dJi2LS9wY6Uz//aaYbo5cJuqjtWeJbY4D01evFKzlRALCkpDY+hy6mblkZdcXyfkrBsYU=
X-Sasl-enc: SltE2LTsLucM5C20kayYWKeTuh8tl1qxtW1TsuDjwH6p 1284365199
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6EED05E1BCD;
	Mon, 13 Sep 2010 04:06:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156075>

Make it clearer that git reset --soft actually does something (changing
HEAD). While it is meantioned in the previous paragraph already it can
be easily overlooked otherwise.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8fb871c..65f5d07 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -43,7 +43,8 @@ linkgit:git-add[1]).
 --
 --soft::
 	Does not touch the index file nor the working tree at all, but
-	requires them to be in a good order. This leaves all your changed
+	requires them to be in good order (and sets the head to <commit>,
+	just like all modes do). This leaves all your changed
 	files "Changes to be committed", as 'git status' would
 	put it.
 
-- 
1.7.3.rc1.215.g6997c
