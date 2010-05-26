From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] completion: --set-upstream option for git-branch
Date: Wed, 26 May 2010 10:46:41 +0200
Message-ID: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1274863387.git.git@drmicha.warpmail.net>
References: <20100525195303.GA8174@atjola.homenet>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 10:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCGl-0007UC-Ut
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933939Ab0EZIrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 04:47:14 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55399 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933391Ab0EZIrN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 04:47:13 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7C274F878C;
	Wed, 26 May 2010 04:46:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 26 May 2010 04:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ns/0aKq42Ia/4a0/3ieg7YLn+wQ=; b=pUvkV/P0npmSgJYlxFQRZJlYSR+0iBaIT+MMeRpZbNuholJe8VXcY9RmXWp8Ve17LFcOLyiyB/ZEI8Nued9pLcYJXLa+Cznt5v4Yc2xnjlrSSyJowGcsAwqoZVUZUWlfqs5Pz/hjO3He0BV7E+E2p6oRMDPw/kigdUOo6inDqRk=
X-Sasl-enc: p1aN0r9ml5R5GOy+Lf5TdX/yrtXikXcQnBk7kY/mJOWv 1274863617
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0FAD04D25FE;
	Wed, 26 May 2010 04:46:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.345.g59eb63
In-Reply-To: <20100525195303.GA8174@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147784>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
On that note, I'm still wondering what's wrong with this one ;)

 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 545bd4b..57245a8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -797,6 +797,7 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
+			--set-upstream
 			"
 		;;
 	*)
-- 
1.7.1.345.g59eb63
