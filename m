From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 3/3] Replace some git commands with stg aliases in test
	scripts
Date: Fri, 08 Jan 2010 12:36:10 +0000
Message-ID: <20100108123610.24161.56597.stgit@pc1117.cambridge.arm.com>
References: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTE4q-000874-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 13:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0AHMgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178Ab0AHMgR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 07:36:17 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40779 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615Ab0AHMgO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 07:36:14 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o08CaAeI002313;
	Fri, 8 Jan 2010 12:36:10 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 8 Jan 2010 12:36:10 +0000
In-Reply-To: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.15-36-g53e3
X-OriginalArrivalTime: 08 Jan 2010 12:36:10.0740 (UTC) FILETIME=[2863C340:01CA905F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136430>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 t/t0001-subdir-branches.sh     |    2 +-
 t/t0002-status.sh              |   12 ++++++------
 t/t1000-branch-create.sh       |    4 ++--
 t/t1002-branch-clone.sh        |    2 +-
 t/t1200-push-modified.sh       |    2 +-
 t/t1201-pull-trailing.sh       |    2 +-
 t/t1202-push-undo.sh           |    6 +++---
 t/t1203-push-conflict.sh       |    6 +++---
 t/t1204-pop-keep.sh            |    2 +-
 t/t1205-push-subdir.sh         |    6 +++---
 t/t1206-push-hidden.sh         |    2 +-
 t/t1207-push-tree.sh           |    2 +-
 t/t1300-uncommit.sh            |    4 ++--
 t/t1301-repair.sh              |    8 ++++----
 t/t1302-repair-interop.sh      |    2 +-
 t/t1500-float.sh               |   14 +++++++-------
 t/t1501-sink.sh                |   12 ++++++------
 t/t1600-delete-one.sh          |   12 ++++++------
 t/t1601-delete-many.sh         |    2 +-
 t/t1602-delete-spill.sh        |    2 +-
 t/t1700-goto-top.sh            |    2 +-
 t/t1701-goto-hidden.sh         |    2 +-
 t/t1800-import.sh              |    4 ++--
 t/t1900-mail.sh                |    2 +-
 t/t2000-sync.sh                |   12 ++++++------
 t/t2100-pull-policy-fetch.sh   |    4 ++--
 t/t2101-pull-policy-pull.sh    |    6 +++---
 t/t2102-pull-policy-rebase.sh  |    4 ++--
 t/t2200-rebase.sh              |    4 ++--
 t/t2300-refresh-subdir.sh      |    4 ++--
 t/t2400-diff.sh                |    2 +-
 t/t2500-clean.sh               |    2 +-
 t/t2600-squash.sh              |    2 +-
 t/t2700-refresh.sh             |    6 +++---
 t/t2701-refresh-p.sh           |    4 ++--
 t/t2702-refresh-rm.sh          |   10 +++++-----
 t/t2800-goto-subdir.sh         |    2 +-
 t/t3000-dirty-merge.sh         |    2 +-
 t/t3100-reset.sh               |    2 +-
 t/t3101-reset-hard.sh          |    2 +-
 t/t3102-undo.sh                |    2 +-
 t/t3103-undo-hard.sh           |    2 +-
 t/t3104-redo.sh                |    2 +-
 t/t3105-undo-external-mod.sh   |    6 +++---
 t/t3200-non-ascii-filenames.sh |    4 ++--
 t/t3300-edit.sh                |    2 +-
 t/t3400-pick.sh                |    8 ++++----
 t/t4100-publish.sh             |   12 ++++++------
 48 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index 3f7962a..5ea787e 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -14,7 +14,7 @@ containing slashes (that is, branches living in a sub=
directory of
 test_expect_success 'Create a patch' \
   'stg init &&
    echo "foo" > foo.txt &&
-   git add foo.txt &&
+   stg add foo.txt &&
    stg new foo -m "Add foo.txt" &&
    stg refresh'
=20
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 2512c53..c978845 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -54,7 +54,7 @@ cat > expected.txt <<EOF
 A foo/bar
 EOF
 test_expect_success 'Status with an added file' '
-    git add foo &&
+    stg add foo &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
@@ -95,7 +95,7 @@ test_expect_success 'Status after refresh' '
=20
 test_expect_success 'Add another file' '
     echo lajbans > fie &&
-    git add fie &&
+    stg add fie &&
     stg refresh
 '
=20
@@ -145,7 +145,7 @@ A fie
 M foo/bar
 EOF
 test_expect_success 'Status after resolving the push' '
-    git add --update &&
+    stg add --update &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
@@ -166,7 +166,7 @@ EOF
 test_expect_success 'Status of disappeared newborn' '
     stg refresh &&
     touch foo/bar &&
-    git add foo/bar &&
+    stg add foo/bar &&
     rm foo/bar &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
@@ -177,8 +177,8 @@ A fay
 D fie
 EOF
 test_expect_success 'Status after renaming a file' '
-    git rm foo/bar &&
-    git mv fie fay &&
+    stg rm foo/bar &&
+    stg mv fie fay &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index 3fff3ee..2626c73 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -78,9 +78,9 @@ test_expect_success \
     'Setup two commits including removal of generated files' '
     git init &&
     touch file1 file2 &&
-    git add file1 file2 &&
+    stg add file1 file2 &&
     git commit -m 1 &&
-    git rm file1 file2 &&
+    stg rm file1 file2 &&
     git commit -m 2 &&
     touch file2
 '
diff --git a/t/t1002-branch-clone.sh b/t/t1002-branch-clone.sh
index 1303b41..4930c20 100755
--- a/t/t1002-branch-clone.sh
+++ b/t/t1002-branch-clone.sh
@@ -14,7 +14,7 @@ test_expect_success \
     'Create a GIT commit' \
     '
     echo bar > bar.txt &&
-    git add bar.txt &&
+    stg add bar.txt &&
     git commit -a -m bar
     '
=20
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 2077492..e04dac5 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -23,7 +23,7 @@ test_expect_success \
     stg clone foo bar &&
     (
         cd bar && stg new p1 -m p1 &&
-        printf "a\nc\n" > file && git add file && stg refresh &&
+        printf "a\nc\n" > file && stg add file && stg refresh &&
         stg new p2 -m p2 &&
         printf "a\nb\nc\n" > file && stg refresh &&
         [ "$(echo $(stg series --applied --noprefix))" =3D "p1 p2" ] &=
&
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index d66ad26..a993aeb 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -18,7 +18,7 @@ test_create_repo foo
 test_expect_success \
     'Setup and clone tree, and setup changes' \
     "(cd foo &&
-      printf 'a\nb\n' > file && git add file && git commit -m .
+      printf 'a\nb\n' > file && stg add file && git commit -m .
      ) &&
      stg clone foo bar &&
      (cd bar && stg new p1 -m p1
diff --git a/t/t1202-push-undo.sh b/t/t1202-push-undo.sh
index 14a3d6d..5afcf68 100755
--- a/t/t1202-push-undo.sh
+++ b/t/t1202-push-undo.sh
@@ -21,7 +21,7 @@ test_expect_success \
 	'
 	stg new foo -m foo &&
 	echo foo > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
@@ -30,7 +30,7 @@ test_expect_success \
 	'
 	stg new bar -m bar &&
 	echo bar > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
@@ -62,7 +62,7 @@ test_expect_success \
 	'Undo with disappeared newborn' \
 	'
 	touch newfile &&
-	git add newfile &&
+	stg add newfile &&
 	rm newfile &&
 	stg undo --hard
 	'
diff --git a/t/t1203-push-conflict.sh b/t/t1203-push-conflict.sh
index 8027e6c..b759298 100755
--- a/t/t1203-push-conflict.sh
+++ b/t/t1203-push-conflict.sh
@@ -21,7 +21,7 @@ test_expect_success \
 	stg new foo -m foo &&
 	echo foo > test &&
 	echo fie > test2 &&
-	git add test test2 &&
+	stg add test test2 &&
 	stg refresh &&
         stg pop
 	'
@@ -31,7 +31,7 @@ test_expect_success \
 	'
 	stg new bar -m bar &&
 	echo bar > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
@@ -63,7 +63,7 @@ test_expect_success \
 	'Resolve the conflict' \
 	'
 	echo resolved > test &&
-	git add test &&
+	stg resolved test &&
 	stg refresh
 	'
=20
diff --git a/t/t1204-pop-keep.sh b/t/t1204-pop-keep.sh
index db473f2..ee5d058 100755
--- a/t/t1204-pop-keep.sh
+++ b/t/t1204-pop-keep.sh
@@ -8,7 +8,7 @@ test_expect_success 'Create a few patches' '
     for i in 0 1 2; do
         stg new p$i -m p$i &&
         echo "patch$i" >> patch$i.txt &&
-        git add patch$i.txt &&
+        stg add patch$i.txt &&
         stg refresh
     done &&
     [ "$(echo $(stg series --applied --noprefix))" =3D "p0 p1 p2" ] &&
diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
index 2d5918b..4af63ce 100755
--- a/t/t1205-push-subdir.sh
+++ b/t/t1205-push-subdir.sh
@@ -9,7 +9,7 @@ test_expect_success 'Create some patches' '
         stg new p$i -m p$i &&
         echo x$i >> x.txt &&
         echo y$i >> foo/y.txt &&
-        git add x.txt foo/y.txt &&
+        stg add x.txt foo/y.txt &&
         stg refresh
     done &&
     [ "$(echo $(stg series --applied --noprefix))" =3D "p0 p1 p2" ] &&
@@ -33,7 +33,7 @@ test_expect_success 'Modifying push from a subdir' '
     [ "$(echo $(cat foo/y.txt))" =3D "y0 y1" ] &&
     stg new extra -m extra &&
     echo extra >> extra.txt &&
-    git add extra.txt &&
+    stg add extra.txt &&
     stg refresh &&
     cd foo &&
     stg push &&
@@ -57,7 +57,7 @@ test_expect_success 'Conflicting add/unknown file in =
subdir' '
     stg new foo -m foo &&
     mkdir d &&
     echo foo > d/test &&
-    git add d/test &&
+    stg add d/test &&
     stg refresh &&
     stg pop &&
     mkdir -p d &&
diff --git a/t/t1206-push-hidden.sh b/t/t1206-push-hidden.sh
index 20aa306..ee8e254 100755
--- a/t/t1206-push-hidden.sh
+++ b/t/t1206-push-hidden.sh
@@ -7,7 +7,7 @@ test_description=3D'Test "stg push" with hidden patches=
'
 test_expect_success 'Initialize StGit stack' '
     stg init &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg new -m hidden-patch &&
     stg refresh &&
     stg pop &&
diff --git a/t/t1207-push-tree.sh b/t/t1207-push-tree.sh
index 9d0b1cc..e97cb1b 100755
--- a/t/t1207-push-tree.sh
+++ b/t/t1207-push-tree.sh
@@ -12,7 +12,7 @@ test_expect_success \
     stg init &&
     stg new A -m A &&
     echo hello world > a &&
-    git add a &&
+    stg add a &&
     stg refresh
     stg new B -m B &&
     echo HELLO WORLD > a &&
diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index 43e0d04..5e9b8fb 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -19,7 +19,7 @@ test_expect_success \
 	'
 	stg new foo -m "Foo Patch" &&
 	echo foo > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
@@ -28,7 +28,7 @@ test_expect_success \
 	'
 	stg new bar -m "Bar Patch" &&
 	echo bar > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
diff --git a/t/t1301-repair.sh b/t/t1301-repair.sh
index 8d5d4e5..939699c 100755
--- a/t/t1301-repair.sh
+++ b/t/t1301-repair.sh
@@ -20,7 +20,7 @@ test_expect_success \
     '
     stg new foo -m foo &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh
     '
=20
@@ -32,7 +32,7 @@ test_expect_success \
     'Create a GIT commit' \
     '
     echo bar > bar.txt &&
-    git add bar.txt &&
+    stg add bar.txt &&
     git commit -a -m bar
     '
=20
@@ -46,7 +46,7 @@ test_expect_success \
     'Create three more GIT commits' \
     '
     echo one > numbers.txt &&
-    git add numbers.txt &&
+    stg add numbers.txt &&
     git commit -a -m one &&
     echo two >> numbers.txt &&
     git commit -a -m two &&
@@ -65,7 +65,7 @@ test_expect_success \
     '
     git checkout -b br master^^ &&
     echo woof > woof.txt &&
-    git add woof.txt &&
+    stg add woof.txt &&
     git commit -a -m woof &&
     git checkout master &&
     git pull . br
diff --git a/t/t1302-repair-interop.sh b/t/t1302-repair-interop.sh
index 9fad3fa..cce3cf1 100755
--- a/t/t1302-repair-interop.sh
+++ b/t/t1302-repair-interop.sh
@@ -4,7 +4,7 @@ test_description=3D'Test git/StGit interoperability wit=
h "stg repair"'
=20
 test_expect_success 'Create some git-only history' '
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     git commit -a -m foo &&
     git tag foo-tag &&
     for i in 0 1 2 3 4; do
diff --git a/t/t1500-float.sh b/t/t1500-float.sh
index e44af3a..0ed5733 100755
--- a/t/t1500-float.sh
+++ b/t/t1500-float.sh
@@ -12,13 +12,13 @@ test_description=3D'Test floating a number of patch=
es to the top of the stack
 test_expect_success \
 	'Initialize the StGIT repository' \
 	'stg init &&
-	 stg new A -m "a" && echo A >a.txt && git add a.txt && stg refresh &&
-	 stg new B -m "b" && echo B >b.txt && git add b.txt && stg refresh &&
-	 stg new C -m "c" && echo C >c.txt && git add c.txt && stg refresh &&
-	 stg new D -m "d" && echo D >d.txt && git add d.txt && stg refresh &&
-	 stg new E -m "e" && echo E >e.txt && git add e.txt && stg refresh &&
-	 stg new F -m "f" && echo F >f.txt && git add f.txt && stg refresh &&
-	 stg new G -m "g" && echo G >g.txt && git add g.txt && stg refresh &&
+	 stg new A -m "a" && echo A >a.txt && stg add a.txt && stg refresh &&
+	 stg new B -m "b" && echo B >b.txt && stg add b.txt && stg refresh &&
+	 stg new C -m "c" && echo C >c.txt && stg add c.txt && stg refresh &&
+	 stg new D -m "d" && echo D >d.txt && stg add d.txt && stg refresh &&
+	 stg new E -m "e" && echo E >e.txt && stg add e.txt && stg refresh &&
+	 stg new F -m "f" && echo F >f.txt && stg add f.txt && stg refresh &&
+	 stg new G -m "g" && echo G >g.txt && stg add g.txt && stg refresh &&
 	 stg pop &&
 	 test "$(echo $(stg series --applied --noprefix))" =3D "A B C D E F"
 	'
diff --git a/t/t1501-sink.sh b/t/t1501-sink.sh
index a0769dd..e2c65cb 100755
--- a/t/t1501-sink.sh
+++ b/t/t1501-sink.sh
@@ -6,22 +6,22 @@ test_description=3D'Test "stg sink"'
=20
 test_expect_success 'Initialize StGit stack' '
     echo 0 >> f0 &&
-    git add f0 &&
+    stg add f0 &&
     git commit -m initial &&
     echo 1 >> f1 &&
-    git add f1 &&
+    stg add f1 &&
     git commit -m p1 &&
     echo 2 >> f2 &&
-    git add f2 &&
+    stg add f2 &&
     git commit -m p2 &&
     echo 3 >> f3 &&
-    git add f3 &&
+    stg add f3 &&
     git commit -m p3 &&
     echo 4 >> f4 &&
-    git add f4 &&
+    stg add f4 &&
     git commit -m p4 &&
     echo 22 >> f2 &&
-    git add f2 &&
+    stg add f2 &&
     git commit -m p22 &&
     stg init &&
     stg uncommit p22 p4 p3 p2 p1 &&
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
index ef0b29d..f55bad6 100755
--- a/t/t1600-delete-one.sh
+++ b/t/t1600-delete-one.sh
@@ -12,7 +12,7 @@ test_expect_success \
     '
     stg new foo -m foo &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh
     '
=20
@@ -47,7 +47,7 @@ test_expect_success \
     '
     stg new foo -m foo &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh &&
     stg pop
     '
@@ -65,11 +65,11 @@ test_expect_success \
     '
     stg new foo -m foo &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh &&
     stg new bar -m bar &&
     echo bar > bar.txt &&
-    git add bar.txt &&
+    stg add bar.txt &&
     stg refresh
     '
=20
@@ -87,12 +87,12 @@ test_expect_success \
     stg branch --create br &&
     stg new baz -m baz &&
     echo baz > baz.txt &&
-    git add baz.txt &&
+    stg add baz.txt &&
     stg refresh &&
     stg branch master &&
     stg new baz -m baz &&
     echo baz > baz.txt &&
-    git add baz.txt &&
+    stg add baz.txt &&
     stg refresh
     '
=20
diff --git a/t/t1601-delete-many.sh b/t/t1601-delete-many.sh
index cb7fb0d..a0818b3 100755
--- a/t/t1601-delete-many.sh
+++ b/t/t1601-delete-many.sh
@@ -12,7 +12,7 @@ test_expect_success \
     '
     stg new p0 -m p0 &&
     echo p0 > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh &&
     for i in 1 2 3 4 5 6 7 8 9; do
         stg new p$i -m p$i &&
diff --git a/t/t1602-delete-spill.sh b/t/t1602-delete-spill.sh
index 1ddec53..3e27598 100755
--- a/t/t1602-delete-spill.sh
+++ b/t/t1602-delete-spill.sh
@@ -9,7 +9,7 @@ test_expect_success 'Initialize the StGIT repository' '
 test_expect_success 'Create five applied and three unapplied patches' =
'
     for i in 0 1 2 3 4 5 6 7; do
         echo $i >> foo &&
-        git add foo &&
+        stg add foo &&
         git commit -m p$i
     done
     stg uncommit -n 8 &&
diff --git a/t/t1700-goto-top.sh b/t/t1700-goto-top.sh
index 8f2d44a..618ebc7 100755
--- a/t/t1700-goto-top.sh
+++ b/t/t1700-goto-top.sh
@@ -19,7 +19,7 @@ test_expect_success \
 	'
 	stg new foo -m "Foo Patch" &&
 	echo foo > test &&
-	git add test &&
+	stg add test &&
 	stg refresh
 	'
=20
diff --git a/t/t1701-goto-hidden.sh b/t/t1701-goto-hidden.sh
index a3c6e62..19ab703 100755
--- a/t/t1701-goto-hidden.sh
+++ b/t/t1701-goto-hidden.sh
@@ -7,7 +7,7 @@ test_description=3D'Test "stg goto" with hidden patches=
'
 test_expect_success 'Initialize StGit stack' '
     stg init &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg new -m hidden-patch &&
     stg refresh &&
     stg pop &&
diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index 93de794..406a6cf 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -7,7 +7,7 @@ test_expect_success \
     'Initialize the StGIT repository' \
     '
     cp ../t1800-import/foo.txt . &&
-    git add foo.txt &&
+    stg add foo.txt &&
     git commit -a -m "initial version" &&
     stg init
     '
@@ -164,7 +164,7 @@ test_expect_success \
     'apply a series from a tarball' \
     '
     rm -f jabberwocky.txt && touch jabberwocky.txt &&
-    git add jabberwocky.txt && git commit -m "empty file" jabberwocky.=
txt &&
+    stg add jabberwocky.txt && git commit -m "empty file" jabberwocky.=
txt &&
     (cd ../t1800-import; tar -cjf jabberwocky.tar.bz2 patches) &&
     stg import --series ../t1800-import/jabberwocky.tar.bz2
     [ $(git cat-file -p $(stg id) \
diff --git a/t/t1900-mail.sh b/t/t1900-mail.sh
index cea6769..acb61a7 100755
--- a/t/t1900-mail.sh
+++ b/t/t1900-mail.sh
@@ -10,7 +10,7 @@ test_expect_success \
     for i in 1 2 3 4 5; do
       touch foo.txt &&
       echo "line $i" >> foo.txt &&
-      git add foo.txt &&
+      stg add foo.txt &&
       git commit -a -m "Patch $i"
     done &&
     stg init &&
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index d550538..696d698 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -18,15 +18,15 @@ test_expect_success \
     '
     stg new p1 -m p1 &&
     echo foo1 > foo1.txt &&
-    git add foo1.txt &&
+    stg add foo1.txt &&
     stg refresh &&
     stg new p2 -m p2 &&
     echo foo2 > foo2.txt &&
-    git add foo2.txt &&
+    stg add foo2.txt &&
     stg refresh &&
     stg new p3 -m p3 &&
     echo foo3 > foo3.txt &&
-    git add foo3.txt &&
+    stg add foo3.txt &&
     stg refresh &&
     stg export &&
     stg pop &&
@@ -86,7 +86,7 @@ test_expect_success \
     stg refresh &&
     stg goto p2 &&
     echo bar2 > bar2.txt &&
-    git add bar2.txt &&
+    stg add bar2.txt &&
     stg refresh &&
     stg goto p3 &&
     echo bar3 >> foo3.txt &&
@@ -117,7 +117,7 @@ test_expect_success \
     '
     [ "$(echo $(stg series --applied --noprefix))" =3D "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" =3D "p2 p3" ] &&
-    git add --update &&
+    stg add --update &&
     stg refresh &&
     stg goto p3
     [ "$(echo $(stg series --applied --noprefix))" =3D "p1 p2 p3" ] &&
@@ -135,7 +135,7 @@ test_expect_success \
     '
     [ "$(echo $(stg series --applied --noprefix))" =3D "p1 p2 p3" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" =3D "" ] &&
-    git add --update &&
+    stg add --update &&
     stg refresh &&
     [ "$(echo $(stg series --applied --noprefix))" =3D "p1 p2 p3" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" =3D "" ]
diff --git a/t/t2100-pull-policy-fetch.sh b/t/t2100-pull-policy-fetch.s=
h
index 670c7c6..07435f5 100755
--- a/t/t2100-pull-policy-fetch.sh
+++ b/t/t2100-pull-policy-fetch.sh
@@ -22,7 +22,7 @@ test_expect_success \
      git config branch.master.stgit.pull-policy fetch-rebase &&
      git config --list &&
      stg new c1 -m c1 &&
-     echo a > file && git add file && stg refresh
+     echo a > file && stg add file && stg refresh
     )
     '
=20
@@ -30,7 +30,7 @@ test_expect_success \
     'Add non-rewinding commit upstream and pull it from clone' \
     '
     (cd upstream && stg new u1 -m u1 &&
-     echo a > file2 && git add file2 && stg refresh) &&
+     echo a > file2 && stg add file2 && stg refresh) &&
     (cd clone && stg pull) &&
     test -e clone/file2
     '
diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
index 777ccb5..35c15ad 100755
--- a/t/t2101-pull-policy-pull.sh
+++ b/t/t2101-pull-policy-pull.sh
@@ -22,7 +22,7 @@ test_expect_success \
      git config branch.master.stgit.pull-policy pull &&
      git config --list &&
      stg new c1 -m c1 &&
-     echo a > file && git add file && stg refresh
+     echo a > file && stg add file && stg refresh
     )
     '
=20
@@ -30,7 +30,7 @@ test_expect_success \
     'Add non-rewinding commit upstream and pull it from clone' \
     '
     (cd upstream && stg new u1 -m u1 &&
-     echo a > file2 && git add file2 && stg refresh) &&
+     echo a > file2 && stg add file2 && stg refresh) &&
     (cd clone && stg pull) &&
      test -e clone/file2
     '
@@ -49,7 +49,7 @@ test_expect_success \
 test_expect_success \
     '"Solve" the conflict (pretend there is none)' \
     '(cd clone &&
-      git add file2 && EDITOR=3Dcat git commit)'
+      stg add file2 && EDITOR=3Dcat git commit)'
=20
 test_expect_success \
     'Push the stack back' \
diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase=
=2Esh
index 5619bda..952ee7e 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -16,14 +16,14 @@ test_expect_success \
     git config branch.stack.stgit.pull-policy rebase &&
     git config --list &&
     stg new c1 -m c1 &&
-    echo a > file && git add file && stg refresh
+    echo a > file && stg add file && stg refresh
     '
=20
 test_expect_success \
     'Add non-rewinding commit in parent and pull the stack' \
     '
     stg branch parent && stg new u1 -m u1 &&
-    echo b > file2 && git add file2 && stg refresh &&
+    echo b > file2 && stg add file2 && stg refresh &&
     stg branch stack && stg pull &&
     test -e file2
     '
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index adbf242..75e1f17 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -11,10 +11,10 @@ test_expect_success \
 	'Setup a multi-commit branch and fork an stgit stack' \
 	'
 	echo foo > file1 &&
-	git add file1 &&
+	stg add file1 &&
 	git commit -m a &&
 	echo foo > file2 &&
-	git add file2 &&
+	stg add file2 &&
 	git commit -m b &&
=20
 	stg branch --create stack &&
diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index 89c95db..34d6e69 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -8,7 +8,7 @@ test_expect_success 'Refresh from a subdirectory' '
     echo foo >> foo.txt &&
     mkdir bar &&
     echo bar >> bar/bar.txt &&
-    git add foo.txt bar/bar.txt &&
+    stg add foo.txt bar/bar.txt &&
     cd bar &&
     stg refresh &&
     cd .. &&
@@ -48,7 +48,7 @@ test_expect_success 'Refresh subdirectories recursive=
ly' '
 test_expect_success 'refresh -u' '
     echo baz >> bar/baz.txt &&
     stg new p1 -m p1 &&
-    git add bar/baz.txt &&
+    stg add bar/baz.txt &&
     stg refresh --index &&
     echo xyzzy >> foo.txt &&
     echo xyzzy >> bar/bar.txt &&
diff --git a/t/t2400-diff.sh b/t/t2400-diff.sh
index fbcefe1..73f4539 100755
--- a/t/t2400-diff.sh
+++ b/t/t2400-diff.sh
@@ -10,7 +10,7 @@ test_expect_success 'Diff with no StGit data' '
=20
 test_expect_success 'Make some local changes' '
     echo foo >> foo.txt &&
-    git add foo.txt
+    stg add foo.txt
 '
=20
 test_expect_success 'Diff with some local changes' '
diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index 7f821f5..8082c21 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -9,7 +9,7 @@ test_expect_success 'Initialize StGit stack' '
     stg new e0 -m e0 &&
     stg new p0 -m p0 &&
     echo foo > foo.txt &&
-    git add foo.txt &&
+    stg add foo.txt &&
     stg refresh &&
     stg new e1 -m e1 &&
     stg new e2 -m e2 &&
diff --git a/t/t2600-squash.sh b/t/t2600-squash.sh
index 3dba012..e36a638 100755
--- a/t/t2600-squash.sh
+++ b/t/t2600-squash.sh
@@ -9,7 +9,7 @@ test_expect_success 'Initialize StGit stack' '
     for i in 0 1 2 3; do
         stg new p$i -m "foo $i" &&
         echo "foo $i" >> foo.txt &&
-        git add foo.txt &&
+        stg add foo.txt &&
         stg refresh
     done
 '
diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
index aad6d45..6028b9e 100755
--- a/t/t2700-refresh.sh
+++ b/t/t2700-refresh.sh
@@ -13,7 +13,7 @@ test_expect_success 'Initialize StGit stack' '
     stg new p0 -m "base" &&
     for i in 1 2 3; do
         echo base >> foo$i.txt &&
-        git add foo$i.txt
+        stg add foo$i.txt
     done
     stg refresh &&
     for i in 1 2 3; do
@@ -104,7 +104,7 @@ test_expect_success 'Refresh --index' '
     stg status &&
     stg new p4 -m "refresh_index" &&
     echo baz 1 >> foo1.txt &&
-    git add foo1.txt &&
+    stg add foo1.txt &&
     echo blah 1 >> foo1.txt &&
     echo baz 2 >> foo2.txt &&
     stg refresh --index &&
@@ -119,7 +119,7 @@ test_expect_success 'Refresh --index' '
 '
=20
 test_expect_success 'Refresh moved files' '
-    git mv foo1.txt foo1-new.txt &&
+    stg mv foo1.txt foo1-new.txt &&
     stg refresh
 '
=20
diff --git a/t/t2701-refresh-p.sh b/t/t2701-refresh-p.sh
index ed4bac4..3ba3b02 100755
--- a/t/t2701-refresh-p.sh
+++ b/t/t2701-refresh-p.sh
@@ -15,7 +15,7 @@ test_expect_success 'Initialize StGit stack' '
     stg init &&
     for i in 1 2; do
         echo x > $i.txt &&
-        git add $i.txt &&
+        stg add $i.txt &&
         stg new p$i -m "Patch $i" &&
         stg refresh
     done
@@ -33,7 +33,7 @@ test_expect_success 'Add new file to non-top patch' '
     stg status > status1.txt &&
     test_cmp expected0.txt status1.txt &&
     echo y > new.txt &&
-    git add new.txt &&
+    stg add new.txt &&
     stg refresh -p p1 &&
     stg status > status2.txt &&
     test_cmp expected0.txt status2.txt &&
diff --git a/t/t2702-refresh-rm.sh b/t/t2702-refresh-rm.sh
index 0362cc6..fa81cee 100755
--- a/t/t2702-refresh-rm.sh
+++ b/t/t2702-refresh-rm.sh
@@ -20,7 +20,7 @@ test_expect_success 'Initialize StGit stack' '
     stg init &&
     echo x > x.txt &&
     echo y > y.txt &&
-    git add x.txt y.txt &&
+    stg add x.txt y.txt &&
     git commit -m "Add some files"
 '
=20
@@ -28,9 +28,9 @@ cat > expected0.txt <<EOF
 D y.txt
 EOF
 printf '' > expected1.txt
-test_expect_success 'git rm a file' '
+test_expect_success 'stg rm a file' '
     stg new -m p0 &&
-    git rm y.txt &&
+    stg rm y.txt &&
     stg status > status0.txt &&
     test_cmp expected0.txt status0.txt &&
     stg refresh &&
@@ -47,10 +47,10 @@ D y.txt
 M x.txt
 EOF
 printf '' > expected1.txt
-test_expect_success 'git rm a file together with other changes' '
+test_expect_success 'stg rm a file together with other changes' '
     stg new -m p1 &&
     echo x2 >> x.txt &&
-    git rm y.txt &&
+    stg rm y.txt &&
     stg status > status0.txt &&
     test_cmp expected0.txt status0.txt &&
     stg refresh &&
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 5960bd6..5ac77cc 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -13,7 +13,7 @@ test_expect_success 'Initialize StGit stack' '
     for i in 1 2 3; do
         echo foo$i >> foo/bar &&
         stg new p$i -m p$i &&
-        git add foo/bar &&
+        stg add foo/bar &&
         stg refresh
     done
 '
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index 419d86e..d8c16fa 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -7,7 +7,7 @@ test_description=3D'Try a push that requires merging a =
file that is dirty'
 test_expect_success 'Initialize StGit stack with two patches' '
     stg init &&
     touch a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 1 > a &&
     git commit -a -m p1 &&
diff --git a/t/t3100-reset.sh b/t/t3100-reset.sh
index 3024975..61f303d 100755
--- a/t/t3100-reset.sh
+++ b/t/t3100-reset.sh
@@ -12,7 +12,7 @@ EOF
 test_expect_success 'Initialize StGit stack with three patches' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 111 >> a &&
     git commit -a -m p1 &&
diff --git a/t/t3101-reset-hard.sh b/t/t3101-reset-hard.sh
index 45e86dc..a93682b 100755
--- a/t/t3101-reset-hard.sh
+++ b/t/t3101-reset-hard.sh
@@ -13,7 +13,7 @@ EOF
 test_expect_success 'Initialize StGit stack with three patches' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 111 >> a &&
     git commit -a -m p1 &&
diff --git a/t/t3102-undo.sh b/t/t3102-undo.sh
index 9373522..010a63d 100755
--- a/t/t3102-undo.sh
+++ b/t/t3102-undo.sh
@@ -12,7 +12,7 @@ EOF
 test_expect_success 'Initialize StGit stack with three patches' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 111 >> a &&
     git commit -a -m p1 &&
diff --git a/t/t3103-undo-hard.sh b/t/t3103-undo-hard.sh
index df14b1f..b94543e 100755
--- a/t/t3103-undo-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -13,7 +13,7 @@ EOF
 test_expect_success 'Initialize StGit stack with three patches' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 111 >> a &&
     git commit -a -m p1 &&
diff --git a/t/t3104-redo.sh b/t/t3104-redo.sh
index 030311d..3d3c617 100755
--- a/t/t3104-redo.sh
+++ b/t/t3104-redo.sh
@@ -12,7 +12,7 @@ EOF
 test_expect_success 'Initialize StGit stack with three patches' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m a &&
     echo 111 >> a &&
     git commit -a -m p1 &&
diff --git a/t/t3105-undo-external-mod.sh b/t/t3105-undo-external-mod.s=
h
index f5aad64..1980167 100755
--- a/t/t3105-undo-external-mod.sh
+++ b/t/t3105-undo-external-mod.sh
@@ -13,10 +13,10 @@ EOF
 test_expect_success 'Initialize StGit stack' '
     stg init &&
     echo 000 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m p0 &&
     echo 111 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m p1 &&
     stg uncommit -n 1
 '
@@ -29,7 +29,7 @@ EOF
 test_expect_success 'Make a git commit and turn it into a patch' '
     git rev-parse HEAD > head0.txt &&
     echo 222 >> a &&
-    git add a &&
+    stg add a &&
     git commit -m p2 &&
     git rev-parse HEAD > head1.txt &&
     stg repair &&
diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
index 1aa78ed..fe2ecc0 100755
--- a/t/t3200-non-ascii-filenames.sh
+++ b/t/t3200-non-ascii-filenames.sh
@@ -11,11 +11,11 @@ EOF
=20
 test_expect_success 'Setup' '
     echo "Fj=C3=A4derholmarna" > sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
-    git add sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
+    stg add sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
     git commit -m "Create island" &&
     stg init &&
     echo foo > unrelated.txt &&
-    git add unrelated.txt &&
+    stg add unrelated.txt &&
     stg new p0 -m "Unrelated file" &&
     stg refresh &&
     stg pop &&
diff --git a/t/t3300-edit.sh b/t/t3300-edit.sh
index ad3b23f..7003a27 100755
--- a/t/t3300-edit.sh
+++ b/t/t3300-edit.sh
@@ -5,7 +5,7 @@ test_description=3D'Test "stg edit"'
=20
 test_expect_success 'Setup' '
     printf "000\n111\n222\n333\n" >> foo &&
-    git add foo &&
+    stg add foo &&
     git commit -m "Initial commit" &&
     sed -i "s/000/000xx/" foo &&
     git commit -a -m "First change" &&
diff --git a/t/t3400-pick.sh b/t/t3400-pick.sh
index 6e92de3..22b348c 100755
--- a/t/t3400-pick.sh
+++ b/t/t3400-pick.sh
@@ -7,11 +7,11 @@ test_expect_success \
 	'Initialize the StGIT repository' \
 	'
 	stg init &&
-	stg new A -m "a" && echo A > a && git add a && stg refresh &&
-	stg new B -m "b" && echo B > b && git add b && stg refresh &&
+	stg new A -m "a" && echo A > a && stg add a && stg refresh &&
+	stg new B -m "b" && echo B > b && stg add b && stg refresh &&
 	stg branch --clone foo &&
-	stg new C -m "c" && echo C > c && git add c && stg refresh &&
-	stg new D-foo -m "d" && echo D > d && git add d && stg refresh &&
+	stg new C -m "c" && echo C > c && stg add c && stg refresh &&
+	stg new D-foo -m "d" && echo D > d && stg add d && stg refresh &&
 	stg branch master
 	'
=20
diff --git a/t/t4100-publish.sh b/t/t4100-publish.sh
index 17e07bc..7d72a6c 100755
--- a/t/t4100-publish.sh
+++ b/t/t4100-publish.sh
@@ -26,15 +26,15 @@ test_expect_success \
 	'
 	stg new p1 -m p1 &&
 	echo foo1 > foo1.txt &&
-	git add foo1.txt &&
+	stg add foo1.txt &&
 	stg refresh &&
 	stg new p2 -m p2 &&
 	echo foo2 > foo2.txt &&
-	git add foo2.txt &&
+	stg add foo2.txt &&
 	stg refresh &&
 	stg new p3 -m p3 &&
 	echo foo3 > foo3.txt &&
-	git add foo3.txt &&
+	stg add foo3.txt &&
 	stg refresh
 	'
=20
@@ -64,11 +64,11 @@ test_expect_success \
 	'
 	stg new p4 -m p4 &&
 	echo foo4 > foo4.txt &&
-	git add foo4.txt &&
+	stg add foo4.txt &&
 	stg refresh &&
 	stg new p5 -m p5 &&
 	echo foo5 > foo5.txt &&
-	git add foo5.txt &&
+	stg add foo5.txt &&
 	stg refresh &&
 	stg new empty -m empty &&
 	old_public=3D$(stg id master.public) &&
@@ -83,7 +83,7 @@ test_expect_success \
 	'
 	stg pop -a &&
 	echo foo0 > foo0.txt &&
-	git add foo0.txt &&
+	stg add foo0.txt &&
 	git commit -m "foo0.txt added" &&
 	stg push -a &&
 	old_public=3D$(stg id master.public) &&
