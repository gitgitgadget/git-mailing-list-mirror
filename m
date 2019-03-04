Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED22920248
	for <e@80x24.org>; Mon,  4 Mar 2019 13:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCDNrJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 08:47:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33368 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCDNrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 08:47:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so4301923edb.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5GferabSPQVP91IvmVjg3E33+QypffsDtysJN//A69Y=;
        b=XYJbQ/o79iQj1CzpfW+5wykLtnMRAT8j5jWAX0vcKUA6rlQr1bnQf55XC6uWlla/yF
         Nv3nSevewBSubXzYRbrl0xrFBgIIJ8CvenJABY9tAyAkggL5/5r1SkBFzupvbsrCOZB1
         DWaFpTqgJc/CE/us96zjjwM4voCrGbrOraIp/nOWuGkEpCnRmVOSo6VW5z/K0cXRT/i0
         rNMYDHG40laUPlRbKt4bcEScgFUPZTnm12sL6ZGm2VLQJQYfDl/l5sS57krCiDsizEjE
         LucDU0bgxLwv6UWDegxiI4zDS+ZRjgo/PQDg0TvVVJQtoRaaazPpxhKgYHV1fGD1lEsO
         326g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5GferabSPQVP91IvmVjg3E33+QypffsDtysJN//A69Y=;
        b=Ina0cCIpqkW/lJ4HydyzYWGrkicQCk9T7zj4w/EboxX0gbZjVJNJM3gqlGbcdsfsdy
         uZotGj3gRl+bCdgVoHrRr7YAqPMtTmYYJcqAsAZHVQygYjr3Mfd76pXAtva0e+dVcOgD
         7Y2o4LMYLz3oTnSd+D/sSuLsVkS45ycoBt28n9xIUjYfu+VYKS1C+PPJO6FkjZSJAuhI
         1gkh2G0lAAaXWAA4wL0vRCA1mQLN4sPjRWpb/FOK/8rQIHBVNgXhBidphBZXzPx8kLoJ
         UxMM5uA0ndBJOpiDgBLiEsNdOyVtn5NDOVEsOj1aw0aFYzSzIlWg/qKUjfG76ZVWebKX
         Wl9A==
X-Gm-Message-State: APjAAAWc1Jvjk8qDVK9dRCnLx5Z3p0LlLcsT7Tk7unH9PpXNaEItLfzI
        h+tJd5gzYnZ6YWyKB6zdTILpoU9m
X-Google-Smtp-Source: APXvYqxxtjp2/KRWHAmeAbATYKeGcNDtxiN8YDFFIg3p6QUweUmTTlwyS28q/YHX9GCgpYSqy/xWJQ==
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr12557285ejg.20.1551707227331;
        Mon, 04 Mar 2019 05:47:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q24sm2093958edg.20.2019.03.04.05.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:47:06 -0800 (PST)
Date:   Mon, 04 Mar 2019 05:47:06 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 13:47:05 GMT
Message-Id: <cb253bd0cf2896cf31516079a89ec2dab21032cf.1551707225.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.130.v2.git.gitgitgadget@gmail.com>
References: <pull.130.git.gitgitgadget@gmail.com>
        <pull.130.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] Makefile: use `git ls-files` to list header files, if
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
in `LIB_H`, as it is a generated file, not a tracked one, but that is
easily worked around. Of the three sites that use `LIB_H`, two
(`LOCALIZED_C` and `CHK_HDRS`) already handle generated headers
separately. In the third, the computed-dependency fallback, we can just
add in a reference to $(GENERATED_H).

Likewise, we no longer include not-yet-tracked header files in `LIB_H`.

Given the speed improvements, these consequences seem a comparably small
price to pay.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..0c4712cb48 100644
--- a/Makefile
+++ b/Makefile
@@ -841,7 +841,8 @@ VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += command-list.h
 
-LIB_H = $(shell $(FIND) . \
+LIB_H := $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
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
