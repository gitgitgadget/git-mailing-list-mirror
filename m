From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Uncomment test case: git branch c/d should barf if
 branch c exists.
Date: Sat, 24 Mar 2007 06:30:21 +0100
Message-ID: <20070324063021.2520da21.chriscool@tuxfamily.org>
References: <20060928065845.38de4f94.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyhf-0006vW-L9
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbXCXFWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbXCXFWH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:22:07 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60724 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbXCXFWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:22:04 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1ABCAB55D3;
	Sat, 24 Mar 2007 06:22:04 +0100 (CET)
In-Reply-To: <20060928065845.38de4f94.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42976>

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
