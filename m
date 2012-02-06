From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] bash-completion: add --edit-description to choices for branch
Date: Mon,  6 Feb 2012 12:03:27 -0500
Message-ID: <1328547807-3374-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 18:03:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuRye-0008IU-Or
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 18:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab2BFRDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 12:03:36 -0500
Received: from mail.windriver.com ([147.11.1.11]:48202 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab2BFRDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 12:03:35 -0500
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q16H3Y2w001162;
	Mon, 6 Feb 2012 09:03:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190079>

Support was recently added to allow storing a branch description,
so teach bash completion about it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 78be195..a2965f7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1152,7 +1152,7 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
-			--set-upstream
+			--set-upstream --edit-description
 			"
 		;;
 	*)
-- 
1.7.9
