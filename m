From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] squash! bash-completion: add support for git-log --merges= and log.merges
Date: Tue, 21 Apr 2015 14:51:24 +0200
Message-ID: <1429620684-7760-1-git-send-email-szeder@ira.uka.de>
References: <1428938968-19013-5-git-send-email-koosha@posteo.de>
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Koosha Khajehmoogahi <koosha@posteo.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkXeW-0002t4-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 14:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbbDUMvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 08:51:44 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59295 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752744AbbDUMvn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 08:51:43 -0400
Received: from x590cdc95.dyn.telefonica.de ([89.12.220.149] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YkXeN-0005uA-Nj; Tue, 21 Apr 2015 14:51:41 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1428938968-19013-5-git-send-email-koosha@posteo.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1429620701.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267526>

---
The patch at the tip of kk/log-merges-config misindented one of the case
arms, this one amends it.

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a75d7f5..83b2359 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1454,9 +1454,9 @@ _git_log ()
 	--merges=*)
 		__gitcomp "show hide only" "" "${cur##--merges=}"
 		return
 		;;
-		--*)
+	--*)
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
-- 
1.9.5.msysgit.0
