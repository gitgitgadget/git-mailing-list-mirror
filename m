Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36061F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfKDT0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40889 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfKDT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id o28so18443648wro.7
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8/QQnWrMUphajhIZPrh/mbYR4R07eK3whF3MzpdLJSg=;
        b=dOOznIJ+Ac1W+QFIonYceFSb8ORygdLGOM6F3hZWDTMDDfBS0YIc496kC+vj06dbQL
         yC3QeekhoZMPVTeV9wj0Sswvs9uyk0hS9JdqrbvW+5Yve0yKFZ6b6MoO+9bNHEOA5HV6
         PlKBgDoBin1tnb91eRLlZJW3ttDNLvF7vJGhrSi4IqQRv9jWifqSQC0vFM8i30Uy5aLo
         r8ET+2O/Rir6UZiDl40DrCch68rhXMU1nmoKnI6B7IVBrCbJVrdMiQBIYfvZrAyTC+Pn
         PSEoBt4vriAz8BpPXrDtGZBLIsCeHcHt5NbxwqrxeB0TIu+DVgPVJM3fb6mOfB7BjsDv
         fySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8/QQnWrMUphajhIZPrh/mbYR4R07eK3whF3MzpdLJSg=;
        b=Qx1ecNmCnXjL27mKiLuJDQc90RwTALuq/v0gy1w+oiKf3m91y3Qq84nfxdoIgCIDPU
         gXtZ+PZpo9/nM/15+qF76L2LgYnLJ5xE2/rn5NBzjrFcXR3Afc7/9rVHar+Ja26aSMOd
         Z8OYbZ9Hjr88V5dJ7sPmBijCg0hj0fTY5UapJhIc0lzsKMiuWSqP20ByQTL+sCkUy2gf
         NxXfASVP17Tfg44XEwc1dnZQB2x3miRtp78OdrogsioI5ttbd0e5SbrDDDvX3mzegOoa
         jpJMNR+knvJqJ5F3BXT4ZE/dCQs7VDP1LzsG4v/VfP7WH+vYqxdRtVTGPhJeXjGt7NRR
         1sZA==
X-Gm-Message-State: APjAAAVFW4aqgY0vuCtQZmjmtRcd80pl/tiUPrXHD7TxMwBVCMXblh6A
        7k8+8jtcNdXDfFMgI/9RaoFnlklv
X-Google-Smtp-Source: APXvYqx1NgndSHBuEaJ6Q6+SJFJER7IYcADgNEo7HfMKxrM4aWLq5k/9olPVKOPEkOEGNZTmIfQbAg==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr24429952wrv.119.1572895609142;
        Mon, 04 Nov 2019 11:26:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm7963394wrq.72.2019.11.04.11.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:48 -0800 (PST)
Message-Id: <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:44 +0000
Subject: [PATCH 4/5] doc: commit: unify <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Synchronize it to `git add`, which has a pretty good description.
This also better disambiguates <file>... header.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..4341d0e3ab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
+	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -345,12 +345,15 @@ changes to tracked files.
 \--::
 	Do not interpret any more arguments as options.
 
-<file>...::
+<pathspec>...::
 	When files are given on the command line, the command
 	commits the contents of the named files, without
 	recording the changes already staged.  The contents of
 	these files are also staged for the next commit on top
 	of what have been staged before.
++
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
 
 :git-commit: 1
 include::date-formats.txt[]
-- 
gitgitgadget

