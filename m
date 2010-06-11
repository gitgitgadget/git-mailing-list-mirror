From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [WIP PATCH 2/3] add missing && to submodule-merge testcase
Date: Fri, 11 Jun 2010 14:23:32 +0200
Message-ID: <640d97ddba4b842f9f268cabf92e0220e641f23f.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 14:30:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON3NR-0005BH-N8
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212Ab0FKMaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 08:30:19 -0400
Received: from darksea.de ([83.133.111.250]:56927 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760184Ab0FKMaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 08:30:16 -0400
Received: (qmail 1399 invoked from network); 11 Jun 2010 14:23:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Jun 2010 14:23:34 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148940>

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
1.7.1
