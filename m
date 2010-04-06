From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] completion: --set-upstream option for git-branch
Date: Tue,  6 Apr 2010 09:20:43 +0800
Message-ID: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1270516663.git.git@drmicha.warpmail.net>
References: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1269617202.git.git@drmicha.warpmail.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 03:20:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyxTL-0000sa-4x
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab0DFBUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:20:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59794 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236Ab0DFBUt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:20:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D2178EA999;
	Mon,  5 Apr 2010 21:20:48 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 05 Apr 2010 21:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=XYhJwCfpag0hGSeZV/B86vZePJQ=; b=pvaeHhP3s+CaSxBtM9JGuLQMRLE+dTplctIT/oIuBv/g9CizbuwSpLXJOgv0ppmUqB0VUrdkoZZt9rofsvuE5wabowU5q+iHdZjHzdlVNVSyTwkKu9S67yAqccZLbl4GVW/LU9U+ng0dUKOfGNFYlKfnmqR2VsG+sxuMRUjnYuA=
X-Sasl-enc: lI3Y+m0YKyr+XfhXF/oFieITXywSa44c+f5exZ6oaiee 1270516847
Received: from localhost (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8240434E56;
	Mon,  5 Apr 2010 21:20:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4.552.gc303c
In-Reply-To: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1269617202.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144075>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Bump...

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
1.7.0.4.552.gc303c
