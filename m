From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] completion: --no-abbrev-commit for git-log and git-show
Date: Mon, 13 Feb 2012 17:57:50 +0100
Message-ID: <4F39410E.3060708@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 17:59:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwzFD-0002R3-8A
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 17:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab2BMQ7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 11:59:10 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58874 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab2BMQ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 11:59:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 9A415DE901;
	Mon, 13 Feb 2012 17:59:06 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRwl9ZMCAHIA; Mon, 13 Feb 2012 17:59:06 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 70C70DE8FE;
	Mon, 13 Feb 2012 17:59:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120212 Thunderbird/10.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190639>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d7367e9..22d7018 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1587,7 +1587,7 @@ _git_log ()
 			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
-			--abbrev-commit --abbrev=
+			--abbrev-commit --no-abbrev-commit --abbrev=
 			--relative-date --date=
 			--pretty= --format= --oneline
 			--cherry-pick
@@ -2384,7 +2384,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --oneline
+		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit --online
 			$__git_diff_common_options
 			"
 		return
-- 
1.7.9.324.g3d1db
