From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/4] add missing && to submodule-merge testcase
Date: Wed, 30 Jun 2010 21:23:48 +0200
Message-ID: <ed370d28d2e6f8fc3c5adc7042fd2b55b663fd08.1277923844.git.hvoigt@hvoigt.net>
References: <cover.1277923843.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 30 21:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU2tU-0007Ks-V4
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 21:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0F3TXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 15:23:55 -0400
Received: from darksea.de ([83.133.111.250]:55009 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755642Ab0F3TXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 15:23:54 -0400
Received: (qmail 18720 invoked from network); 30 Jun 2010 21:23:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 30 Jun 2010 21:23:52 +0200
X-Mailer: git-send-email 1.7.1.528.gb3958.dirty
In-Reply-To: <cover.1277923843.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1277923843.git.hvoigt@hvoigt.net>
References: <cover.1277923843.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149987>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7405-submodule-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 9a21f78..4a7b893 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -45,7 +45,7 @@ test_expect_success setup '
 	 git commit -m sub-b) &&
 	git add sub &&
 	test_tick &&
-	git commit -m b
+	git commit -m b &&
 
 	git checkout -b c a &&
 	git merge -s ours b &&
-- 
1.7.1.528.gb3958.dirty
