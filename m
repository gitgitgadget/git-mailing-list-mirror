From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 2/2] completion: Get rid of tabbed indentation in comments. Replace with spaces.
Date: Fri,  6 Feb 2009 10:46:50 -0500
Message-ID: <1233935210-4941-3-git-send-email-ted@tedpavlic.com>
References: <1233935210-4941-1-git-send-email-ted@tedpavlic.com>
 <1233935210-4941-2-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSwX-0004Z0-MZ
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbZBFPrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbZBFPrE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:47:04 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42954 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753599AbZBFPrD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:47:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 56EB680D8063;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-rulWtow225; Fri,  6 Feb 2009 10:40:40 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 28C6580D8068;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233935210-4941-2-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108743>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/git-completion.bash |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e04985..f44f63c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,11 +34,11 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
-#	In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
-#	value, unstaged (*) and staged (+) changes will be shown next
-#	to the branch name.  You can configure this per-repository
-#	with the bash.showDirtyState variable, which defaults to true
-#	once GIT_PS1_SHOWDIRTYSTATE is enabled.
+#       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
+#       value, unstaged (*) and staged (+) changes will be shown next
+#       to the branch name.  You can configure this per-repository
+#       with the bash.showDirtyState variable, which defaults to true
+#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
 #
 # To submit patches:
 #
-- 
1.6.1.2.319.gbd9e
