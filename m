Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E56120C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbdLCV3f (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:49330 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbdLCV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:32 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0McEDD-1ecraZ429n-00JWk5; Sun, 03 Dec 2017 22:28:57 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 7/7] t4013: test new output from diff --abbrev --raw
Date:   Sun,  3 Dec 2017 22:27:43 +0100
Message-Id: <20171203212743.10228-7-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:H61Cc46w3VR2CDoWactsnGLSWvw+SYfgFFpR2VHT6RZ0/p0hJvV
 u6RFIe31mi3cv8ev1dop6rEgm/gOoSvYfNQLCJLCm8DGPwjKXDOrTSPUMhsUfunLfjPEQ11
 rpGhk6QdrNmBD17oh4AbxKequoyNb1o8XyUubME+1AThUjYclTM7fOAT+7PAy1kc2WAUqur
 sumBELquGa5VT9znXs+eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DsYfp54PVZA=:9v81QBJTCXUm8UzR9vcdEp
 pZOcA1uf/+12mN/NtMgQvmqZCWfAnKOVTiy//eneWsb4y4Mnmla+hYv7Ylvt3D/EaZdHzZa83
 RQNRP6HnR0Nhy0QxXbBOIgPusreIIkHbVJMlOquaGszkooB9owY1msCEEDvVsNE1WczoXGIVf
 NwhbJMSJP6X9vociS3Qu2UZcFHAZb8B2kxNGsE2NLVm4rGEPQ2XwTrAHpava7xx48U4MN5J7X
 DaoMXmGXyGUYjmbwJWkTKeuxP9+wTxaPZUpPcooOVBExSnDgtFlO0Pe1N9l/gIkajkX+rTKw2
 niWwTr1l9qA/TjZzvCkAjs1utCOwz4BnnWTcc4tH/ci7+centem/8BGEF4Do8z4kEAmh/kNDh
 WttmGm8P1A8taBVtYHc0Q1G+S+VB19MV0tYWP0o8KohcFYIWLKeOVmrEsvpUZiR0lgKCtKXdn
 tDp7D2A33o5eeYmgXEOQqDExW0HjGtSvItN9iBrviS/A6l49dwfcYfxBkK6xWr6leERKmf4X1
 nPgecjCJOV3QtLteP+dyNOZeDgVuQbYJ+xtwTsKqgYJqZw9SvBy/bjnjsqhAcPv+f1R26pQA/
 Uo5BGxOePf6SSFdtknsbnR20GOZB9njlgomtaCfJvBShwZcbouq769hCCzQ5mZNeT04MWy5BB
 tb9+oaSnHe0cIkC3XXCsC+FMbUdiqznolA2BvRT1tNCenyvl/TvRFB1GICmL6sLI5hDI2zAjH
 hstjcx7FiVJWdEFe1ODGYg593py8AVkgHC6LSLBxKetcwsN3o5ia+aHOTVmHtAe/F/Onq0qlN
 zuFkh/SpVVhmdFCqq1BU1AlBnlEhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use newly-introduced finely-grained control to teach the diff-family to
honor the new environment GIT_PRINT_SHA1_ELLIPSIS and remove the
ellipses when it is not set.

Mentored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 t/t4013-diff-various.sh                            | 16 ++++++++-
 ...ff.noellipses-diff-tree_--root_--abbrev_initial |  6 ++++
 ...ellipses-diff-tree_--root_-r_--abbrev=4_initial |  6 ++++
 ...noellipses-diff-tree_--root_-r_--abbrev_initial |  6 ++++
 .../diff.noellipses-diff-tree_-c_--abbrev_master   |  5 +++
 ...ipses-diff_--no-index_--raw_--abbrev=4_dir2_dir |  3 ++
 .../diff.noellipses-diff_--no-index_--raw_dir2_dir |  3 ++
 ...ellipses-diff_--patch-with-raw_-r_initial..side | 36 +++++++++++++++++++
 ....noellipses-diff_--patch-with-raw_initial..side | 36 +++++++++++++++++++
 .../diff.noellipses-diff_--raw_--abbrev=4_initial  |  6 ++++
 t/t4013/diff.noellipses-diff_--raw_initial         |  6 ++++
 t/t4013/diff.noellipses-show_--patch-with-raw_side | 42 ++++++++++++++++++++++
 t/t4013/diff.noellipses-whatchanged_--root_master  | 42 ++++++++++++++++++++++
 t/t4013/diff.noellipses-whatchanged_-SF_master     |  9 +++++
 t/t4013/diff.noellipses-whatchanged_master         | 32 +++++++++++++++++
 15 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 t/t4013/diff.noellipses-diff-tree_--root_--abbrev_initial
 create mode 100644 t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial
 create mode 100644 t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev_initial
 create mode 100644 t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
 create mode 100644 t/t4013/diff.noellipses-diff_--no-index_--raw_--abbrev=4_dir2_dir
 create mode 100644 t/t4013/diff.noellipses-diff_--no-index_--raw_dir2_dir
 create mode 100644 t/t4013/diff.noellipses-diff_--patch-with-raw_-r_initial..side
 create mode 100644 t/t4013/diff.noellipses-diff_--patch-with-raw_initial..side
 create mode 100644 t/t4013/diff.noellipses-diff_--raw_--abbrev=4_initial
 create mode 100644 t/t4013/diff.noellipses-diff_--raw_initial
 create mode 100644 t/t4013/diff.noellipses-show_--patch-with-raw_side
 create mode 100644 t/t4013/diff.noellipses-whatchanged_--root_master
 create mode 100644 t/t4013/diff.noellipses-whatchanged_-SF_master
 create mode 100644 t/t4013/diff.noellipses-whatchanged_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7288b540450f..f10798b2dff3 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -140,7 +140,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd" '
+	test_expect_success "git $cmd # magic is ${magic:-"(not used)"}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
@@ -175,9 +175,12 @@ diff-tree -r --abbrev initial
 diff-tree -r --abbrev=4 initial
 diff-tree --root initial
 diff-tree --root --abbrev initial
+:noellipses diff-tree --root --abbrev initial
 diff-tree --root -r initial
 diff-tree --root -r --abbrev initial
+:noellipses diff-tree --root -r --abbrev initial
 diff-tree --root -r --abbrev=4 initial
+:noellipses diff-tree --root -r --abbrev=4 initial
 diff-tree -p initial
 diff-tree --root -p initial
 diff-tree --patch-with-stat initial
@@ -226,6 +229,7 @@ diff-tree -p master
 diff-tree -p -m master
 diff-tree -c master
 diff-tree -c --abbrev master
+:noellipses diff-tree -c --abbrev master
 diff-tree --cc master
 # stat only should show the diffstat with the first parent
 diff-tree -c --stat master
@@ -272,8 +276,10 @@ rev-list --parents HEAD
 rev-list --children HEAD
 
 whatchanged master
+:noellipses whatchanged master
 whatchanged -p master
 whatchanged --root master
+:noellipses whatchanged --root master
 whatchanged --root -p master
 whatchanged --patch-with-stat master
 whatchanged --root --patch-with-stat master
@@ -283,6 +289,7 @@ whatchanged --root -c --patch-with-stat --summary master
 # improved by Timo's patch
 whatchanged --root --cc --patch-with-stat --summary master
 whatchanged -SF master
+:noellipses whatchanged -SF master
 whatchanged -SF -p master
 
 log --patch-with-stat master -- dir/
@@ -301,6 +308,7 @@ show --stat side
 show --stat --summary side
 show --patch-with-stat side
 show --patch-with-raw side
+:noellipses show --patch-with-raw side
 show --patch-with-stat --summary side
 
 format-patch --stdout initial..side
@@ -328,8 +336,10 @@ diff -r --stat initial..side
 diff initial..side
 diff --patch-with-stat initial..side
 diff --patch-with-raw initial..side
+:noellipses diff --patch-with-raw initial..side
 diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
+:noellipses diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
@@ -342,10 +352,14 @@ diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
 # No-index --abbrev and --no-abbrev
 diff --raw initial
+:noellipses diff --raw initial
 diff --raw --abbrev=4 initial
+:noellipses diff --raw --abbrev=4 initial
 diff --raw --no-abbrev initial
 diff --no-index --raw dir2 dir
+:noellipses diff --no-index --raw dir2 dir
 diff --no-index --raw --abbrev=4 dir2 dir
+:noellipses diff --no-index --raw --abbrev=4 dir2 dir
 diff --no-index --raw --no-abbrev dir2 dir
 EOF
 
diff --git a/t/t4013/diff.noellipses-diff-tree_--root_--abbrev_initial b/t/t4013/diff.noellipses-diff-tree_--root_--abbrev_initial
new file mode 100644
index 000000000000..4bdad4072ebf
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff-tree_--root_--abbrev_initial
@@ -0,0 +1,6 @@
+$ git diff-tree --root --abbrev initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+:000000 040000 0000000 da7a33f A	dir
+:000000 100644 0000000 01e79c3 A	file0
+:000000 100644 0000000 01e79c3 A	file2
+$
diff --git a/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial
new file mode 100644
index 000000000000..26fbfeb177be
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial
@@ -0,0 +1,6 @@
+$ git diff-tree --root -r --abbrev=4 initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+:000000 100644 0000 35d2 A	dir/sub
+:000000 100644 0000 01e7 A	file0
+:000000 100644 0000 01e7 A	file2
+$
diff --git a/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev_initial b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev_initial
new file mode 100644
index 000000000000..2ac856119190
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev_initial
@@ -0,0 +1,6 @@
+$ git diff-tree --root -r --abbrev initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+:000000 100644 0000000 35d242b A	dir/sub
+:000000 100644 0000000 01e79c3 A	file0
+:000000 100644 0000000 01e79c3 A	file2
+$
diff --git a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
new file mode 100644
index 000000000000..bb80f013b37d
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
@@ -0,0 +1,5 @@
+$ git diff-tree -c --abbrev master
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
+::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
+$
diff --git a/t/t4013/diff.noellipses-diff_--no-index_--raw_--abbrev=4_dir2_dir b/t/t4013/diff.noellipses-diff_--no-index_--raw_--abbrev=4_dir2_dir
new file mode 100644
index 000000000000..41b7baf0a534
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--no-index_--raw_--abbrev=4_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --raw --abbrev=4 dir2 dir
+:000000 100644 0000 0000 A	dir/sub
+$
diff --git a/t/t4013/diff.noellipses-diff_--no-index_--raw_dir2_dir b/t/t4013/diff.noellipses-diff_--no-index_--raw_dir2_dir
new file mode 100644
index 000000000000..0cf3a3efea83
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--no-index_--raw_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --raw dir2 dir
+:000000 100644 0000000 0000000 A	dir/sub
+$
diff --git a/t/t4013/diff.noellipses-diff_--patch-with-raw_-r_initial..side b/t/t4013/diff.noellipses-diff_--patch-with-raw_-r_initial..side
new file mode 100644
index 000000000000..8d1f1e372199
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--patch-with-raw_-r_initial..side
@@ -0,0 +1,36 @@
+$ git diff --patch-with-raw -r initial..side
+:100644 100644 35d242b 7289e35 M	dir/sub
+:100644 100644 01e79c3 f4615da M	file0
+:000000 100644 0000000 7289e35 A	file3
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.noellipses-diff_--patch-with-raw_initial..side b/t/t4013/diff.noellipses-diff_--patch-with-raw_initial..side
new file mode 100644
index 000000000000..50d8aee4f7f3
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--patch-with-raw_initial..side
@@ -0,0 +1,36 @@
+$ git diff --patch-with-raw initial..side
+:100644 100644 35d242b 7289e35 M	dir/sub
+:100644 100644 01e79c3 f4615da M	file0
+:000000 100644 0000000 7289e35 A	file3
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.noellipses-diff_--raw_--abbrev=4_initial b/t/t4013/diff.noellipses-diff_--raw_--abbrev=4_initial
new file mode 100644
index 000000000000..8ae44d6c8365
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--raw_--abbrev=4_initial
@@ -0,0 +1,6 @@
+$ git diff --raw --abbrev=4 initial
+:100644 100644 35d2 9929 M	dir/sub
+:100644 100644 01e7 10a8 M	file0
+:000000 100644 0000 b1e6 A	file1
+:100644 000000 01e7 0000 D	file2
+$
diff --git a/t/t4013/diff.noellipses-diff_--raw_initial b/t/t4013/diff.noellipses-diff_--raw_initial
new file mode 100644
index 000000000000..0175bfb28166
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff_--raw_initial
@@ -0,0 +1,6 @@
+$ git diff --raw initial
+:100644 100644 35d242b 992913c M	dir/sub
+:100644 100644 01e79c3 10a8a9f M	file0
+:000000 100644 0000000 b1e6722 A	file1
+:100644 000000 01e79c3 0000000 D	file2
+$
diff --git a/t/t4013/diff.noellipses-show_--patch-with-raw_side b/t/t4013/diff.noellipses-show_--patch-with-raw_side
new file mode 100644
index 000000000000..32fed3d5764b
--- /dev/null
+++ b/t/t4013/diff.noellipses-show_--patch-with-raw_side
@@ -0,0 +1,42 @@
+$ git show --patch-with-raw side
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+:100644 100644 35d242b 7289e35 M	dir/sub
+:100644 100644 01e79c3 f4615da M	file0
+:000000 100644 0000000 7289e35 A	file3
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.noellipses-whatchanged_--root_master b/t/t4013/diff.noellipses-whatchanged_--root_master
new file mode 100644
index 000000000000..c2cfd4e72927
--- /dev/null
+++ b/t/t4013/diff.noellipses-whatchanged_--root_master
@@ -0,0 +1,42 @@
+$ git whatchanged --root master
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+:100644 100644 35d242b 7289e35 M	dir/sub
+:100644 100644 01e79c3 f4615da M	file0
+:000000 100644 0000000 7289e35 A	file3
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+:100644 100644 8422d40 cead32e M	dir/sub
+:000000 100644 0000000 b1e6722 A	file1
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+:100644 100644 35d242b 8422d40 M	dir/sub
+:100644 100644 01e79c3 b414108 M	file0
+:100644 000000 01e79c3 0000000 D	file2
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+:000000 100644 0000000 35d242b A	dir/sub
+:000000 100644 0000000 01e79c3 A	file0
+:000000 100644 0000000 01e79c3 A	file2
+$
diff --git a/t/t4013/diff.noellipses-whatchanged_-SF_master b/t/t4013/diff.noellipses-whatchanged_-SF_master
new file mode 100644
index 000000000000..b36ce5886e0e
--- /dev/null
+++ b/t/t4013/diff.noellipses-whatchanged_-SF_master
@@ -0,0 +1,9 @@
+$ git whatchanged -SF master
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+:100644 100644 8422d40 cead32e M	dir/sub
+$
diff --git a/t/t4013/diff.noellipses-whatchanged_master b/t/t4013/diff.noellipses-whatchanged_master
new file mode 100644
index 000000000000..55e500f2edbe
--- /dev/null
+++ b/t/t4013/diff.noellipses-whatchanged_master
@@ -0,0 +1,32 @@
+$ git whatchanged master
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+:100644 100644 35d242b 7289e35 M	dir/sub
+:100644 100644 01e79c3 f4615da M	file0
+:000000 100644 0000000 7289e35 A	file3
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+:100644 100644 8422d40 cead32e M	dir/sub
+:000000 100644 0000000 b1e6722 A	file1
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+:100644 100644 35d242b 8422d40 M	dir/sub
+:100644 100644 01e79c3 b414108 M	file0
+:100644 000000 01e79c3 0000000 D	file2
+$
-- 
2.13.6

