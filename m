From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] t6006: do not write to /tmp
Date: Fri, 16 Apr 2010 20:29:18 -0600
Message-ID: <1271471358-17663-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 17 04:29:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2xmz-0003eU-Gf
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 04:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698Ab0DQC3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 22:29:25 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:59993 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758634Ab0DQC3Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 22:29:25 -0400
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id 6QN01e00C1wfjNsA2SVRax; Sat, 17 Apr 2010 02:29:25 +0000
Received: from mmogilvi.homeip.net ([67.190.99.184])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id 6SVQ1e0013yhxvF8jSVQqN; Sat, 17 Apr 2010 02:29:24 +0000
Received: from localhost.localdomain (rand.mmogilvi.local [192.168.30.68])
	by mmogilvi.homeip.net (Postfix) with ESMTP id D14AB1E9625C;
	Fri, 16 Apr 2010 20:29:22 -0600 (MDT)
X-Mailer: git-send-email 1.7.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145108>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t6006-rev-list-format.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index d24ca5c..53bf8f4 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -213,7 +213,7 @@ test_expect_success 'oneline with empty message' '
 	git commit -m "dummy" --allow-empty &&
 	git commit -m "dummy" --allow-empty &&
 	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
-	git rev-list --oneline HEAD > /tmp/test.txt &&
+	git rev-list --oneline HEAD > test.txt &&
 	test $(git rev-list --oneline HEAD | wc -l) -eq 5 &&
 	test $(git rev-list --oneline --graph HEAD | wc -l) -eq 5
 '
-- 
1.7.0.GIT
