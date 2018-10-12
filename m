Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915941F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJLUqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:46:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLUqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:46:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so6199634pfg.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4/UGQ/7mythW0rZr0mU9g6mUu2AWRRZi03i+4TrW1kU=;
        b=KxwJ6LA761tMsy9zeiISDNJt/TGG9f6qSLpLjPxPTtw3mit3fj9il4e7fG5e6iMz4k
         Lu3+38IoS+qUd5Jl50oEhQm0je7V8e0uJqUq2DxHnYPnHxMuU2m53X84CPrPMZPVuDoj
         MoNTiUC4WFrLc793LxDexlI2+eA2FJXxaGR+5s+vdPgVyAtjGBnexHQiDEXsZABhy+bs
         Pjm5g/eAGcYEseJfYKvBTMydOw+NhA0UxFJ9739qixWGy+tfc4rRbV/Ik8i4Fi6tPcWn
         xoiDg7rRBh1HwS14jZr7+eOgH+qg256AAT4aErPv9VTqNcoEgjBr7SHNDquzyqAQpBLn
         3YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4/UGQ/7mythW0rZr0mU9g6mUu2AWRRZi03i+4TrW1kU=;
        b=MNy3nSFCncibEpCCYnPwBej2L0/rvC3dKqMtWRrIyrHLiZKdevvulIAklJT7/xs2kk
         IrGimHO6K7c1V8GrupqDbqHGXqieMVluPCUSaZdXU7dAoRlKgll2LtRSW491QK8utyyM
         hldEzyGHOEVTiCkyneIK8X0gjnfyJkWYyLzlN3XRE374eSsQ+qMvVvFgKeOKjCf6ZLL4
         kh6QEEKNMxM9ZXaLlyxG03LzfBetifSjcMG9NbF/FmaE7dpA4t2g/zBspx3wynQMzP7I
         wYOI7kQNf/mVg9kw48+G3KinVlc/k0I1qI+xLWcoW1mEMWTUBX6sQtHbp7lB/GAm4KM6
         mX+A==
X-Gm-Message-State: ABuFfoh+BYuHUnxZfxm8Zv7o9AqG4ovORiah8TT8Epl1oeWE4qWdqbHQ
        L9iuVSlETAsH2UdJITAMarLPHG5m
X-Google-Smtp-Source: ACcGV63jwHmHR3aW8ZxjfFJm1SCEoMlj2ruYHitt1HOUVWU62HbhWv+Cy7laycVubHQMBzD0ue2InA==
X-Received: by 2002:a63:6c84:: with SMTP id h126-v6mr5537524pgc.237.1539350065833;
        Fri, 12 Oct 2018 06:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c79-v6sm2521201pfc.92.2018.10.12.06.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 06:14:24 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:14:24 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 13:14:20 GMT
Message-Id: <92512a82d27b57dedf9dc9423dfac2efcb229031.1539350061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.v3.git.gitgitgadget@gmail.com>
References: <pull.43.v2.git.gitgitgadget@gmail.com>
        <pull.43.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/2] rebase -i: clarify what happens on a failed `exec`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We had not documented previously what happens when an `exec` command in
an interactive rebase fails. Now we do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 091eb53faa..d9771bd25b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
 --exec <cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
-	commands.
+	commands. Any command that fails will interrupt the rebase,
+	with exit code 1.
 +
 You may execute several commands by either using one instance of `--exec`
 with several commands:
-- 
gitgitgadget

