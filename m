Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76341F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeGUW7S (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34526 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeGUW7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so6628410plo.1
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=01l/+dDoqva9GexUKYv93lK+e9emHYRbStT6DrBJ0NY=;
        b=c3WboSoO57CSg2+ZDyoauiMOWm4QEK46a2IpUM+qN60UZrUB+3vLYu/BJ0VQaBt4uJ
         CwEOXJgsuH79ilST+s/9EAhIpT3eXiIHN5v8ngft4hFr2XHePoj1LLgJzdXVQRholQD/
         f5gTDJlNx2VlUkmDjAqNQWQ0TG6iT3HRjoUltut2p01/0uHtvIZRBaTuppBLzV80AKwy
         x5RuDNm/ku9Dd0xqpl03r1JYVlmyGlgItW2zjMzPXVNYaS3vLAYmB2M6yd8xEd0OU2C8
         cqHONJIA8kh0oemHEHNenMRcOalCK5Ei/ucEQWMznlCdyRNUOo4QpsC6DmJDBKcqfEg5
         n7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=01l/+dDoqva9GexUKYv93lK+e9emHYRbStT6DrBJ0NY=;
        b=BmEnoP4mfWX0kD3l0vn4PuWegH9OVenTh8WE/P9WGpxcgAV/OQ05J758wt+BZdxkTy
         DgpzFx4Wrd1dAJs6li2aeik8O0Vw4X4EvrM2+lkZSprwHVz6AFBLkPcNcdSwB2J9pTtd
         AOOJJIGrCxucrCgBaiZGbLRHluwYds+n74glHyMTIotIxskPmRT4ZgufTkQVT/1eB4hG
         SywMj/XHWVFO+mrjsKXUR3lBAZp6cTlyPRJeLYdosiCK+4efeG24+clAmN1pkL/ifzu5
         B9ZUtjwM8K3ZybYXInO4iLE8HsBE0CUg4dhimsvXdOZIKDlT6INBfSBxXYSZKaKd3udZ
         TqoA==
X-Gm-Message-State: AOUpUlEFW8gQ2PnZfCM8nBZ6j9oBycC7s4nypGzKbCaHAOccwGwlPDyi
        B9wqbXXhPdwqCujL+cfjV31VawJ7
X-Google-Smtp-Source: AAOMgpccnKoNT0EIo6oSJr//PlctekH2KDFHzoJdW2Nrj5LcML5JlcG6fbZVp4Kzigt7OWx2LLbQhA==
X-Received: by 2002:a17:902:864b:: with SMTP id y11-v6mr7207490plt.335.1532210700847;
        Sat, 21 Jul 2018 15:05:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id x4-v6sm7312592pfm.119.2018.07.21.15.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:00 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:00 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:32 GMT
Message-Id: <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Thomas Rast via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/21] range-diff: add tests
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
light touch-ups to account for the command now being names `git
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

