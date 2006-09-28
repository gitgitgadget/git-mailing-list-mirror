From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Uncomment test case: git branch c/d should barf if
 branch c exists.
Date: Thu, 28 Sep 2006 07:02:00 +0200
Message-ID: <20060928070200.c4041560.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:55:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnw3-0007NR-Ef
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWI1Ezp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWI1Ezo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:55:44 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:46754 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750846AbWI1Ezo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 00:55:44 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id 6811225A18;
	Thu, 28 Sep 2006 06:55:43 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27989>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3210-pack-refs.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 2cc03e6..193fe1f 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -37,12 +37,12 @@ test_expect_success \
      git-show-ref b >result &&
      diff expect result'
 
-# test_expect_failure \
-#     'git branch c/d should barf if branch c exists' \
-#     'git-branch c &&
-#      git-pack-refs &&
-#      rm .git/refs/heads/c &&
-#      git-branch c/d'
+test_expect_failure \
+    'git branch c/d should barf if branch c exists' \
+    'git-branch c &&
+     git-pack-refs &&
+     rm .git/refs/heads/c &&
+     git-branch c/d'
 
 test_expect_success \
     'see if a branch still exists after git pack-refs --prune' \
-- 
1.4.2.1.g3bab
