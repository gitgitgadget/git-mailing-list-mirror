Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045221F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfBFRP7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:15:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39081 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfBFRP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:15:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so6529558edt.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=mEHNiSAd7dyNB8Y4RpEhXPYgGB1PiYW5LCz9jHGOtYT4BAz/QhlJlG5nv4/kXoCk0k
         wa5B5q7rtvplg2aKy7o2vRaFgYe75Ffnvm+7+QJs9U1HzGxXDfAeBIq9pDNZ5dX1RQQq
         oASMzoISydlPstMrLI2Zgi8q92/OyPkQJPMCsP8s6bQ1UEEKDgxhgQOJ0PIjLY0CgZLh
         nSUuJ3mN+pvF9YXoMb9plOxGyPEWLTOP3Dh/fWKXvvh3XWKGlbChWKmTtcSgw4Yg/D8E
         oSyu5QGgYSXfGizcBnczTpedR5cbnHENVPvR8RBJEiTdNDz1N7Vv3OVlpReavBg/FRH2
         pTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=odsIM+qy2D1s0MdbhzWY1gPRCQLlT3UMQrhcw8ineV0DCMcAXosalKvG736kaHXT7e
         hyaisAEvQdp3Py/XYRXz3OthiuAFbkavXsOW/Gc1H98NnwyFsb9ztzvH0hOs3ZYKKsSZ
         ofFjzNranXBWgZjG/M2Ue7KanrUVGIG+rrEUuVh0lxlybsDD27OMJb5ceRPFURTYy5RO
         loYb1mclZnHiQC4nAzgKOMGtcrDiCvjdlsdoPpqNIhMT0gOQ+6Cf6Zdh/XwXkwQv/caB
         +cObrvOeP4dqlioR2Feh3ivqyoeZldOIlibSgKAqgyQMVpp+bVBiQLvk5y+15PADrZze
         uuWQ==
X-Gm-Message-State: AHQUAuZlQ34fqLEkUZ1EapCVmKSjn2yW9pi0E5s/seGxp5OAhu3AVOjM
        5aD/ZhR4syxfDCxtlKIxH7gASKdC
X-Google-Smtp-Source: AHgI3IYRVW87weOvR8zlFjkND+rfvzRzHHmHAVifV+lZD39XuRRKJnCO4JY70aCJG83VUYTTLZFDfg==
X-Received: by 2002:a50:de49:: with SMTP id a9mr9157142edl.18.1549473357055;
        Wed, 06 Feb 2019 09:15:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b43sm1393865edf.54.2019.02.06.09.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:15:56 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:15:56 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:39 GMT
Message-Id: <5835edbd014b126f07c0931615dc63073744aa66.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 04/15] trace2:data: add trace2 regions to wt-status
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

