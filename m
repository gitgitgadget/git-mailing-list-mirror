From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/5] t0001-init.sh: change confusing directory name
Date: Fri, 11 Jul 2008 02:12:03 +0200
Message-ID: <8275a6b4a676d33a1ae80f29f85c52b7bbda9a84.1215734605.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH6GI-0008EW-FD
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbYGKAMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 20:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbYGKAMH
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 20:12:07 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35020 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbYGKAMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 20:12:00 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 26D071DDC5B;
	Fri, 11 Jul 2008 02:11:59 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5C5BC1A9909; Fri, 11 Jul 2008 02:12:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <cover.1215734604.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215734604.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88065>

using git-init as directory name confused 'make remove-dashes', so just
drop the 'git-' prefix.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t0001-init.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d31887f..2a38d98 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -83,11 +83,11 @@ test_expect_success 'init --bare' '
 
 	(
 		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
-		mkdir git-init-bare.git &&
-		cd git-init-bare.git &&
+		mkdir init-bare.git &&
+		cd init-bare.git &&
 		git init --bare
 	) &&
-	check_config git-init-bare.git true unset
+	check_config init-bare.git true unset
 '
 
 test_expect_success 'GIT_DIR non-bare' '
-- 
1.5.6.2.450.g8d367.dirty
