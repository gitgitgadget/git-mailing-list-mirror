From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] contrib/completion: --notes, --no-notes
Date: Thu, 14 Apr 2011 19:53:13 +0200
Message-ID: <6feb8ab2eeeaed4445228893d9b1bb12f60667fe.1302803560.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQjR-0005lC-R0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933418Ab1DNRxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:53:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50181 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933404Ab1DNRxR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 13:53:17 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E492420CBF
	for <git@vger.kernel.org>; Thu, 14 Apr 2011 13:53:16 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 14 Apr 2011 13:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=3UAlTyGRFvV0ol/eSw6E1E2VrHI=; b=HVv7Zvare8yh5UIKls3Dns/RIAX4ftxaLdXhtDj5Vkl1ZwAP5Ujw6eVdLB4vYqWfS9r+0JqtW3Xll1bCTBERsZEPeEPJxG/pQRvmZ/HuH8hHATqNGdeDo+P5KeN3kJ33+sz0otOVCAwQxjLsuG6K+djmQUNQxWGR2DwMSRU1eHo=
X-Sasl-enc: S2+T3G/+MCzfr4I6QQv+dabiV7ZGwJtAzBhCdPJiDbZC 1302803596
Received: from localhost (p54859211.dip0.t-ipconnect.de [84.133.146.17])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6005E44121B;
	Thu, 14 Apr 2011 13:53:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1.312.g1936c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171530>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
on top of jk/notes-ui-updates
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..7e6a3ee 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1584,7 +1584,7 @@ __git_log_common_options="
 __git_log_gitk_options="
 	--dense --sparse --full-history
 	--simplify-merges --simplify-by-decoration
-	--left-right
+	--left-right --notes --no-notes
 "
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
-- 
1.7.5.rc1.312.g1936c
