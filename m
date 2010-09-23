From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] contrib/completion: --no-index option to git diff
Date: Thu, 23 Sep 2010 14:33:51 +0200
Message-ID: <7d6649a466d452ed428e6d378cba11bc2360a788.1285245189.git.git@drmicha.warpmail.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 14:33:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oykzm-0003Z1-S9
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab0IWMdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 08:33:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59288 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755062Ab0IWMdo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 08:33:44 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C0A48728;
	Thu, 23 Sep 2010 08:33:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 23 Sep 2010 08:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=nH9GwdmEQNhv4dflHwFvai1qE1g=; b=I8r55O1AoEfruykrvbBJZqyZ1y6cQRtO5D+C0a28X7mMiLB+et+n9I/HJGbWBcsQ1f7Vf7hyQKca3YkGvMbe7XYU4TDGTfs0RZAIzREDimq1+PplyXmoiToIT/G3MH7wmvveJkocfEHJ0ssSksefiwNh07sgJX+vSDVvZwlzM0Y=
X-Sasl-enc: fnEtCPTZgteMe3029KjxalChlQdOwbeSkILsh502XdVM 1285245223
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F87F5E9779;
	Thu, 23 Sep 2010 08:33:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.67.g2a10b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156865>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index feab651..64341d5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1131,7 +1131,7 @@ _git_diff ()
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs
+			--base --ours --theirs --no-index
 			$__git_diff_common_options
 			"
 		return
-- 
1.7.3.67.g2a10b7
