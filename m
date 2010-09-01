From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t7406 & t7407: add missing && at end of lines
Date: Wed, 01 Sep 2010 23:28:27 +0200
Message-ID: <4C7EC57B.2000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 23:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqurD-0006pR-Kj
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 23:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab0IAV23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 17:28:29 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49545 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab0IAV23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 17:28:29 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id EACDC15E8B5B7;
	Wed,  1 Sep 2010 23:28:27 +0200 (CEST)
Received: from [93.240.114.167] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oqur5-00043I-00; Wed, 01 Sep 2010 23:28:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19j1uRgVI4rTZk4dCgSzjpgJs52bHCtFbf7ReP1
	5XWXFhGYEgekbNk2GyqPf3avY1wbrMxwMhPwP1YTbXAYa4903j
	jBs2RFuHQd2cQYfgilxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155094>

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t7406-submodule-update.sh  |    2 +-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1382a8e..bfb4975 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -25,7 +25,7 @@ test_expect_success 'setup a submodule tree' '
 	echo file > file &&
 	git add file &&
 	test_tick &&
-	git commit -m upstream
+	git commit -m upstream &&
 	git clone . super &&
 	git clone super submodule &&
 	git clone super rebasing &&
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index db9365b..905a8ba 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup a submodule tree' '
 	echo file > file &&
 	git add file &&
 	test_tick &&
-	git commit -m upstream
+	git commit -m upstream &&
 	git clone . super &&
 	git clone super submodule &&
 	(
@@ -30,7 +30,7 @@ test_expect_success 'setup a submodule tree' '
 			submodule.sub2 submodule.foo2 &&
 		git config -f .gitmodules --rename-section \
 			submodule.sub3 submodule.foo3 &&
-		git add .gitmodules
+		git add .gitmodules &&
 		test_tick &&
 		git commit -m "submodules" &&
 		git submodule init sub1 &&
-- 
1.7.2.2.571.ge5a77
