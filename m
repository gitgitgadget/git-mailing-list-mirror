From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] completion: learn about --man-path
Date: Sat, 22 Jun 2013 12:25:18 +0100
Message-ID: <bc83f64cf17851022e0344b3eb693beda1bdd8b6.1371900318.git.john@keeping.me.uk>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 22 13:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqLy4-0007pw-VM
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 13:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab3FVL0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 07:26:47 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:35266 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab3FVL0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 07:26:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5969C23681;
	Sat, 22 Jun 2013 12:26:37 +0100 (BST)
X-Quarantine-ID: <B0tf41hfgxxK>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0tf41hfgxxK; Sat, 22 Jun 2013 12:26:36 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 3DA8423738;
	Sat, 22 Jun 2013 12:26:30 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
In-Reply-To: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
In-Reply-To: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228696>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 2 ++
 t/t9902-completion.sh                  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8fbf941..c3290af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2513,11 +2513,13 @@ __git_main ()
 			--exec-path
 			--exec-path=
 			--html-path
+			--man-path
 			--info-path
 			--work-tree=
 			--namespace=
 			--no-replace-objects
 			--help
+			-c
 			"
 			;;
 		*)     __git_compute_porcelain_commands
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 81a1657..14d605a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -231,6 +231,7 @@ test_expect_success 'double dash "git" itself' '
 	--exec-path Z
 	--exec-path=
 	--html-path Z
+	--man-path Z
 	--info-path Z
 	--work-tree=
 	--namespace=
-- 
1.8.3.1.676.gaae6535
