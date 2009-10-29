From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 25/26] t5540-http-push: remove redundant fetches
Date: Wed, 28 Oct 2009 17:00:47 -0700
Message-ID: <1256774448-7625-26-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISr-0000kN-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbZJ2ABh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbZJ2ABe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:34 -0400
Received: from george.spearce.org ([209.20.77.23]:36264 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbZJ2ABA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:01:00 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EC1E4381D3; Thu, 29 Oct 2009 00:01:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B269638262;
	Thu, 29 Oct 2009 00:00:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131530>

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
