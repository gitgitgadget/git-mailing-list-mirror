From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] completion: --set-upstream option for git-branch
Date: Fri, 26 Mar 2010 16:28:26 +0100
Message-ID: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1269617202.git.git@drmicha.warpmail.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBVL-0000dV-SQ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0CZPbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:31:18 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53477 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab0CZPbR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 11:31:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 792D7E9C84;
	Fri, 26 Mar 2010 11:31:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 26 Mar 2010 11:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=oRVcIRO5+5pK8h74Qjp4DqnWnF8=; b=IwKn8zIOKDSeO8fdHtPIxqWIIuM65JivrXyyIK25NT47aMnPKAkqj6GEry0tPU+1sCIOqX1A/1xobeQXRgnzBEhTtfqTUhvhG5J4nF+vZf6ah9Pxlr0jbQgdqMkCltozbgW0iO3U7HlDEG3xhIOdg2q5DYoUQBcsae2wz/AO7pk=
X-Sasl-enc: qvB6JK4kaBGlkWyp1sPLw/3Onh0K9fyb0eTD13FVLENH 1269617475
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7BA14975E;
	Fri, 26 Mar 2010 11:31:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.448.g82eeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143251>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
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
1.7.0.3.448.g82eeb
