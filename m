From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: [PATCH] git-commit: do not fail to print the diffstat even if
	there is a file named HEAD
Date: Mon, 08 Jan 2007 20:23:13 +0100
Message-ID: <1168284194.6134.12.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 08 20:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H405q-0007IK-UF
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 20:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbXAHTXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXAHTXY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 14:23:24 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:34033 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030517AbXAHTXX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 14:23:23 -0500
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36274>

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---
 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 04aad5e..c2beb76 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -628,7 +628,7 @@ then
 	if test -z "$quiet"
 	then
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD
+		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
 	fi
 fi
 
-- 
1.4.4.4.g49df
