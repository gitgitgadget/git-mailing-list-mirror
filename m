Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D5F202AA
	for <e@80x24.org>; Fri,  1 Mar 2019 19:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfCAT5t (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 14:57:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35555 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCAT5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 14:57:49 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so21029827edp.2
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p+OJFHUuRrf7WlpsrX71CECDAXEOMKgWDtLAm5g0WB8=;
        b=tOofxTwunXl8hc8UAK0YqfWS7zXkEEBa/U5O/A6CTFKFvFfsKe3XWFyxRpAec9bxQt
         cJWmHv/tq1dzR91OlxnlE9wPD7YTLmZW7gRjjj0UgFbRuFMTcl4vRGiA6HrwGrlsJMsS
         i4XTY03bkv2VhaNETOk/gb3eqvvQSQQpcAyJwgSVrNnpOOI8ml9FLBOVwm1h9TMAvOgR
         t1YPRAUA5LLRF29idiXLhoj/CLMIclrxM+szVK3+So+47THYbfV9LWsgzHcyucz1MTGb
         9TWCEAtmL4midPuQ/XnUeO9n/5dt2molFDelam3/QYOfrQbZAOwEfztUoYPL4fvoevD3
         vivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p+OJFHUuRrf7WlpsrX71CECDAXEOMKgWDtLAm5g0WB8=;
        b=GAhSL1UMwdvmtiLbsB3MFfa1FezDzdVX98qfEJ9B6U6vNNEzffnj/O2HXOR1xptKtF
         v4uxy/3bFjkzAQjnO8OKLgseOa6QRYqtM9fdqTwTVu7CjynG/7oHiVhP0gFSHVcEg0ik
         odv5OujsXIOT+z2ddYF0YyZfbBO0nb9Qad7tZZWxORKpvGydl2l3PpikqtpWb42S9PtA
         Yr+HJja8gaEc89kngyAdw6hdCOuMIFv7wxkZmtjFFqsxjeXDj3kRLK8o/NneE3Ncq8M8
         7jKp6EGdcxQvgPczogSKSRAoGkXbw1aKTBxa2+a3LKhqk6zG0dKRSDsjDl/zO834ocLX
         VsmQ==
X-Gm-Message-State: APjAAAUkBx9Qw4Cv12ZSp5oIZ/DQdAIdAb9B/0I17JxCzWHtZIyIXkQF
        gRRyA4DrjBm41JnX9/L3h9eje04V
X-Google-Smtp-Source: APXvYqyl13eBmEKrz/qBieVa3eNoSjy22JDvMFXRSx61VdaeIDGFKJdTGF1RPk8uGqrAoVOEhVbk+A==
X-Received: by 2002:a17:906:5a19:: with SMTP id p25mr4208318ejq.169.1551470266848;
        Fri, 01 Mar 2019 11:57:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12sm6333756edb.3.2019.03.01.11.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 11:57:46 -0800 (PST)
Date:   Fri, 01 Mar 2019 11:57:46 -0800 (PST)
X-Google-Original-Date: Fri, 01 Mar 2019 19:57:45 GMT
Message-Id: <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.130.git.gitgitgadget@gmail.com>
References: <pull.130.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if
 possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d85b0dff72 (Makefile: use `find` to determine static header
dependencies, 2014-08-25), we switched from a static list of header
files to a dynamically-generated one, asking `find` to enumerate them.

Back in those days, we did not use `$(LIB_H)` by default, and many a
`make` implementation seems smart enough not to run that `find` command
in that case, so it was deemed okay to run `find` for special targets
requiring this macro.

However, as of ebb7baf02f (Makefile: add a hdr-check target,
2018-09-19), $(LIB_H) is part of a global rule and therefore must be
expanded. Meaning: this `find` command has to be run upon every
`make` invocation. In the presence of many a worktree, this can tax the
developers' patience quite a bit.

Even in the absence of worktrees or other untracked files and
directories, the cost of I/O to generate that list of header files is
simply a lot larger than a simple `git ls-files` call.

Therefore, just like in 335339758c (Makefile: ask "ls-files" to list
source files if available, 2011-10-18), we now prefer to use `git
ls-files` to enumerate the header files to enumerating them via `find`,
falling back to the latter if the former failed (which would be the case
e.g. in a worktree that was extracted from a source .tar file rather
than from a clone of Git's sources).

This has one notable consequence: we no longer include `command-list.h`
in `LIB_H`, as it is a generated file, not a tracked one.

Likewise, we no longer include not-yet-tracked header files in `LIB_H`.

Given the speed improvements, these consequences seem a comparably small
price to pay.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..2644324915 100644
--- a/Makefile
+++ b/Makefile
@@ -841,7 +841,8 @@ VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += command-list.h
 
-LIB_H = $(shell $(FIND) . \
+LIB_H = $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
+	$(FIND) . \
 	-name .git -prune -o \
 	-name t -prune -o \
 	-name Documentation -prune -o \
@@ -2363,7 +2364,7 @@ else
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
-$(OBJECTS): $(LIB_H)
+$(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
 exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
-- 
gitgitgadget
