From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add command line completion of --graph (git log)
Date: Mon,  7 Apr 2008 00:25:28 +0300
Message-ID: <1207517128-9776-1-git-send-email-tlikonen@iki.fi>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Cc: adam@adamsimpkins.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 23:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JicNV-0001cz-QE
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYDFVZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYDFVZb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:25:31 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:65205 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766AbYDFVZa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 17:25:30 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB9600492421; Sun, 6 Apr 2008 23:25:29 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JicMi-0002Y0-UH; Mon, 07 Apr 2008 00:25:28 +0300
X-Mailer: git-send-email 1.5.5-rc3.GIT
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78931>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 791e30f..cd26d0c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -754,6 +754,7 @@ _git_log ()
 			--pretty= --name-status --name-only --raw
 			--not --all
 			--left-right --cherry-pick
+			--graph
 			"
 		return
 		;;
-- 
1.5.5-rc3.GIT
