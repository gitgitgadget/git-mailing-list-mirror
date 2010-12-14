From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git-difftool.txt: correct the description of $BASE and describe $MERGED
Date: Tue, 14 Dec 2010 10:18:34 +0100
Message-ID: <0833a4451b70db4c4e0be5753be53e262a9c5628.1292317348.git.git@drmicha.warpmail.net>
References: <4D073619.2010103@drmicha.warpmail.net>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 10:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSR4Q-0003yT-Ge
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab0LNJVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 04:21:06 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38798 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758129Ab0LNJVC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 04:21:02 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 19ABAB89;
	Tue, 14 Dec 2010 04:21:02 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 14 Dec 2010 04:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=QV4nlCwWT6gZKJOQroQ5prF1o2g=; b=e0gLgXK/QcRX+gKHHoSuLdwDuVRNTQ8pbEotDStCDfoEaItEnQrhdyoe4o++6kGKMQqijvNiBL1toiXhuwStBMdo41h5NPc1suA4p2xcwRDgrLLEgtAOKrTxTfqzzsncgHDN4ZHoH54KjZ95BjBygTXIwv8o3fUF0rw3+PtgWi0=
X-Sasl-enc: xMUPcZDJ/iN+dyrBuJGYh5tUa9mNdK+WU+v3GDATih0R 1292318461
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8B72840734D;
	Tue, 14 Dec 2010 04:21:01 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3.738.g018bc
In-Reply-To: <4D073619.2010103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163638>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-difftool.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 6fffbc7..756d95d 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -56,8 +56,9 @@ the configured command line will be invoked with the following
 variables available: `$LOCAL` is set to the name of the temporary
 file containing the contents of the diff pre-image and `$REMOTE`
 is set to the name of the temporary file containing the contents
-of the diff post-image.  `$BASE` is provided for compatibility
-with custom merge tool commands and has the same value as `$LOCAL`.
+of the diff post-image.  `$MERGED` is the name of the file which is
+being compared. `$BASE` is provided for compatibility
+with custom merge tool commands and has the same value as `$MERGED`.
 
 -x <command>::
 --extcmd=<command>::
-- 
1.7.3.3.739.g52f77.dirty
