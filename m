From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] completion: add missing git-rebase options
Date: Thu, 21 Jan 2016 20:52:24 +0000
Message-ID: <a9cad473995d70d929be14c7b1256a30273128af.1453409508.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 21:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMDr-0007t1-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 21:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbcAUUws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 15:52:48 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45826 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcAUUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 15:52:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 92A1ECDA2D4;
	Thu, 21 Jan 2016 20:52:46 +0000 (GMT)
X-Quarantine-ID: <oI6Tn2xSUvJC>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oI6Tn2xSUvJC; Thu, 21 Jan 2016 20:52:45 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D2B0CCDA567;
	Thu, 21 Jan 2016 20:52:37 +0000 (GMT)
X-Mailer: git-send-email 2.7.0.226.gfe986fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284524>

This adds the --no-* variants where those are documented in
git-rebase(1).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..7d6d63e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1685,8 +1685,12 @@ _git_rebase ()
 			--preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
-			--autosquash --fork-point --no-fork-point
-			--autostash
+			--autosquash --no-autosquash
+			--fork-point --no-fork-point
+			--autostash --no-autostash
+			--verify --no-verify
+			--keep-empty --root --force-rebase --no-ff
+			--exec
 			"
 
 		return
-- 
2.7.0.226.gfe986fe
