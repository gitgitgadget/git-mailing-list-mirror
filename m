Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E6B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 12:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbeF2MQR (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 08:16:17 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:41953 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeF2MQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 08:16:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id a11-v6so4149503pff.8
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=1UwZ0OeRnzkrQ+D8AkX8pHDegXoJkn0akj78i56cX4s=;
        b=PQNhjyfTiyXeQoyANwsFEXIzYT4WnG7m6oi+QAszwuLgSGYwbTjL+bDYGmvJxG5ZFS
         iGq7duDCOmpBgAyWh4fA4AtBdYPQMRsWlypPYaO51woyL19FsRNXaDPOfpUrVpGkA78J
         9U7IKdeZ01VIdmS4ecvYrab2deZ8Gg2KVhnEbAbsarpqdusxKN0GKQlogX2wBVvcSOXU
         ztVwddWHqatK/t3nvbs/4qJ+CD3NRJlna0JoqGjpA7onCpJNlbgt9xqnS/ykyHsD8nHO
         NY/4N4hdEKXVihEEP8qG62QEVTrbJUvVugrTp3GJy+DGu71ucNSEqZDXTVEkEdhMO0KB
         +l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=1UwZ0OeRnzkrQ+D8AkX8pHDegXoJkn0akj78i56cX4s=;
        b=B9mX0yMD+GvzkTzz0M3dw1PMrfRRr+EKBp3uYOz4fLBbTYu3QDaHbaatdwmjAMt+zn
         FpMHmmRJCYyPJkOAg3uaMrok4eaP0MhtwNonLUxqjEPnGribkiL3sHRC8qpoKoduGOcy
         5VOCTJxDgi9O79YlEvsTC98kxMEcUgCcoaRe8XY1uC9B2Hyp0AXt1TluDsl6eG9122TE
         CvVAZlTLOFT0cRRseubR1so7CGqLOD1VYsDzxozdiUT1JLbu8mOJpJxjSBxkA8crLzyQ
         DNa8KHqh4JS+4M7Ab/UIsfmVIXOEjDwPRLBVSKeDQSks3fVnsr5oA0nuF8fzAP1ULrw5
         Pa2g==
X-Gm-Message-State: APt69E1uNjrfk3YIhmImE/MUyUEDyp/PTMozF4Tv4YyqyLGa/jsU/roD
        mtqpVktPPtOQ1pVSCsPNGdldBg==
X-Google-Smtp-Source: AAOMgpc2KSXkrd8D2/oTpQ5Bml/MK1CL6uIEUnfvecDXBpH50a5d7EIoPpLJMgpKHpIbP8K2ylfaXw==
X-Received: by 2002:a62:8d16:: with SMTP id z22-v6mr682836pfd.181.1530274575211;
        Fri, 29 Jun 2018 05:16:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b69-v6sm957316pfd.33.2018.06.29.05.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 05:16:14 -0700 (PDT)
Message-Id: <aca087479b35cbcbd7c84c7ca3bcf556133d0548.1530274571.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.7.v2.git.gitgitgadget@gmail.com>
References: <pull.7.git.gitgitgadget@gmail.com>
        <pull.7.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jun 2018 21:35:23 +0200
Subject: [PATCH v2 1/1] Makefile: fix the "built from commit" code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In ed32b788c06 (version --build-options: report commit, too, if
possible, 2017-12-15), we introduced code to let `git version
--build-options` report the current commit from which the binaries were
built, if any.

To prevent erroneous commits from being reported (e.g. when unpacking
Git's source code from a .tar.gz file into a subdirectory of a different
Git project, as e.g. git_osx_installer does), we painstakingly set
GIT_CEILING_DIRECTORIES when trying to determine the current commit.

Except that we got the quoting wrong, and that variable therefore does
not have the desired effect.

The issue is that the $(shell) is resolved before the output is stuffed
into the command-line with -DGIT_BUILT_FROM_COMMIT, and therefore is
*not* inside quotes. And thus backslashing the quotes is wrong, as the
quote gets literally inserted into the CEILING_DIRECTORIES variable.

Let's fix that quoting, and while at it, also suppress the unhelpful
message

fatal: not a git repository (or any of the parent directories): .git

that gets printed to stderr if no current commit could be determined,
and might scare the occasional developer who simply tries to build Git
from scratch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0cb6590f2..c70f823a0 100644
--- a/Makefile
+++ b/Makefile
@@ -2021,8 +2021,9 @@ version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
 	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
-	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
-		git rev-parse -q --verify HEAD || :)"'
+	'-DGIT_BUILT_FROM_COMMIT="$(shell \
+		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
+		git rev-parse -q --verify HEAD 2>/dev/null)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
-- 
gitgitgadget
