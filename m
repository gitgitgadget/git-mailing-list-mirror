Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD501F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfBAR7G (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:06 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34917 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfBAR7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:05 -0500
Received: by mail-ed1-f41.google.com with SMTP id x30so6172302edx.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=K3fek57jCW4VgnzV/BHc5GjObxtb4/u1YMf0YTIYpKNNI/f+mrxPkCVn0joZ+jrJve
         K9bUr2wVanDJkl4EBCMlWntkdXJaq148w+QwwPIbkNcVoeUmRXj+8cVRcGfONef2+Fqp
         4pkZ9vpePpGwqbLlcdeongpkOLhTxSp8BgJ9pjD2b5Oe8a7+Lo+cpKDXYdkJXAOvS3IZ
         hkE1VG8GyZzmjP7XJi2vYSF6Qlapc4lEzcZEF+DAv4r3MHb4QthQ1Ko7uMuKuhzQhACx
         Y56UoZUNb/eZ9eB/dqELpIz97cUJ4QOkDTSCOFK6hDDx0Lsh1CXXcF5O6p468O9dZ1Ko
         Uh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=LyLUDC4GW+3v+/lJReHkz0+k3IRazZK3s/OKvjgThxAmPDb+INwTjfk518ZlETQlPX
         TIAl0FJwywric79xmJ95OjVcBEmeHnzbaCqlmhFd5sSEeKwoBo4PnVdp8Q3Gqf74QcO7
         LhQzesYNzWHnP/zYJg7qh210wq1zU3XSlt4ZMyQm9WCvy2uLgFeuynNG6V5+9A6QDgYr
         wkXLINP1Uhx66s0Llt+GCDxiIrx0wcklpX3y9uVyudTW8inlhlmhw5cBnewcRXPrq/bj
         9pdM5Jb29fgHwsvMrli9Gi/GFkhOC6ABP/dD2s06jfVemjyPKnlBubS3qrNs7yligvAT
         4Hvg==
X-Gm-Message-State: AHQUAuYD+2GRYxBe41IY+8kwDYEBE1GV/EvmiLwfT9XLI11zByaT/cve
        dJOpYbxhyzpuUmxTU1b6IeRU/xay
X-Google-Smtp-Source: AHgI3Iag3g0pc+dHK3f6/LBVM9Mww0FrPcIK0nNbIOjw5KkU2nVNFBMbsDd5dYB/Qk5igmHwp9Nt4A==
X-Received: by 2002:a17:906:5387:: with SMTP id g7mr10150083ejo.189.1549043942654;
        Fri, 01 Feb 2019 09:59:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm1351884eja.52.2019.02.01.09.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:02 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:02 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:45 GMT
Message-Id: <cd860799f88ba9832d7b15822dcc866a7395d697.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/15] trace2:data: add trace2 regions to wt-status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_region_enter() and trace2_region_leave() calls around the
various phases of a status scan.  This gives elapsed time for each
phase in the GIT_TR2_PERF and GIT_TR2_EVENT trace target.

Also, these Trace2 calls now use s->repo rather than the_repository.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..434636850e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -748,12 +748,23 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	trace2_region_enter("status", "worktrees", s->repo);
 	wt_status_collect_changes_worktree(s);
-	if (s->is_initial)
+	trace2_region_leave("status", "worktrees", s->repo);
+
+	if (s->is_initial) {
+		trace2_region_enter("status", "initial", s->repo);
 		wt_status_collect_changes_initial(s);
-	else
+		trace2_region_leave("status", "initial", s->repo);
+	} else {
+		trace2_region_enter("status", "index", s->repo);
 		wt_status_collect_changes_index(s);
+		trace2_region_leave("status", "index", s->repo);
+	}
+
+	trace2_region_enter("status", "untracked", s->repo);
 	wt_status_collect_untracked(s);
+	trace2_region_leave("status", "untracked", s->repo);
 
 	wt_status_get_state(s->repo, &s->state, s->branch && !strcmp(s->branch, "HEAD"));
 	if (s->state.merge_in_progress && !has_unmerged(s))
@@ -2291,6 +2302,13 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
+	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
+	trace2_data_intmax("status", s->repo, "count/untracked",
+			   s->untracked.nr);
+	trace2_data_intmax("status", s->repo, "count/ignored", s->ignored.nr);
+
+	trace2_region_enter("status", "print", s->repo);
+
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
@@ -2309,6 +2327,8 @@ void wt_status_print(struct wt_status *s)
 		wt_longstatus_print(s);
 		break;
 	}
+
+	trace2_region_leave("status", "print", s->repo);
 }
 
 /**
-- 
gitgitgadget

