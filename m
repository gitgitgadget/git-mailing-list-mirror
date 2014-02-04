From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] t7101, t7014: rename test files to indicate what that file is for
Date: Tue,  4 Feb 2014 09:20:08 +0700
Message-ID: <1391480409-25727-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 03:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAVce-0001py-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 03:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaBDCUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 21:20:20 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:37273 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaBDCUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 21:20:19 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so7613452pde.13
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 18:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rY/EEVs/ckd5iDYteYwv3hSg5He7UDkC65DoQgJXSPA=;
        b=jmIefaSRllfnUfK8IOyudN0bzPU+KK7jBywcb1IJrqgDGbne4IzTZyck9myFLAdvgh
         Z3crFVOX5ygeTiCeHa3K/P41dezfcVK4wIa+Tye0N1B/ZTuuobhAy9LTakChLcZve31t
         yiiDXRvdlTPJWESYJWfpRe6oV0Z435a8HBNeOcxYQNm7Q8l7fb7Brx4pPIIvFvvoIWVd
         Vmjngpl8aisRWB+RzZSSDTbLPOzPLNKVA2Wh3kg4AC7xuIgD6HiGV+3F413zElW0vFHT
         y0UFeb2/fh19zxJz3133RiLzxtEpaarTcCTj/ZikJMS/neF6di2A7djzYodfOrAuLhFC
         Cb2g==
X-Received: by 10.66.27.72 with SMTP id r8mr40683499pag.62.1391480418806;
        Mon, 03 Feb 2014 18:20:18 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id om6sm60700750pbc.43.2014.02.03.18.20.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 18:20:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Feb 2014 09:20:12 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241506>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Looks like a good thing to do.. Three files with the same "-reset.sh"
 suffix could be confusing.

 t/t7101-reset-empty-subdirs.sh (new +x) | 63 +++++++++++++++++++++++++=
++++++++
 t/t7101-reset.sh (gone)                 | 63 -------------------------=
--------
 t/t7104-reset-hard.sh (new +x)          | 46 ++++++++++++++++++++++++
 t/t7104-reset.sh (gone)                 | 46 ------------------------
 4 files changed, 109 insertions(+), 109 deletions(-)
 create mode 100755 t/t7101-reset-empty-subdirs.sh
 delete mode 100755 t/t7101-reset.sh
 create mode 100755 t/t7104-reset-hard.sh
 delete mode 100755 t/t7104-reset.sh

diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdi=
rs.sh
new file mode 100755
index 0000000..96e163f
--- /dev/null
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn Pearce
+#
+
+test_description=3D'git reset should cull empty subdirs'
+. ./test-lib.sh
+
+test_expect_success \
+    'creating initial files' \
+    'mkdir path0 &&
+     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+     git add path0/COPYING &&
+     git commit -m add -a'
+
+test_expect_success \
+    'creating second files' \
+    'mkdir path1 &&
+     mkdir path1/path2 &&
+     cp "$TEST_DIRECTORY"/../COPYING path1/path2/COPYING &&
+     cp "$TEST_DIRECTORY"/../COPYING path1/COPYING &&
+     cp "$TEST_DIRECTORY"/../COPYING COPYING &&
+     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING-TOO &&
+     git add path1/path2/COPYING &&
+     git add path1/COPYING &&
+     git add COPYING &&
+     git add path0/COPYING-TOO &&
+     git commit -m change -a'
+
+test_expect_success \
+    'resetting tree HEAD^' \
+    'git reset --hard HEAD^'
+
+test_expect_success \
+    'checking initial files exist after rewind' \
+    'test -d path0 &&
+     test -f path0/COPYING'
+
+test_expect_success \
+    'checking lack of path1/path2/COPYING' \
+    '! test -f path1/path2/COPYING'
+
+test_expect_success \
+    'checking lack of path1/COPYING' \
+    '! test -f path1/COPYING'
+
+test_expect_success \
+    'checking lack of COPYING' \
+    '! test -f COPYING'
+
+test_expect_success \
+    'checking checking lack of path1/COPYING-TOO' \
+    '! test -f path0/COPYING-TOO'
+
+test_expect_success \
+    'checking lack of path1/path2' \
+    '! test -d path1/path2'
+
+test_expect_success \
+    'checking lack of path1' \
+    '! test -d path1'
+
+test_done
diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
deleted file mode 100755
index 96e163f..0000000
--- a/t/t7101-reset.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2006 Shawn Pearce
-#
-
-test_description=3D'git reset should cull empty subdirs'
-. ./test-lib.sh
-
-test_expect_success \
-    'creating initial files' \
-    'mkdir path0 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
-     git add path0/COPYING &&
-     git commit -m add -a'
-
-test_expect_success \
-    'creating second files' \
-    'mkdir path1 &&
-     mkdir path1/path2 &&
-     cp "$TEST_DIRECTORY"/../COPYING path1/path2/COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING path1/COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING-TOO &&
-     git add path1/path2/COPYING &&
-     git add path1/COPYING &&
-     git add COPYING &&
-     git add path0/COPYING-TOO &&
-     git commit -m change -a'
-
-test_expect_success \
-    'resetting tree HEAD^' \
-    'git reset --hard HEAD^'
-
-test_expect_success \
-    'checking initial files exist after rewind' \
-    'test -d path0 &&
-     test -f path0/COPYING'
-
-test_expect_success \
-    'checking lack of path1/path2/COPYING' \
-    '! test -f path1/path2/COPYING'
-
-test_expect_success \
-    'checking lack of path1/COPYING' \
-    '! test -f path1/COPYING'
-
-test_expect_success \
-    'checking lack of COPYING' \
-    '! test -f COPYING'
-
-test_expect_success \
-    'checking checking lack of path1/COPYING-TOO' \
-    '! test -f path0/COPYING-TOO'
-
-test_expect_success \
-    'checking lack of path1/path2' \
-    '! test -d path1/path2'
-
-test_expect_success \
-    'checking lack of path1' \
-    '! test -d path1'
-
-test_done
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
new file mode 100755
index 0000000..f136ee7
--- /dev/null
+++ b/t/t7104-reset-hard.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description=3D'reset --hard unmerged'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	mkdir before later &&
+	>before/1 &&
+	>before/2 &&
+	>hello &&
+	>later/3 &&
+	git add before hello later &&
+	git commit -m world &&
+
+	H=3D$(git rev-parse :hello) &&
+	git rm --cached hello &&
+	echo "100644 $H 2	hello" | git update-index --index-info &&
+
+	rm -f hello &&
+	mkdir -p hello &&
+	>hello/world &&
+	test "$(git ls-files -o)" =3D hello/world
+
+'
+
+test_expect_success 'reset --hard should restore unmerged ones' '
+
+	git reset --hard &&
+	git ls-files --error-unmatch before/1 before/2 hello later/3 &&
+	test -f hello
+
+'
+
+test_expect_success 'reset --hard did not corrupt index nor cached-tre=
e' '
+
+	T=3D$(git write-tree) &&
+	rm -f .git/index &&
+	git add before hello later &&
+	U=3D$(git write-tree) &&
+	test "$T" =3D "$U"
+
+'
+
+test_done
diff --git a/t/t7104-reset.sh b/t/t7104-reset.sh
deleted file mode 100755
index f136ee7..0000000
--- a/t/t7104-reset.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-
-test_description=3D'reset --hard unmerged'
-
-. ./test-lib.sh
-
-test_expect_success setup '
-
-	mkdir before later &&
-	>before/1 &&
-	>before/2 &&
-	>hello &&
-	>later/3 &&
-	git add before hello later &&
-	git commit -m world &&
-
-	H=3D$(git rev-parse :hello) &&
-	git rm --cached hello &&
-	echo "100644 $H 2	hello" | git update-index --index-info &&
-
-	rm -f hello &&
-	mkdir -p hello &&
-	>hello/world &&
-	test "$(git ls-files -o)" =3D hello/world
-
-'
-
-test_expect_success 'reset --hard should restore unmerged ones' '
-
-	git reset --hard &&
-	git ls-files --error-unmatch before/1 before/2 hello later/3 &&
-	test -f hello
-
-'
-
-test_expect_success 'reset --hard did not corrupt index nor cached-tre=
e' '
-
-	T=3D$(git write-tree) &&
-	rm -f .git/index &&
-	git add before hello later &&
-	U=3D$(git write-tree) &&
-	test "$T" =3D "$U"
-
-'
-
-test_done
--=20
1.8.5.2.240.g8478abd
