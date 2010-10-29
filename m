From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/42] t1510: setup case #0
Date: Fri, 29 Oct 2010 13:48:15 +0700
Message-ID: <1288334934-17216-4-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBimo-0005uP-BU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab0J2Gtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:49:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab0J2Gtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:49:49 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Cg/PN0KJzAx+/3+ulZF/TJhduas/4psVadzZfM4SyPg=;
        b=QKRAlk3joIlgIlYhVJTSYx7XKJgjDH3ehT1EaWfwDaLtZ3g2ML585RSsxdVMdQ+S13
         IkUY2dMwpJUQe62zjQZjIKgmGI51A0G5JyypMltGnPxA+tlzTujpCbuMcFzpx3xh6F25
         kq6Q8OIGcrd0bCo/RbpRRuMZz4/DPAHXx2+EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AgQ6m2crW9hb/FS1fhZE/6qzC9Qtff09CE1m++88pckeM4wZWolXM+1PCsqEyH99uy
         PXaZyFa9telEYIEasgd8v++K76EH/OD1J824I1KUi7y8zN/GpcYMAd0QIS+VQzklfb/0
         3HJ5uyqETSzOSaZzfqKboSXtzJXsIt5UTcWwY=
Received: by 10.142.221.1 with SMTP id t1mr924273wfg.129.1288334988776;
        Thu, 28 Oct 2010 23:49:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm1019320wfg.20.2010.10.28.23.49.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:49:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:49:48 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160271>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 623807d..288e8a8 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -56,4 +56,51 @@ test_repo() {
 # Bit 4 =3D bare repo
 # Case# =3D encoding of the above 5 bits
=20
+#
+# Case #0
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is .git's parent directory
+#  - cwd is at worktree root dir
+#  - prefix is calculated
+#  - git_dir is set to ".git"
+#  - cwd can't be outside worktree
+
+test_expect_success '#0: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 0 0/sub &&
+	cd 0 && git init && cd ..
+'
+
+test_expect_success '#0: at root' '
+	cat >0/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: (null)
+EOF
+	test_repo 0
+'
+
+test_expect_success '#0: in subdir' '
+	cat >0/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: sub/
+EOF
+	test_repo 0/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
