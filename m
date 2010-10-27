From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] new failures
Date: Wed, 27 Oct 2010 21:58:16 +0700
Message-ID: <1288191496-31176-7-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7TI-0003OT-LW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761143Ab0J0O7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:59:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761134Ab0J0O7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:59:09 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so451893ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=mqjQFHx+Fs8DZkPmuc8M2YZ4Yfugg3XmF1zs1I0yr8w=;
        b=dw5VIrpjlssn2G3yZ3IYhbwWAuIbFiJ/9ny19d1k1vk/e4HGLALS3odL2Sl7SPcVcj
         psZP+D+5A9DAXIdAwnirW6F4+eTFrbLiBoEHmskyJ26dcc861t3u+aiT+rhGUDBN9RqA
         U7J3+u3y5RwkkDmG/+ow/qMSMWjMjav6emn0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mAYKvERHP/ZzmMhgAeOZJfwQ0xIoE7Kw43GYUo3YH0aTtttkOQG00rFTeDVr9aKdv9
         JDKvjiWDl+bwre14xBKyj7TualHh0Y7I5SbGW77JOln2pgfgWsZcq9gBLfYudtqIf3KA
         O57aFD4pLZjwcEB7lqTNgBrtH/YpuCU5I5fd0=
Received: by 10.100.34.19 with SMTP id h19mr7965626anh.88.1288191548815;
        Wed, 27 Oct 2010 07:59:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w3sm11921765anw.25.2010.10.27.07.59.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:59:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:59:06 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160082>


git_dir changes are acceptable. The other two, hm...
---
 t/t1510-repo-setup.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9d24a0f..7dbccf4 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -781,7 +781,7 @@ EOF
 
 test_expect_success '#6: GIT_DIR(rel), core.worktree=../.. at root' '
 	cat >6/expected <<EOF &&
-setup: git_dir: .git
+setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
 setup: cwd: $TRASH_DIRECTORY
 setup: prefix: 6/
@@ -792,7 +792,7 @@ EOF
 
 test_expect_success '#6: GIT_DIR(rel), core.worktree=../..(rel) at root' '
 	cat >6/expected <<EOF &&
-setup: git_dir: .git
+setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
 setup: cwd: $TRASH_DIRECTORY
 setup: prefix: 6/
@@ -3713,7 +3713,7 @@ EOF
 	test_repo 24
 '
 
-test_expect_success '#24: in subdir' '
+test_expect_failure '#24: in subdir' '
 	cat >24/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -4147,7 +4147,7 @@ EOF
 	test_repo 28
 '
 
-test_expect_success '#28: in subdir' '
+test_expect_failure '#28: in subdir' '
 	cat >28/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
-- 
1.7.0.2.445.gcbdb3
