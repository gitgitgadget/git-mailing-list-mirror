From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 6/6] Allow the regression tests to be run from a directory with spaces in
Date: Wed, 28 Sep 2011 15:15:24 +0100
Message-ID: <1317219324-10319-6-git-send-email-alan.christopher.jenkins@googlemail.com>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uwi-0007QS-Jy
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab1I1OQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:16:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61456 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab1I1OQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:16:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so8982121wwf.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7MiswGy//SUtZSrVDSlbjdnxACWHn6IEkTh/6EIs4JQ=;
        b=cGA5/ixEahp7+Q4DssZkK+t/lUUB0WB4bOgUbcGpnkoAPGMk5tmqqg/US6/oG002ZL
         WDuvwfB+SCb//qPRF4HfPNrIdiFKLtLtd2r23aFkogQyJ1SLySYPh0hK3BEuGp92QPXv
         B72NnPV0akMbCTeMpG6p/nfUVo4TXSY/3pFJo=
Received: by 10.227.58.148 with SMTP id g20mr1587778wbh.108.1317219416800;
        Wed, 28 Sep 2011 07:16:56 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:16:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182322>

sed -i regression/*.sh 's|source $REG_DIR/scaffold|source "$REG_DIR/scaffold"|'

Same as the previous patch: it turned out I don't need this,
but you might think it's a good idea anyway.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 regression/t-010.sh |    2 +-
 regression/t-011.sh |    2 +-
 regression/t-020.sh |    2 +-
 regression/t-021.sh |    2 +-
 regression/t-022.sh |    2 +-
 regression/t-023.sh |    2 +-
 regression/t-024.sh |    2 +-
 regression/t-025.sh |    2 +-
 regression/t-026.sh |    2 +-
 regression/t-027.sh |    2 +-
 regression/t-028.sh |    2 +-
 regression/t-029.sh |    2 +-
 regression/t-030.sh |    2 +-
 regression/t-031.sh |    2 +-
 regression/t-032.sh |    2 +-
 regression/t-050.sh |    2 +-
 regression/t-051.sh |    2 +-
 regression/t-052.sh |    2 +-
 regression/t-060.sh |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/regression/t-010.sh b/regression/t-010.sh
index 1fc88fa..9bbf32a 100755
--- a/regression/t-010.sh
+++ b/regression/t-010.sh
@@ -3,7 +3,7 @@
 # Test the init code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 function opts
 {
diff --git a/regression/t-011.sh b/regression/t-011.sh
index fde7b90..55a72d7 100755
--- a/regression/t-011.sh
+++ b/regression/t-011.sh
@@ -4,7 +4,7 @@
 # not guilt init'ed
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_git_repo
 
diff --git a/regression/t-020.sh b/regression/t-020.sh
index 6598b02..cdd08ba 100755
--- a/regression/t-020.sh
+++ b/regression/t-020.sh
@@ -3,7 +3,7 @@
 # Test the push code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-021.sh b/regression/t-021.sh
index 035973c..6337d7b 100755
--- a/regression/t-021.sh
+++ b/regression/t-021.sh
@@ -3,7 +3,7 @@
 # Test the pop code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-022.sh b/regression/t-022.sh
index e43dc0a..0fe345b 100755
--- a/regression/t-022.sh
+++ b/regression/t-022.sh
@@ -3,7 +3,7 @@
 # Test the applied code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-023.sh b/regression/t-023.sh
index 1e976fd..c0530d6 100755
--- a/regression/t-023.sh
+++ b/regression/t-023.sh
@@ -3,7 +3,7 @@
 # Test the top code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-024.sh b/regression/t-024.sh
index 9b11286..38f53aa 100755
--- a/regression/t-024.sh
+++ b/regression/t-024.sh
@@ -3,7 +3,7 @@
 # Test the unapplied code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-025.sh b/regression/t-025.sh
index 6aa9bd3..3824608 100755
--- a/regression/t-025.sh
+++ b/regression/t-025.sh
@@ -3,7 +3,7 @@
 # Test the new code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-026.sh b/regression/t-026.sh
index 5f29352..0ccdf85 100755
--- a/regression/t-026.sh
+++ b/regression/t-026.sh
@@ -3,7 +3,7 @@
 # Test the delete code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-027.sh b/regression/t-027.sh
index ee70229..2f5bb9f 100755
--- a/regression/t-027.sh
+++ b/regression/t-027.sh
@@ -3,7 +3,7 @@
 # Test the refresh code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-028.sh b/regression/t-028.sh
index 83fa879..8480100 100755
--- a/regression/t-028.sh
+++ b/regression/t-028.sh
@@ -3,7 +3,7 @@
 # Test the header code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-029.sh b/regression/t-029.sh
index 83e1d2b..e4036bf 100755
--- a/regression/t-029.sh
+++ b/regression/t-029.sh
@@ -5,7 +5,7 @@
 
 # FIXME: test status file format upgrade code
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-030.sh b/regression/t-030.sh
index 0352948..06bd58f 100755
--- a/regression/t-030.sh
+++ b/regression/t-030.sh
@@ -3,7 +3,7 @@
 # Test the commit code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-031.sh b/regression/t-031.sh
index 9b5db6f..20c2a6b 100755
--- a/regression/t-031.sh
+++ b/regression/t-031.sh
@@ -3,7 +3,7 @@
 # Test the fork code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-032.sh b/regression/t-032.sh
index 3b32da5..b1d5f19 100755
--- a/regression/t-032.sh
+++ b/regression/t-032.sh
@@ -3,7 +3,7 @@
 # Test the import code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-050.sh b/regression/t-050.sh
index 82ac412..88be546 100755
--- a/regression/t-050.sh
+++ b/regression/t-050.sh
@@ -3,7 +3,7 @@
 # Test the series code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-051.sh b/regression/t-051.sh
index a05fcca..293459c 100755
--- a/regression/t-051.sh
+++ b/regression/t-051.sh
@@ -3,7 +3,7 @@
 # Test the commands that use get_*_series, while applying guards
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-052.sh b/regression/t-052.sh
index e9c1a59..f8c60ab 100755
--- a/regression/t-052.sh
+++ b/regression/t-052.sh
@@ -3,7 +3,7 @@
 # Test the commands that use get_*_series, while applying guards
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
diff --git a/regression/t-060.sh b/regression/t-060.sh
index ec33d80..ebe93bd 100755
--- a/regression/t-060.sh
+++ b/regression/t-060.sh
@@ -3,7 +3,7 @@
 # Test the guilt files code
 #
 
-source $REG_DIR/scaffold
+source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
-- 
1.7.4.1
