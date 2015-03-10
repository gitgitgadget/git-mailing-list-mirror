From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] config,completion: add color.status.unmerged
Date: Tue, 10 Mar 2015 17:11:09 +0100
Message-ID: <1e27ed382c4dc09ee5993b828c16b89e34d1cdf4.1426003811.git.git@drmicha.warpmail.net>
References: <CAKHLQpFPJS2rp-QswBSmO72yx253LZC-LTZCimk+f+un0tAWZg@mail.gmail.com>
Cc: "Mladen B." <mladen074@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 17:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVMkY-0006AL-GE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 17:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbbCJQLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 12:11:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50865 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbbCJQLL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 12:11:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8EF54206CB
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 12:11:09 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 10 Mar 2015 12:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=j84Zy/zYBrzUSb
	eUULOWCFVSAoo=; b=DFYJPAy5EkMEPgUG5ZzwltNb7wYTb7J9PjYSBZK5+oEqfW
	vHUMnP+gtYnrkHwDVfEiFNeeMHEx/B1Mp/9wZ5hXjw+v+q7r7Ual8HzplxKpcdno
	HV359TlGC96PSzeleLo8AEW5E9oCbXaWT607gS/hDKpu2vceJtlHr0XETs/Hw=
X-Sasl-enc: xLzS40S6nkrfLVYW8N2lMsansOVbXraI0AMJ3Oly8EpM 1426003870
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B665E680133;
	Tue, 10 Mar 2015 12:11:10 -0400 (EDT)
X-Mailer: git-send-email 2.3.2.346.gb6960c9
In-Reply-To: <CAKHLQpFPJS2rp-QswBSmO72yx253LZC-LTZCimk+f+un0tAWZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265242>

Reported-by: "Mladen B." <mladen074@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt               | 6 ++++--
 contrib/completion/git-completion.bash | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a158e7f..bc22eee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -958,9 +958,11 @@ color.status.<slot>::
 	`added` or `updated` (files which are added but not committed),
 	`changed` (files which are changed but not added in the index),
 	`untracked` (files which are not tracked by Git),
-	`branch` (the current branch), or
+	`branch` (the current branch),
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
+	to red), or
+	`unmerged` (files which have unmerged changes).
+	The values of these variables may be specified as in
 	color.branch.<slot>.
 
 color.ui::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..e310f31 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2014,6 +2014,7 @@ _git_config ()
 		color.status.changed
 		color.status.header
 		color.status.nobranch
+		color.status.unmerged
 		color.status.untracked
 		color.status.updated
 		color.ui
-- 
2.3.2.346.gb6960c9
