From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/47] t1510: setup case #28
Date: Fri, 26 Nov 2010 22:32:27 +0700
Message-ID: <1290785563-15339-32-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:45:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Un-0007Bf-2t
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0KZPpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:45:52 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:50652 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0KZPpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:45:51 -0500
Received: by mail-pz0-f66.google.com with SMTP id 26so457676pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MCS0HaIZEKl1craaH7GWpmtP8h3JwyJjCvFrmSJd7w0=;
        b=wPz+m4WuUP1zC9BxS5UZjbv7A2hZEevhoBKu9znxXrSiicR7CT9359blvHkRH2PEUh
         m0gOa14ofM5NxSsiQFZC3H202yjyrWXm8VQ8w+A9Z3tRJ6G1rO0HDKyhH1VXbrJpOR8N
         5tKni7ys6AV+pUnGBwsB6z6U36IsxWSJYcbWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vKiw3qxNhUfoYL/26JJzZ980RglIM6Ov7DI/LSEGI0AxoF2dtNz/Lt+R5nFqQ8vO1k
         dyhQkwBU8QC3vXWSBeH2DroUFPekQj+/TzOC2YdlyWrIC7opNIwHb2o4UpCandkHB1k+
         1YPhQg8NSoEYqSIlZewmFu2ftneiICTQnGVDI=
Received: by 10.143.41.2 with SMTP id t2mr2525821wfj.156.1290786351406;
        Fri, 26 Nov 2010 07:45:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id q13sm2686029wfc.17.2010.11.26.07.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:45:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:44:38 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162247>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 5c831d1..d845758 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4122,4 +4122,53 @@ EOF
 	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #28
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is ignored -> #24
+
+test_expect_success '#28: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 28 28/sub &&
+	cd 28 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../28.git &&
+	echo gitdir: ../28.git >.git &&
+	cd ..
+'
+
+test_expect_success '#28: at root' '
+	cat >28/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/28.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/28
+setup: prefix: (null)
+EOF
+	test_repo 28
+'
+
+test_expect_success '#28: in subdir' '
+	cat >28/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/28.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/28/sub
+setup: prefix: (null)
+EOF
+	test_repo 28/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
