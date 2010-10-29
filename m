From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/42] t1510: setup case #8
Date: Fri, 29 Oct 2010 13:48:23 +0700
Message-ID: <1288334934-17216-12-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBink-0006Je-7L
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab0J2Gut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0J2Gur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:47 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rINejaAvyERwIq0I08+bgSTFlI7vqIvBVjo+Sya4rqk=;
        b=RUmIQz1qlU5oFCAiLomsQMRdv0D49F5AbHy1wV/AdqZtCnFNjjnKUiwSM5DkzW1dRL
         VY7+UQWdxsqztz1EyJZmfz1Ej9o56qb6RBKgTtFD8adyUeSkZqIzqmeK2oHYLbqFBui3
         DESP1gBWA+uZRQ/8qMp+55z7S3EgoS8SIA7gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JZlE987MIKf2Ftyn/F+dj7wNga/hhTQpR9Hz093ox52AxYU0m+m7XA5ZElucVy2stz
         a/rw6k65aFB/6qX2/OcxvejOCVGIxz2icCrDlTR5MryQPo2+CJTXJL/NmPsqH20nRM6w
         wXuJ0QKaaH/GC/s3RVa+lROwWZU/U5+iLn8WI=
Received: by 10.142.68.8 with SMTP id q8mr982468wfa.170.1288335047701;
        Thu, 28 Oct 2010 23:50:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w14sm1030423wfd.6.2010.10.28.23.50.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:47 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160280>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index faefd10..769009d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1133,4 +1133,51 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7/sub/sub
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
1.7.0.2.445.gcbdb3
