Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC55D1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeGCL0d (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40858 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGCL00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id x5-v6so841787pgp.7
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=/u/NCTPyjLYmJ9Tx76MnICWMGGBBqnH9UMMAHZiH6OM=;
        b=ConZtsF9aIsdHSPwVvs1Vbb/0dQG7KQgin2V5eTW5ptOTBe7bWaVI0vU1mgcE5NrkI
         kgR9nCI3IsLzllP09ynbNE5cCfjeDgKKX7dHwOr5IACnElP/uTu33Zw1kTp9ZjTBtTb3
         E2Xe0PYZDHn44lFP/zQ74//P++/HEoTYhapqzs7IyiEQgRUCzli4WacRK/FEd6t46GWp
         q2OPCT6vdGle9e6ZMxgfWt3v9XckSY8jWYXiOeKp2xI2kGQkuz+lo4oePEKNjwTYYMFd
         n4kxu56mWcen5QA4+l6MlOzwSeJ5YjpkHF8D00q0bCBKw0rbaVItRUwSOlRiVI6k6oDM
         24vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=/u/NCTPyjLYmJ9Tx76MnICWMGGBBqnH9UMMAHZiH6OM=;
        b=nTIQP6Cqyuf6BlXhqmHWBHlBQvpxQUU2cjuw/3ugxFt0cUsqiqHqA2AIjnVu1OhE3V
         Yn8y8MwGC7Zo+OBXHTTpbNUoYQPnT6aNIv/eic1yACfY7xthU+epIp2wbyeg2Ui3L1hj
         Cs/ORV88OB7emstE1/i3ES4NdTA3YUvuZ9u4aUgp6AEva0m10s9OgPSdIwrRrCy7eQ5g
         +HWZCKHWE97PzzVdyC8dQHYptzoB6jIwYPpxX2eqIONIQTrXA7L8ex4t098Oa8xXTgCI
         XMleSNx2sGAjfgUUtd8CVIxwm4ofpETqdD/xQbPSDhdI49Fw7cgabWLqqRJtjJ2Wvb3x
         opmw==
X-Gm-Message-State: APt69E123Zin+9aUR2u2EsHqtaDmCTUo7ZVYfWjJ++55Mb5BhJ9xSPs1
        /uAVxUaOsZXrcPei+hakd0Wh7Q==
X-Google-Smtp-Source: AAOMgpdf26NrIoBBqoVHtB91noOSqv/MD9cbbzUN/w5Q5lhFUeeKrc7sXBTfetiWmm4riwJ6qlCASA==
X-Received: by 2002:a62:968f:: with SMTP id s15-v6mr29254724pfk.191.1530617185386;
        Tue, 03 Jul 2018 04:26:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id r81-v6sm2136238pfb.104.2018.07.03.04.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:24 -0700 (PDT)
Message-Id: <3d9e5b0ba383bab3a30b74a96a1d78557e168b7f.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Thomas Rast via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 17:19:37 +0200
Subject: [PATCH v3 11/20] range-diff: add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Rast <tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Rast <tr@thomasrast.ch>

These are essentially lifted from https://github.com/trast/tbdiff, with
light touch-ups to account for the command now being an option of `git
branch`.

Apart from renaming `tbdiff` to `range-diff`, only one test case needed
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
 t/t3206-range-diff.sh  | 145 ++++++++++
 t/t3206/history.export | 604 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 750 insertions(+)
 create mode 100755 t/t3206-range-diff.sh
 create mode 100644 t/t3206/history.export

diff --git a/t/.gitattributes b/t/.gitattributes
index 3bd959ae5..af15d5aee 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -18,5 +18,6 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t5515/* eol=lf
 /t556x_common eol=lf
 /t7500/* eol=lf
+/t7910/* eol=lf
 /t8005/*.txt eol=lf
 /t9*/*.dump eol=lf
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
new file mode 100755
index 000000000..2237c7f4a
--- /dev/null
+++ b/t/t3206-range-diff.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description='range-diff tests'
+
+. ./test-lib.sh
+
+# Note that because of the range-diff's heuristics, test_commit does more
+# harm than good.  We need some real history.
+
+test_expect_success 'setup' '
+	git fast-import < "$TEST_DIRECTORY"/t3206/history.export
+'
+
+test_expect_success 'simple A..B A..C (unmodified)' '
+	git range-diff --no-color master..topic master..unmodified \
+		>actual &&
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
+	git range-diff --no-color topic...unmodified >actual &&
+	# same "expected" as above
+	test_cmp expected actual
+'
+
+test_expect_success 'simple A B C (unmodified)' '
+	git range-diff --no-color master topic unmodified >actual &&
+	# same "expected" as above
+	test_cmp expected actual
+'
+
+test_expect_success 'trivial reordering' '
+	git range-diff --no-color master topic reordered >actual &&
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
+	git range-diff --no-color master topic removed >actual &&
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
+	git range-diff --no-color master topic added >actual &&
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
+	git range-diff --no-color master topic rebased >actual &&
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
+	git range-diff --no-color topic...rebased >actual &&
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
+	git range-diff --no-color topic...changed >actual &&
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
+	git range-diff --no-color topic...changed-message >actual &&
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
diff --git a/t/t3206/history.export b/t/t3206/history.export
new file mode 100644
index 000000000..b8ffff094
--- /dev/null
+++ b/t/t3206/history.export
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
gitgitgadget

