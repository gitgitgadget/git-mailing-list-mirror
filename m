From: drafnel@gmail.com
Subject: [PATCH] t/Makefile: update makefile to remove new spaceful trash directory
Date: Sat, 17 May 2008 23:03:03 -0500
Message-ID: <3559937.1211083293079.JavaMail.teamon@b304.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 18 06:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxa6Q-0001hO-Mu
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 06:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbYEREBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 00:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYEREBl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 00:01:41 -0400
Received: from mailproxy04.teamon.com ([64.14.130.33]:60033 "EHLO
	b304.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750716AbYEREBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 00:01:40 -0400
Received: from b304.teamon.com (localhost [127.0.0.1])
	by b304.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4I41X529561;
	Sun, 18 May 2008 04:01:33 GMT
X-Mailer: git-send-email 1.5.5.1.447.geb0a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82375>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 72d7884..c6a60ab 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -20,7 +20,7 @@ $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 clean:
-	$(RM) -r trash
+	$(RM) -r 'trash directory'
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
-- 
1.5.5.1.447.geb0a7
