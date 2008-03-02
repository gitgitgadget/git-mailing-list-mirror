From: drafnel@gmail.com
Subject: [PATCH 2/4] t3903-stash.sh: use test_must_fail instead of '!' notation
Date: Sun,  2 Mar 2008 14:58:49 -0600
Message-ID: <5952365.1204491506490.JavaMail.teamon@b308.teamon.com>
References: <1204491531-29758-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 22:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvUq-00048E-R9
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbYCBVMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbYCBVMs
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:12:48 -0500
Received: from www.teamon.com ([216.34.91.250]:39862 "EHLO b308.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755495AbYCBVMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:12:47 -0500
X-Greylist: delayed 822 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Mar 2008 16:12:47 EST
Received: from b308.teamon.com (localhost [127.0.0.1])
	by b308.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m22KwQ022310;
	Sun, 2 Mar 2008 20:58:26 GMT
X-Mailer: git-send-email 1.5.4.3.412.gcd100
In-Reply-To: <1204491531-29758-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75839>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t3903-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 50a2c83..2418f47 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -41,7 +41,7 @@ test_expect_success 'apply needs clean working directory' '
 	echo 4 > other-file &&
 	git add other-file &&
 	echo 5 > other-file &&
-	! git stash apply
+	test_must_fail git stash apply
 '
 
 test_expect_success 'apply stashed changes' '
-- 
1.5.4.3.412.gcd100

