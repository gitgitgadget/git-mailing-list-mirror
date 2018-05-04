Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F691200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEDPfE (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:60515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDPe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:59 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lm6IP-1efpwj40RN-00Zgmc; Fri, 04 May 2018 17:34:53 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/18] branch-diff: add tests
Date:   Fri,  4 May 2018 17:34:52 +0200
Message-Id: <313beeed3d100a3b5198bd0ce3084744288b05c2.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ep2uZQAL7ZAZYgz21mVHcBUXpya5M8VOuAluGbSVgTurHx+G11w
 buSFO2PdNFZCZLsyk+sVEburRc9GyopNsH8ySdQ1ZMMQIZ/KD6ryrZjV3RgDkU5m4K0qmKQ
 jbhoRc7DlgIa2in+NFOh5uRuZ8wxFVV49x5atR3/sTa2R2sJ/5G7lbJskIViKL2HWR2jYjJ
 XsXRMRYD4a5UFpr4xQNCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iYnPFmOLjzI=:yknGBbO+7sLuaRzAr5WhpL
 Va4kIzZOYiBK69z4epX6b09iIUSKAojfsI8CkntPEmLLr1bkVNzldbsoZkQHWZ63lJ8svTPr5
 nLND7AuYBQEIxPsbkk/IU7TiqWSUm3ADxJFq2n4gwvGfopBoRt9FHAIt3sZUR7X4tDpue+xA5
 LIOPORVIE5Rlrhxnu4St08xuYf5MmXiU97xZ1E6Wupp/JyILV3hMpfKPdnlWmIY0YDxTODDyu
 BITZiRD+NQilUUPcerCMErCiusXoiuT/msgx6YWqQLKWuR1S/kYM3gY2Z1iPi7K0J5T8IdQ96
 faLoV7DfMKWGDJw2Vy/YfbPZ4Hw+v/Xeg0MHdRdOyh9pnzPpxXFv4+gfnHNt+i5DLDAyRUte8
 hKmhPNBwBWceLPtRMeW04w5CxGmRvhfqLcT1QVbpFMCU6V2uZbmgcw4HGnyqLDDAtvn0H5j2v
 hQFThVPzM6mgWYI6+q1PfldZYC+Cqqs9DwHRMFTL30KI3RoabeHyJwonWViGfKXOUQ5vQs+DM
 K13BNOotU2kC2/oYvxefAhV7ZDp74VjPeapJjermrqtHUofx9enPt5HqYFXro5B4mba9NVwLj
 vY8IcLTnXGQV46hIcgUnDYmLOw48iJ/HEO3btUvEQeOt0aOokZLcXeO+PHGu0DR3DhMNrardT
 xpBYtggP6aPKg3ux0DLN552A/dt33P/x+vPi/a1P7QFmwarGfujvr5tPLHVTBHaDpvZ2o/tLe
 h5Xdjc19v9yp0IXWau4bkVf4H/pkqkAWLDTGfL/ADrEHNqy7vzrIow2vugPi1EGceh0FgFz5s
 +4GxUtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Rast <tr@thomasrast.ch>

These are essentially lifted from https://github.com/trast/tbdiff, with
light touch-ups to account for the new command name.

Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
to be adjusted: 11 - 'changed message'.

The underlying reason it had to be adjusted is that diff generation is
sometimes ambiguous. In this case, a comment line and an empty line are
added, but it is ambiguous whether they were added after the existing
empty line, or whether an empty line and the comment line are added
*before* the existing empty line. And apparently xdiff picks a different
option here than Python's difflib.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes       |   1 +
 t/t7910-branch-diff.sh | 144 ++++++++++
 t/t7910/history.export | 604 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 749 insertions(+)
 create mode 100755 t/t7910-branch-diff.sh
 create mode 100644 t/t7910/history.export

diff --git a/t/.gitattributes b/t/.gitattributes
index 3bd959ae523..af15d5aeedd 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -18,5 +18,6 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t5515/* eol=lf
 /t556x_common eol=lf
 /t7500/* eol=lf
+/t7910/* eol=lf
 /t8005/*.txt eol=lf
 /t9*/*.dump eol=lf
diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
new file mode 100755
index 00000000000..a7fece88045
--- /dev/null
+++ b/t/t7910-branch-diff.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='branch-diff tests'
+
+. ./test-lib.sh
+
+# Note that because of git-branch-diff's heuristics, test_commit does more
+# harm than good.  We need some real history.
+
+test_expect_success 'setup' '
+	git fast-import < "$TEST_DIRECTORY"/t7910/history.export
+'
+
+test_expect_success 'simple A..B A..C (unmodified)' '
+	git branch-diff --no-color master..topic master..unmodified >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  35b9b25 s/5/A/
+	2:  fccce22 = 2:  de345ab s/4/A/
+	3:  147e64e = 3:  9af6654 s/11/B/
+	4:  a63e992 = 4:  2901f77 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'simple B...C (unmodified)' '
+	git branch-diff --no-color topic...unmodified >actual &&
+	# same "expected" as above
+	test_cmp expected actual
+'
+
+test_expect_success 'simple A B C (unmodified)' '
+	git branch-diff --no-color master topic unmodified >actual &&
+	# same "expected" as above
+	test_cmp expected actual
+'
+
+test_expect_success 'trivial reordering' '
+	git branch-diff --no-color master topic reordered >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  aca177a s/5/A/
+	3:  147e64e = 2:  14ad629 s/11/B/
+	4:  a63e992 = 3:  ee58208 s/12/B/
+	2:  fccce22 = 4:  307b27a s/4/A/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'removed a commit' '
+	git branch-diff --no-color master topic removed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  7657159 s/5/A/
+	2:  fccce22 < -:  ------- s/4/A/
+	3:  147e64e = 2:  43d84d3 s/11/B/
+	4:  a63e992 = 3:  a740396 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'added a commit' '
+	git branch-diff --no-color master topic added >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  2716022 s/5/A/
+	2:  fccce22 = 2:  b62accd s/4/A/
+	-:  ------- > 3:  df46cfa s/6/A/
+	3:  147e64e = 4:  3e64548 s/11/B/
+	4:  a63e992 = 5:  12b4063 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'new base, A B C' '
+	git branch-diff --no-color master topic rebased >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  cc9c443 s/5/A/
+	2:  fccce22 = 2:  c5d9641 s/4/A/
+	3:  147e64e = 3:  28cc2b6 s/11/B/
+	4:  a63e992 = 4:  5628ab7 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'new base, B...C' '
+	# this syntax includes the commits from master!
+	git branch-diff --no-color topic...rebased >actual &&
+	cat >expected <<-EOF &&
+	-:  ------- > 1:  a31b12e unrelated
+	1:  4de457d = 2:  cc9c443 s/5/A/
+	2:  fccce22 = 3:  c5d9641 s/4/A/
+	3:  147e64e = 4:  28cc2b6 s/11/B/
+	4:  a63e992 = 5:  5628ab7 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'changed commit' '
+	git branch-diff --no-color topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	    @@ -10,7 +10,7 @@
+	      9
+	      10
+	     -11
+	    -+B
+	    ++BB
+	      12
+	      13
+	      14
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	    @@ -8,7 +8,7 @@
+	     @@
+	      9
+	      10
+	    - B
+	    + BB
+	     -12
+	     +B
+	      13
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'changed message' '
+	git branch-diff --no-color topic...changed-message >actual &&
+	sed s/Z/\ /g >expected <<-EOF &&
+	1:  4de457d = 1:  f686024 s/5/A/
+	2:  fccce22 ! 2:  4ab067d s/4/A/
+	    @@ -2,6 +2,8 @@
+	    Z
+	    Z    s/4/A/
+	    Z
+	    +    Also a silly comment here!
+	    +
+	    Zdiff --git a/file b/file
+	    Z--- a/file
+	    Z+++ b/file
+	3:  147e64e = 3:  b9cb956 s/11/B/
+	4:  a63e992 = 4:  8add5f1 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t7910/history.export b/t/t7910/history.export
new file mode 100644
index 00000000000..b8ffff0940d
--- /dev/null
+++ b/t/t7910/history.export
@@ -0,0 +1,604 @@
+blob
+mark :1
+data 51
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+reset refs/heads/removed
+commit refs/heads/removed
+mark :2
+author Thomas Rast <trast@inf.ethz.ch> 1374424921 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374484724 +0200
+data 8
+initial
+M 100644 :1 file
+
+blob
+mark :3
+data 51
+1
+2
+3
+4
+A
+6
+7
+8
+9
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/topic
+mark :4
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+blob
+mark :5
+data 51
+1
+2
+3
+A
+A
+6
+7
+8
+9
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/topic
+mark :6
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+data 7
+s/4/A/
+from :4
+M 100644 :5 file
+
+blob
+mark :7
+data 50
+1
+2
+3
+A
+A
+6
+7
+8
+9
+10
+B
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/topic
+mark :8
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+data 8
+s/11/B/
+from :6
+M 100644 :7 file
+
+blob
+mark :9
+data 49
+1
+2
+3
+A
+A
+6
+7
+8
+9
+10
+B
+B
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/topic
+mark :10
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+data 8
+s/12/B/
+from :8
+M 100644 :9 file
+
+blob
+mark :11
+data 10
+unrelated
+
+commit refs/heads/master
+mark :12
+author Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
+data 10
+unrelated
+from :2
+M 100644 :11 otherfile
+
+commit refs/heads/rebased
+mark :13
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485137 +0200
+data 7
+s/5/A/
+from :12
+M 100644 :3 file
+
+commit refs/heads/rebased
+mark :14
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485138 +0200
+data 7
+s/4/A/
+from :13
+M 100644 :5 file
+
+commit refs/heads/rebased
+mark :15
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485138 +0200
+data 8
+s/11/B/
+from :14
+M 100644 :7 file
+
+commit refs/heads/rebased
+mark :16
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485138 +0200
+data 8
+s/12/B/
+from :15
+M 100644 :9 file
+
+commit refs/heads/added
+mark :17
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485341 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/added
+mark :18
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485341 +0200
+data 7
+s/4/A/
+from :17
+M 100644 :5 file
+
+blob
+mark :19
+data 51
+1
+2
+3
+A
+A
+A
+7
+8
+9
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/added
+mark :20
+author Thomas Rast <trast@inf.ethz.ch> 1374485186 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485341 +0200
+data 7
+s/6/A/
+from :18
+M 100644 :19 file
+
+blob
+mark :21
+data 50
+1
+2
+3
+A
+A
+A
+7
+8
+9
+10
+B
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/added
+mark :22
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485341 +0200
+data 8
+s/11/B/
+from :20
+M 100644 :21 file
+
+blob
+mark :23
+data 49
+1
+2
+3
+A
+A
+A
+7
+8
+9
+10
+B
+B
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/added
+mark :24
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485341 +0200
+data 8
+s/12/B/
+from :22
+M 100644 :23 file
+
+commit refs/heads/reordered
+mark :25
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485350 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+blob
+mark :26
+data 50
+1
+2
+3
+4
+A
+6
+7
+8
+9
+10
+B
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/reordered
+mark :27
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485350 +0200
+data 8
+s/11/B/
+from :25
+M 100644 :26 file
+
+blob
+mark :28
+data 49
+1
+2
+3
+4
+A
+6
+7
+8
+9
+10
+B
+B
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/reordered
+mark :29
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485350 +0200
+data 8
+s/12/B/
+from :27
+M 100644 :28 file
+
+commit refs/heads/reordered
+mark :30
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485350 +0200
+data 7
+s/4/A/
+from :29
+M 100644 :9 file
+
+commit refs/heads/changed
+mark :31
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485507 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/changed
+mark :32
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485507 +0200
+data 7
+s/4/A/
+from :31
+M 100644 :5 file
+
+blob
+mark :33
+data 51
+1
+2
+3
+A
+A
+6
+7
+8
+9
+10
+BB
+12
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/changed
+mark :34
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485507 +0200
+data 8
+s/11/B/
+from :32
+M 100644 :33 file
+
+blob
+mark :35
+data 50
+1
+2
+3
+A
+A
+6
+7
+8
+9
+10
+BB
+B
+13
+14
+15
+16
+17
+18
+19
+20
+
+commit refs/heads/changed
+mark :36
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485507 +0200
+data 8
+s/12/B/
+from :34
+M 100644 :35 file
+
+commit refs/heads/changed-message
+mark :37
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485530 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/changed-message
+mark :38
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485530 +0200
+data 35
+s/4/A/
+
+Also a silly comment here!
+from :37
+M 100644 :5 file
+
+commit refs/heads/changed-message
+mark :39
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485536 +0200
+data 8
+s/11/B/
+from :38
+M 100644 :7 file
+
+commit refs/heads/changed-message
+mark :40
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485536 +0200
+data 8
+s/12/B/
+from :39
+M 100644 :9 file
+
+commit refs/heads/unmodified
+mark :41
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485631 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/unmodified
+mark :42
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485631 +0200
+data 7
+s/4/A/
+from :41
+M 100644 :5 file
+
+commit refs/heads/unmodified
+mark :43
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485632 +0200
+data 8
+s/11/B/
+from :42
+M 100644 :7 file
+
+commit refs/heads/unmodified
+mark :44
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374485632 +0200
+data 8
+s/12/B/
+from :43
+M 100644 :9 file
+
+commit refs/heads/removed
+mark :45
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374486061 +0200
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/removed
+mark :46
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374486061 +0200
+data 8
+s/11/B/
+from :45
+M 100644 :26 file
+
+commit refs/heads/removed
+mark :47
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1374486061 +0200
+data 8
+s/12/B/
+from :46
+M 100644 :28 file
+
+reset refs/heads/removed
+from :47
+
-- 
2.17.0.409.g71698f11835


