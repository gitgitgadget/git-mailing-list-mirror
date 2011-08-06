From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] whitespace: additional whitespace clean ups.
Date: Sun,  7 Aug 2011 01:48:45 +1000
Message-ID: <1312645725-3039-1-git-send-email-jon.seymour@gmail.com>
References: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 17:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpj7X-0000og-VJ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab1HFPs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 11:48:58 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:38292 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1HFPs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 11:48:58 -0400
Received: by iye16 with SMTP id 16so5704156iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Wb4kRFwywMw1xizgkc538kFzroc3YKBxIXORgIKqOfw=;
        b=jft9i4OAwIWhE4HRUvlbBSgKrkzmyxCfsucdzDJVY/NMKB18GR9mxNMebbPwpupKZq
         VTGrQYcS8EIXACT+mdecjFnOBJPiVfnBBniys3KQzn2gnSTpH0IZyVLm2sMI6yo/4Pab
         8sfWJOxLTH7yMXlU3ZJIbD0cgmThuZv7T0exQ=
Received: by 10.231.115.31 with SMTP id g31mr1566163ibq.0.1312645737425;
        Sat, 06 Aug 2011 08:48:57 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id v3sm2861470ibh.67.2011.08.06.08.48.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 08:48:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.411.gf4ef
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178883>

After replacing the whitespace test with a test and fix based on
git apply's --whitespace=fix option, a few additional cleanups were
identified.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t0100-previous.sh                         |    1 -
 t/t1008-read-tree-overlay.sh                |    1 -
 t/t1009-read-tree-new-index.sh              |    1 -
 t/t1505-rev-parse-last.sh                   |    2 --
 t/t2009-checkout-statinfo.sh                |    1 -
 t/t2203-add-intent.sh                       |    1 -
 t/t6011-rev-list-with-bad-commit.sh         |    1 -
 t/t7700-repack.sh                           |    1 -
 t/t9121-git-svn-fetch-renamed-dir.sh        |    1 -
 t/t9122-git-svn-author.sh                   |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    1 -
 11 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 315b9b3..fbdc124 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -46,4 +46,3 @@ test_expect_success 'merge @{-1} when there is not enough switches yet' '
 '
 
 test_done
-
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index 4c50ed9..bce158b 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -29,4 +29,3 @@ test_expect_success 'multi-read' '
 '
 
 test_done
-
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index 59b3aa4..6fd4827 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -22,4 +22,3 @@ test_expect_success 'empty index file' '
 '
 
 test_done
-
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index d709ecf..caef359 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -65,5 +65,3 @@ test_expect_success '@{-3} fails' '
 '
 
 test_done
-
-
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index f3c2152..8688cf6 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -49,4 +49,3 @@ test_expect_success 'path checkout' '
 '
 
 test_done
-
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 58a3299..2c849a9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -61,4 +61,3 @@ test_expect_success 'can "commit -a" with an i-t-a entry' '
 '
 
 test_done
-
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index e51eb41..fdbfb9a 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -57,4 +57,3 @@ test_expect_success 'first commit is still available' \
    '
 
 test_done
-
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d954b84..0e3f8d5 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -165,4 +165,3 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	'
 
 test_done
-
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fetch-renamed-dir.sh
index 000cad3..ff3af03 100755
--- a/t/t9121-git-svn-fetch-renamed-dir.sh
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -17,4 +17,3 @@ test_expect_success 'init and fetch repository' '
 	'
 
 test_done
-
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 30013b7..002c62f 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -75,7 +75,7 @@ test_expect_success 'interact with it via git svn' '
 	(
 		cd work.svn &&
 		svn_cmd up &&
-		
+
 		test $(svn_cmd log -r2:2 | wc -l) = 5 &&
 		test $(svn_cmd log -r4:4 | wc -l) = 7
 	)
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index fd81847..b535ca1 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -29,4 +29,3 @@ test_expect_success 'rebuild rev_map' '
 	'
 
 test_done
-
-- 
1.7.6.411.gf4ef
