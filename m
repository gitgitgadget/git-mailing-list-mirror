Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F601F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeHMOPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33990 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so6780075plo.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mJpwvrkFbDYSH1Y4Nxsu/i94W8zSK/w5ldxZ4Aqa6uc=;
        b=dfIw4ZpfDgfZRO3GKVJ+xbwYrcBB+/q7l1vx88HFYaVVcOSXqfx3Sl9Na8PNz5vQso
         wNF/CgB47NvD/ZNAi5CexqvT9qkflhrf3VK9m9uYeivjgKZmEjNgk8i1zZCG35qeBORC
         sqmfutKMum9B0qrf2H1brTy2FZYKq6eZ3KIb6N4W41jr6X4kBOS10uSyCHym7GT+ZQf+
         1CDIV0m6B/zihuzb2VVDuoiWvkZK1gk3LKLB++irYWtEA8DxA0We4KAjJImE5H4q0VSf
         JYEr7O29+dOh4uDFAHDf6iiNoXAaN+5Byxv1xbTXVMz5/yTbeqankNk48ejQ586viCy5
         EDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mJpwvrkFbDYSH1Y4Nxsu/i94W8zSK/w5ldxZ4Aqa6uc=;
        b=MxxBPcm0RGfkETjzsUGURTNjZt7clW5ICY/5L2PyejasyxsWf2R/DB/HGyToG7S9NM
         4rAvmg8COwYepePSBjykivR2DyrLx2Tkog5XZj9VfZ5iKEF3AAe9xD21DKFwIBNbcsJ8
         yH/pq9X3H/dX1QqXfSf9L26PIKdcewe1i15i0wAbtOeDVVFevw78lXQPT2QpekAtfJAm
         ibrf4tIoqOZknRf1xz9OdcioWFRDleR5+UQ8DMEdV2tZ5FNJm9qiZWHfhI1yjfFSJ8K5
         IoEu/oTKgsl316lTohOMEixAzj+JmsWxLlG1XRfZc55kCWA4FdnE11cwr6rDtExkeofH
         UrhA==
X-Gm-Message-State: AOUpUlGpNMUYMNh1F4FPRWnunXE/jtOravp6vkm4HHuaq/KDT3fAnwT7
        VfhgUVfIOAMxdgleDzRqBUnR1Z0d
X-Google-Smtp-Source: AA+uWPzap6KDCKh1zw/IFMf94XpybAn6LWhL9yB0WFd6Hopv9Rle04hl+TtdKYPo4zKZDEEqvnCRRg==
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11-v6mr15948698plb.1.1534159997285;
        Mon, 13 Aug 2018 04:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 22-v6sm29418809pfl.126.2018.08.13.04.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:16 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:16 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:46 GMT
Message-Id: <1477c58e4c0c9e1d5836ffcb9bcb7360b1a5df0d.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Thomas Rast via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 11/21] range-diff: add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Rast <tr@thomasrast.ch>

These are essentially lifted from https://github.com/trast/tbdiff, with
light touch-ups to account for the command now being named `git
range-diff`.

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
index 3bd959ae5..b17bf71b8 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,6 +1,7 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
 /diff-lib/* eol=lf
 /t0110/url-* binary
+/t3206/* eol=lf
 /t3900/*.txt eol=lf
 /t3901/*.txt eol=lf
 /t4034/*/* eol=lf
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

