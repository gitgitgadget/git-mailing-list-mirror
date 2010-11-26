From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/47] t1510: setup case #8
Date: Fri, 26 Nov 2010 22:32:07 +0700
Message-ID: <1290785563-15339-12-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0N3-0002fo-8Q
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab0KZPhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:37:52 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KZPhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:37:52 -0500
Received: by pzk6 with SMTP id 6so349039pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4cTkR3TCRWj+FqrYnAxSicE59YeiPGYVDmtHkbALxaY=;
        b=npdI8qmHxEjlORQjAvDE9guN1g2bmGRNelMIro4XX9W5dMAF4zK5cqQ/8HBcPEaQf5
         rer3K8xkmIULzH9Vfbfqxc17Cx7TfpATBnI6SmLLV8vycOZJ2nh8oz0pyC2e+jiopvaT
         zgvx5qcKdwYpqFRdOKGIVK4lhWTmhuVIhDw9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fqsi1U1eHaJvEPjC3S+Y+4TLneW9U9XSjAVoW/apzQv5ZjwscL/xNVMOUdV9a9gPyN
         9srG2cpNrHiASerAR3YdPka5pI8u2sFVkiuqJQ+8RQ3yE4y7ih46B6pDea64Dkg4AB9s
         ZiyI6f9yJdbLQNIK+WR6n+QSVsiLjAC3yJKfQ=
Received: by 10.142.162.19 with SMTP id k19mr2494911wfe.313.1290785871344;
        Fri, 26 Nov 2010 07:37:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2682892wfh.0.2010.11.26.07.37.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:37:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:36:42 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162227>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ccd7036..d1601e8 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1137,4 +1137,51 @@ EOF
 	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #8
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #0 except that git_dir is set by .git file
+
+test_expect_success '#8: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 8 8/sub &&
+	cd 8 &&
+	git init &&
+	mv .git ../8.git &&
+	echo gitdir: ../8.git >.git &&
+	cd ..
+'
+
+test_expect_success '#8: at root' '
+	cat >8/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/8.git
+setup: worktree: $TRASH_DIRECTORY/8
+setup: cwd: $TRASH_DIRECTORY/8
+setup: prefix: (null)
+EOF
+	test_repo 8
+'
+
+test_expect_success '#8: in subdir' '
+	cat >8/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/8.git
+setup: worktree: $TRASH_DIRECTORY/8
+setup: cwd: $TRASH_DIRECTORY/8
+setup: prefix: sub/
+EOF
+	test_repo 8/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
