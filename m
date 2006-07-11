From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t1400-update-ref: set VISUAL=true as well as EDITOR=true
Date: Tue, 11 Jul 2006 01:41:20 -0700
Message-ID: <11526072802855-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 11 10:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0DoP-0000qO-5O
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 10:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWGKIlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWGKIlh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 04:41:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8665 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750754AbWGKIlg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 04:41:36 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 53CF27DC021;
	Tue, 11 Jul 2006 01:41:20 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 11 Jul 2006 01:41:20 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.g710d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23696>

I have VISUAL set in my environment, and it caused git-commit to
spawn my editor during the test.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t1400-update-ref.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6a3515d..4f5b6bd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -190,7 +190,7 @@ test_expect_success \
 	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -F M -a &&
 	 h_OTHER=$(git-rev-parse --verify HEAD) &&
 	 echo FIXED >F &&
-	 EDITOR=true \
+	 EDITOR=true VISUAL=true \
 	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend &&
 	 h_FIXED=$(git-rev-parse --verify HEAD) &&
-- 
1.4.1.g710d
