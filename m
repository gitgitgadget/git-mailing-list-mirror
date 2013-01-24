From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/4] git-mergetool: remove redundant assignment
Date: Thu, 24 Jan 2013 19:55:14 +0000
Message-ID: <25bfcc56fca4181f9ee97360de801139ffa8ce18.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySuH-0007KY-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab3AXTzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:55:55 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55606 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3AXTzw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:55:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 793562319B;
	Thu, 24 Jan 2013 19:55:51 +0000 (GMT)
X-Quarantine-ID: <Ym2VTMqFnA2K>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ym2VTMqFnA2K; Thu, 24 Jan 2013 19:55:51 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 73B5F23100;
	Thu, 24 Jan 2013 19:55:43 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1.364.gbbf604e.dirty
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214447>

TOOL_MODE is set at the top of git-mergetool.sh so there is no need to
set it again in show_tool_help.  Removing this lets us re-use
show_tool_help in git-difftool.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 89a857f..1748315 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -175,7 +175,6 @@ list_merge_tool_candidates () {
 }
 
 show_tool_help () {
-	TOOL_MODE=merge
 	list_merge_tool_candidates
 	unavailable= available= LF='
 '
-- 
1.8.1
