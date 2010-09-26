From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in testsuite as per t/README
Date: Sun, 26 Sep 2010 17:14:39 -0600
Message-ID: <1285542879-16381-16-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Q1-0005ch-1b
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477Ab0IZXNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56494 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758442Ab0IZXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:37 -0400
Received: by pvg2 with SMTP id 2so1087751pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=htoe8NYaZWMn1S3QFbJHFAD9LVTmWGRDtKA552os1sY=;
        b=PZx34PVPXMLV+9PD4vtWhbrAX5Kfc5dPV5LlzBTcsGpYdUShRHH78E+L8igLif/HCx
         xjw/j8jbx4R7nNNNwvd4EaWyz+hSEaWk+Hyq/x4NwY7VLQZBwbzY/RJ/y7U83GJtM3B5
         iXiqCV58Khi/FSX0aFtidPSqIXUo95+bSim+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XJ2+vUxMmFb7rXP93yl1Uth8agwuoJlui7dEo5D7FChWGvGAekeqPCCQtyECIGPoFF
         vCwdYQphrof+BXk/ee8bVNy/4sy2wp/ALus5TAp6Dslaif4oFM/cjY9Z2m9AKKRGLaN2
         5F6/ub7cXlN+6gV9Ppt7peRrzQJD6/AeLzMxQ=
Received: by 10.115.106.13 with SMTP id i13mr7394175wam.24.1285542817121;
        Sun, 26 Sep 2010 16:13:37 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157275>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t0001-init.sh   |   28 ++++++++++++++--------------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9d4539f..3c2afb3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,7 @@ check_config () {
=20
 test_expect_success 'plain' '
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		unset GIT_DIR GIT_WORK_TREE;
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -35,7 +35,7 @@ test_expect_success 'plain' '
=20
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR
+		unset GIT_DIR;
 		mkdir plain-wt &&
 		cd plain-wt &&
 		GIT_WORK_TREE=3D$(pwd) git init
@@ -48,7 +48,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
=20
 test_expect_success 'plain bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG;
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -58,7 +58,7 @@ test_expect_success 'plain bare' '
=20
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR GIT_CONFIG
+		unset GIT_DIR GIT_CONFIG;
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=3D$(pwd) git --bare init
@@ -72,7 +72,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
=20
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-bare.git &&
 		GIT_DIR=3Dgit-dir-bare.git git init
 	) &&
@@ -82,7 +82,7 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'init --bare' '
=20
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG;
 		mkdir init-bare.git &&
 		cd init-bare.git &&
 		git init --bare
@@ -93,7 +93,7 @@ test_expect_success 'init --bare' '
 test_expect_success 'GIT_DIR non-bare' '
=20
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=3D.git git init
@@ -104,7 +104,7 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
=20
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=3D$(pwd) GIT_DIR=3Dgit-dir-wt-1.git git init
 	) &&
@@ -114,7 +114,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
=20
 	if (
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=3D$(pwd) GIT_DIR=3Dgit-dir-wt-2.git git --bare init
 	)
@@ -127,7 +127,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 test_expect_success 'reinit' '
=20
 	(
-		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
+		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG;
=20
 		mkdir again &&
 		cd again &&
@@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir set=
' '
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-=
source" &&
 		mkdir templatedir-set &&
 		cd templatedir-set &&
-		unset GIT_CONFIG_NOGLOBAL &&
-		unset GIT_TEMPLATE_DIR &&
+		unset GIT_CONFIG_NOGLOBAL;
+		unset GIT_TEMPLATE_DIR;
 		NO_SET_GIT_TEMPLATE_DIR=3Dt &&
 		export NO_SET_GIT_TEMPLATE_DIR &&
 		git init
@@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir set=
' '
 test_expect_success 'init --bare/--shared overrides system/global conf=
ig' '
 	(
 		test_config=3D"$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_CONFIG_NOGLOBAL;
 		git config -f "$test_config" core.bare false &&
 		git config -f "$test_config" core.sharedRepository 0640 &&
 		mkdir init-bare-shared-override &&
@@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overrides=
 system/global config' '
 test_expect_success 'init honors global core.sharedRepository' '
 	(
 		test_config=3D"$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_CONFIG_NOGLOBAL;
 		git config -f "$test_config" core.sharedRepository 0666 &&
 		mkdir shared-honor-global &&
 		cd shared-honor-global &&
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b6b9802..129ac15 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -252,8 +252,8 @@ test_expect_success 'committer is automatic' '
=20
 	echo >>negative &&
 	(
-		unset GIT_COMMITTER_EMAIL
-		unset GIT_COMMITTER_NAME
+		unset GIT_COMMITTER_EMAIL;
+		unset GIT_COMMITTER_NAME;
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
--=20
1.7.3.95.g14291
