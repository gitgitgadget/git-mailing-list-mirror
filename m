Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BAA1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfA3U52 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38429 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbfA3U41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so802101ede.5
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=BpYmJf+ZfN/S0HQpiucOcCqXgoeL3vtzxFc1xwJglGYqZ7QJHrPyFnxcE7XxsSNrAi
         kZhEs2TOuit0SOqkjHOTv7P7rtTrBq2t2ulP4hfxjufccTdFyMak5ivftzJp/mxJSJZh
         BhWoE8H60imavGUhuX9SxhszTkknFsb8XRCr7USGFLxeG31+ObRgLwsAbu1Te7MicZ/R
         69aCdcOl920rs7eiP+wFJvCxUzTBqtiXhZeGtdSQZUFpLkx0gwdINHzgUV33PpB6ooYO
         JcDJxr1YNH0lNRtJJzSVrBj66HxShFkUfD+HJZNNPD1RJHTYMh/6XPC5h/WZXFLl3ysw
         1dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=AvgVhb2IPtM/Xh+8MAz5MQlkDetCLGxc1BEveA4tEeWRjZ+mXkUMhENp1JnWPcPMqu
         yD0Ja4GkGCIrVlzF0e2CLWttUwTctyS/8+TbL/2hqoezUYPgufi1CW0FkFxH1+mWBOFA
         wIdaxkgjqGH+n5Lk50MlHtdphWUNN55ukTQ5JiRvApuz7pfnrjqycR1B8bHLONvfcOdf
         iOfVVdbb/SdQjax7BkLLjE8smxAf9fkAA80ZJG5ooqHy2CveduppBu69NnIjBfJzOu/Y
         2UFW8zCBLRg6ta0SCXekErNia5zT3B6XLNrtwjVl+dIeZd7liauDXyX0yF5WGRZN/iQQ
         gGBQ==
X-Gm-Message-State: AJcUukdSE6CK+qBXgLhwbFOq2zl9IamIKRQJKlj7VRuPRhFf8LkF4hMh
        w93BKfYz9wuJ44btS/b7JeDEYP57
X-Google-Smtp-Source: ALg8bN6uVZtdAJB2msU6to+h3l0q03a0UgnUzVIfLmdxd7XCHx9XCLYQh+hePP4I9cYR6jIuS5eRQg==
X-Received: by 2002:a17:906:4545:: with SMTP id s5mr26769013ejq.107.1548881785271;
        Wed, 30 Jan 2019 12:56:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm473110ejs.68.2019.01.30.12.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:24 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:24 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:09 GMT
Message-Id: <3624c6cbd914f13cabca7c94a10f9512a883d1e1.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/14] trace2:data: add trace2 regions to wt-status
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

