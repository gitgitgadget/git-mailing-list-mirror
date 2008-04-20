From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add completion for git diff --base --ours --theirs
Date: Sun, 20 Apr 2008 22:32:47 +0300
Message-ID: <20080420193247.GA21023@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:33:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnfIL-0002Pu-5Z
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbYDTTcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756141AbYDTTcx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:32:53 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:53063 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755900AbYDTTcw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 15:32:52 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn2.hy.skanova.net (7.3.129)
        id 478BE66300580CBF; Sun, 20 Apr 2008 21:32:51 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JnfHL-0005TK-S6; Sun, 20 Apr 2008 22:32:47 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79979>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I guess these options should be documented in git-diff.txt too but I'm
hesitant to do it because my understanding of merge stages isn't quite
enough.


 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4d81963..6949cac 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -641,6 +641,7 @@ _git_diff ()
 			--ignore-all-space --exit-code --quiet --ext-diff
 			--no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
+			--base --ours --theirs
 			"
 		return
 		;;
-- 
1.5.5.84.g295c
