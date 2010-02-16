From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 26/26] Turn on GIT_HARDENED_SETUP for the whole test suite
Date: Tue, 16 Feb 2010 23:05:17 +0700
Message-ID: <1266336317-607-27-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:18:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ82-0007mx-KV
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab0BPQSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:18:24 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:60990 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab0BPQSX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:18:23 -0500
Received: by gxk27 with SMTP id 27so93474gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=opsBjJfSTqm7rFTjGX/DP6yBtR3OJLKYq6u10s28EuA=;
        b=OaygWDQdnduZ5lPIEs/csd+PkAScZp5uZppuZiIR9dLIWob1aiEuZoWRyyiENqupvu
         Wmj+w0qs8e7D0curNzujS6PXzSEpDjs6PHBOY5PDyFWnGyQaNg6U8ejlsEd+CIuy0DdS
         20lm15HRRVXmvPRFp8GTOMuqSuQZciGx1axbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=J2cJYEbk1psAWwyupUefSr1CjCjx8IfI3lsL9zI2UD5ikrpIhmsCsjwF7sjEPmC2d4
         hkaODcM2PxlVcJo/92Tq2eCEwlcK+PQLougK/USglgBds4C4q42VkuqyMe9KllGlNsYv
         grX3mWP9qtanC56j8tY381AHltvp+iOADiBiw=
Received: by 10.101.105.1 with SMTP id h1mr2817080anm.131.1266336645881;
        Tue, 16 Feb 2010 08:10:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 22sm2875287ywh.0.2010.02.16.08.10.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:08:02 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140129>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0000-basic.sh              |    2 --
 t/t0001-init.sh               |    2 --
 t/t0003-attributes.sh         |    2 --
 t/t0024-crlf-archive.sh       |    2 --
 t/t4201-shortlog.sh           |    2 --
 t/t5000-tar-tree.sh           |    2 --
 t/t5001-archive-attr.sh       |    2 --
 t/t5600-clone-fail-cleanup.sh |    2 --
 t/t5601-clone.sh              |    2 --
 t/t5602-clone-remote-exec.sh  |    2 --
 t/t5700-clone-reference.sh    |    2 --
 t/t5701-clone-local.sh        |    2 --
 t/t5702-clone-options.sh      |    2 --
 t/t5704-bundle.sh             |    2 --
 t/t5705-clone-2gb.sh          |    2 --
 t/t5706-clone-branch.sh       |    2 --
 t/t7002-grep.sh               |    2 --
 t/test-lib.sh                 |    3 +++
 18 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 0a4be17..f4ca4fc 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -28,8 +28,6 @@ then
 	exit 1
 fi
=20
-export GIT_HARDENED_SETUP=3D1
-
 . ./test-lib.sh
=20
 ################################################################
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0dd6ffa..5386504 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -4,8 +4,6 @@ test_description=3D'git init'
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 check_config () {
 	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
 	then
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 2ebb345..1c77192 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -4,8 +4,6 @@ test_description=3Dgitattributes
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 attr_check () {
=20
 	path=3D"$1"
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index f96db4d..ff345ea 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -4,8 +4,6 @@ test_description=3D'respect crlf in git archive'
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 UNZIP=3D${UNZIP:-unzip}
=20
 test_expect_success setup '
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7ae327a..a01e55b 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -8,8 +8,6 @@ test_description=3D'git shortlog
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 echo 1 > a1
 git add a1
 tree=3D$(git write-tree)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4c69dd2..27bfba5 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -29,8 +29,6 @@ UNZIP=3D${UNZIP:-unzip}
=20
 SUBSTFORMAT=3D%H%n
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 80e1e72..426b319 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -4,8 +4,6 @@ test_description=3D'git archive attribute tests'
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 SUBSTFORMAT=3D%H%n
=20
 test_expect_exists() {
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup=
=2Esh
index 424e6ad..ee06d28 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -11,8 +11,6 @@ remove the directory before attempting a clone again.=
'
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success \
     'clone of non-existent source should fail' \
     'test_must_fail git clone foo bar'
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a598f75..2147567 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -4,8 +4,6 @@ test_description=3Dclone
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success setup '
=20
 	rm -fr .git &&
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.s=
h
index a94c528..deffdae 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -4,8 +4,6 @@ test_description=3Dclone
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success setup '
 	echo "#!/bin/sh" > not_ssh
 	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 2464f57..1c10916 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -6,8 +6,6 @@
 test_description=3D'test clone --reference'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 base_dir=3D`pwd`
=20
 U=3D$base_dir/UPLOAD_LOG
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3c3d6ed..8b4c356 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -3,8 +3,6 @@
 test_description=3D'test local clone'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 D=3D`pwd`
=20
 test_expect_success 'preparing origin repository' '
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 63f59ba..02cb024 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -3,8 +3,6 @@
 test_description=3D'basic clone options'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success 'setup' '
=20
 	mkdir parent &&
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 507c838..a8f4419 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -3,8 +3,6 @@
 test_description=3D'some bundle related tests'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test_expect_success 'setup' '
=20
 	: > file &&
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index f63a557..adfaae8 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -3,8 +3,6 @@
 test_description=3D'Test cloning a repository larger than 2 gigabyte'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 test -z "$GIT_TEST_CLONE_2GB" &&
 say "Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_=
2GB=3Dt" &&
 test_done &&
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
index fbee0d0..f3f9a76 100755
--- a/t/t5706-clone-branch.sh
+++ b/t/t5706-clone-branch.sh
@@ -3,8 +3,6 @@
 test_description=3D'clone --branch option'
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 check_HEAD() {
 	echo refs/heads/"$1" >expect &&
 	git symbolic-ref HEAD >actual &&
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 67afb42..ebae152 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,8 +8,6 @@ test_description=3D'git grep various.
=20
 . ./test-lib.sh
=20
-export GIT_HARDENED_SETUP=3D1
-
 cat >hello.c <<EOF
 #include <stdio.h>
 int main(int argc, const char **argv)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..e3e3084 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -61,6 +61,9 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 GIT_TEST_CMP=3D${GIT_TEST_CMP:-diff -u}
=20
+GIT_HARDENED_SETUP=3D1
+export GIT_HARDENED_SETUP
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
--=20
1.7.0.195.g637a2
