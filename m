From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 1/4] add missing && to submodule-merge testcase
Date: Tue,  6 Jul 2010 21:34:31 +0200
Message-ID: <5eacc71cb957723a780d20567cb66a8b83384253.1278444110.git.hvoigt@hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 06 21:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDul-0003j4-Al
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0GFTeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 15:34:37 -0400
Received: from darksea.de ([83.133.111.250]:56020 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754476Ab0GFTeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:34:36 -0400
Received: (qmail 13681 invoked from network); 6 Jul 2010 21:34:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jul 2010 21:34:34 +0200
X-Mailer: git-send-email 1.7.2.rc1.217.g7dc0db.dirty
In-Reply-To: <cover.1278444110.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1278444110.git.hvoigt@hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150401>

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
1.7.2.rc1.217.g7dc0db.dirty
