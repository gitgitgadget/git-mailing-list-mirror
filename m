From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/47] t1510: setup case #24
Date: Fri, 26 Nov 2010 22:32:23 +0700
Message-ID: <1290785563-15339-28-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0TK-0006MW-D3
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0KZPoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:44:22 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58571 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab0KZPoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:44:21 -0500
Received: by pva4 with SMTP id 4so351984pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=no67G4pj6xiAgSsMP23UDVIxhf3Bua/hUFsJerd/mCI=;
        b=p87SaHwRbwenisQv1HnyoAx6sGUb0NdPER41nOODb+ehg1DSTeTX9h7wEEjzHqaFUq
         bfGIVoBP770e0z6bSeMg/EpQKugb22+bQMg5I7AjMyjLXpXdrLz5Zl6Dx8k7i7qxr0ug
         bLGollYPCuye5IIhim45sVhBlJlGcQpvExwWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Atm89bAIyJevc36wJq4LcTcdloOzw4qzPVFjgO73cLXa/Wyac15u8zKaGe3dkHFNWf
         qwkPwFAJ1TDa0aB9FII1308Fji5WTOWDQOTT8BL8IgBFpKS7D4gMXHNZRM3nZBbLKqwf
         uOJf+CAbwrpx/BaS+xc2EGl9kqbjlu007Tu2k=
Received: by 10.143.18.7 with SMTP id v7mr2506867wfi.254.1290786260946;
        Fri, 26 Nov 2010 07:44:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2681022wfd.7.2010.11.26.07.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:44:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:43:09 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162243>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 07af3cc..1c89366 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3688,4 +3688,52 @@ EOF
 	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #24
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #16.2 except git_dir is set according to .git file
+
+test_expect_success '#24: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 24 24/sub &&
+	cd 24 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../24.git &&
+	echo gitdir: ../24.git >.git &&
+	cd ..
+'
+
+test_expect_success '#24: at root' '
+	cat >24/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/24.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/24
+setup: prefix: (null)
+EOF
+	test_repo 24
+'
+
+test_expect_success '#24: in subdir' '
+	cat >24/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/24.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/24/sub
+setup: prefix: (null)
+EOF
+	test_repo 24/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
