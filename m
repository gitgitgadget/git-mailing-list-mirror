From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 25/28] t5540-http-push: remove redundant fetches
Date: Fri, 30 Oct 2009 17:47:44 -0700
Message-ID: <1256950067-27938-27-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429u-0001yQ-30
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbZJaAss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933118AbZJaAsr
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:47 -0400
Received: from george.spearce.org ([209.20.77.23]:36968 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115AbZJaAsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:48:00 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2410F381FF; Sat, 31 Oct 2009 00:48:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7CDD13826B;
	Sat, 31 Oct 2009 00:47:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131804>

From: Tay Ray Chuan <rctay89@gmail.com>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5540-http-push.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 2ece661..28a746e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -116,9 +116,7 @@ test_expect_success 'create and delete remote branch' '
 	test_tick &&
 	git commit -m dev &&
 	git push origin dev &&
-	git fetch &&
 	git push origin :dev &&
-	git fetch &&
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
-- 
1.6.5.2.181.gd6f41
