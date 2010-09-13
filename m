From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/6] git-reset.txt: point to git-checkout
Date: Mon, 13 Sep 2010 10:06:35 +0200
Message-ID: <520620a60966ebdfa6e1fe8b407b0de51c302b82.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4DH-0004Wz-1X
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab0IMIQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36184 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752637Ab0IMIQV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:21 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A2EB12E8;
	Mon, 13 Sep 2010 04:06:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 13 Sep 2010 04:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=D58ckgFVlxb4pIOMteODtpBRYoY=; b=DLOyaH5GmpifWV1YNBMGtco/vQOp/7Dfli3jmePbBhcaJbSz/8DC4m6m8edqJQqLStqH8lFQE6NrO3D9e3uponT3leMPOwkQXpl9hkroB50vEfVR9eRtmLBA8RYaXrch8tU576dJbcjlTS+OqSes47POlH82dZij6PEJBXxJ8WI=
X-Sasl-enc: 13y7BckPPg1/aZTg54f323qNn5E9SQQrl7NGoXItUhZb 1284365203
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 233C85E2758;
	Mon, 13 Sep 2010 04:06:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156074>

for the case of updating a file in index and worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 60b4b80..40e2fd8 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -27,6 +27,9 @@ in all forms.
 This means that `git reset <paths>` is the opposite of `git add
 <paths>`.
 
+If you want to reset index entry and working tree state of a file,
+linkgit:git-checkout[1] is your friend.
+
 'git reset' --patch|-p [<commit>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
 	and <commit> (defaults to HEAD).  The chosen hunks are applied
-- 
1.7.3.rc1.215.g6997c
