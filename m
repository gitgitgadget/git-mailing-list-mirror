From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH 4/4] rebase-interactive: use --quiet rather than 2>/dev/null
Date: Fri, 19 Mar 2010 22:18:38 -0400
Message-ID: <1269051518-25099-4-git-send-email-bmeyer@rim.com>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoHX-0003E6-J0
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab0CTCTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 22:19:07 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:50943
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917Ab0CTCSy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 22:18:54 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id vE8M1d0040EZKEL58EJvmZ; Sat, 20 Mar 2010 02:18:55 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id vEJo1d00g0dnthT3MEJuPM; Sat, 20 Mar 2010 02:18:55 +0000
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142674>

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..6f6748c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -793,7 +793,7 @@ first and then run 'git rebase --continue' again."
 		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
-		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
+		git symbolic-ref --quiet HEAD > "$DOTEST"/head-name ||
 			echo "detached HEAD" > "$DOTEST"/head-name
 
 		echo $HEAD > "$DOTEST"/head
-- 
1.7.0.2
