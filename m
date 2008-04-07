From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2] bash: Add more command line option completions for 'git log'
Date: Mon,  7 Apr 2008 15:25:47 +0300
Message-ID: <1207571147-4873-1-git-send-email-tlikonen@iki.fi>
References: <1207517128-9776-1-git-send-email-tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 14:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiqRC-0004MJ-4w
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 14:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbYDGMZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 08:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYDGMZv
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 08:25:51 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:49107 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758159AbYDGMZt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 08:25:49 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB960049F5C8 for git@vger.kernel.org; Mon, 7 Apr 2008 14:25:48 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JiqPz-0001Gv-8r
	for git@vger.kernel.org; Mon, 07 Apr 2008 15:25:47 +0300
X-Mailer: git-send-email 1.5.5.rc3.24.g129ac
In-Reply-To: <1207517128-9776-1-git-send-email-tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78971>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

Hmm, why not add some more useful long options? There are plenty of them of
course but I feel these are one of the most common.


 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4d81963..02a5fd3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -757,6 +757,8 @@ _git_log ()
 			--pretty= --name-status --name-only --raw
 			--not --all
 			--left-right --cherry-pick
+			--graph --stat --numstat --shortstat
+			--decorate --diff-filter=
 			"
 		return
 		;;
-- 
1.5.5.rc3.24.g129ac
