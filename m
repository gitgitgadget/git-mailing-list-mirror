From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/42] t1510: setup case #24
Date: Fri, 29 Oct 2010 13:48:39 +0700
Message-ID: <1288334934-17216-28-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipV-000772-6H
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab0J2Gwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290Ab0J2Gwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:44 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ln+lwQF8f/WK0tWK6qe3ztlc8ugB7VNtA9Xq/1mS3Fg=;
        b=xnMLbIbnZOmuKSaBQVYQ1t18/WU9kphAHkJT6KdIrjizKFtxQHT45/KtarUUDo0ENO
         M1CWs8yucTpKI+nuCopt/IkIL8FcGEqxBLBt23As9QRwa2UfErbsQImXTWYrpT52Wbd/
         mCqReDzQeGkLE6bewIJuboR8NFh14W8Hbe6PI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZoQcQ8nIKMVLO7DJnhpfmwxlHTRWPZPyL8Hv2IcndwILdPjT1hZgdqknTtZmC43myk
         vZwWrjvYC6JxZ0dbk0JubMk4FYv98dOag9ivV+qGfLNnav5vyXjrWnd8mVruBSZmuak8
         +QiHXKZ5QRmrM7cHowqQ3Pnj3a2EHWRsXEulk=
Received: by 10.143.3.8 with SMTP id f8mr866647wfi.193.1288335163950;
        Thu, 28 Oct 2010 23:52:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id y42sm1022680wfd.22.2010.10.28.23.52.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:43 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160294>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index f699546..1965838 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3675,4 +3675,52 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23/sub/sub
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
1.7.0.2.445.gcbdb3
