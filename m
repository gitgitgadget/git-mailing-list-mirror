Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC5B1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfA1VsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:48:05 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39877 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfA1Vrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:47 -0500
Received: by mail-ed1-f49.google.com with SMTP id b14so14347145edt.6
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B57zKY0tVpm0sPzJeIH5jILjY5u/zvtFyxc81Xdjcq8=;
        b=iNChmGm+NyNtT4IDRQMYMQMiSK4i2bpROzcSkppQtdErcoyUgeFKxUtV8J1EW7pMpe
         j+BMY+sMfXlbS+/YoeigJPXS056hQxA452QpJqxJr50nabm51kyO0Xgp8dsU3ClSI0Pb
         Hrvgj4d+AS+MrU6gANmu3aUHbHpD/bW8icE2Vn7cd89jSC/9VydJl1LpT11bt3KRNlOA
         n4D6HI29+2uI7GugIp7EvL+R146LoAGWMejCta6TI3plbsBrO8JovGKNCSXkDqHPg4IM
         ibgYQ1oVC5xEZPnvgH7S9V70GHaNj9xAsmXAYYoiaHgu58aEeWtDRYgMIsDmfFjvAb0+
         qLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B57zKY0tVpm0sPzJeIH5jILjY5u/zvtFyxc81Xdjcq8=;
        b=cXl7/aYmxVDMs68mqgZIPWw0eH75fOB2+9N193kDDtyChcl4iN8WtEPhmV/qQt1YUl
         zGiBg9oIonMO+8QrA7kZWkGF0pKb0hKgW0372kT2Mg1Z04D9boE8TwW1cpInA2cMQ/4a
         aUmnJoC1PzGdnNxB1fDzNUOX1kyJyV1DDWpZt5UBEvY0wGzx0+FgtPaEKhbqjTqbfnFi
         mnFgberu/aqJ0Gzm2Wkp6GmhsjotCrk+ScRTWtt7X0wf8oyIohKjmZkWJlrvNYwXMs8e
         wmKlgweYxjAXaNMj921QZprusk9bk7N1LjRnYXetMuR6ixi7sh3NAN9nXTEKegByEaFS
         iU2A==
X-Gm-Message-State: AJcUukdbqHll/fsM6XIjMB2/2Pbaad+UpWRIYb1tEr7vPM36SZRvhU40
        5gQLfgRY3jmDwka2mxYHGXyB8gyO
X-Google-Smtp-Source: ALg8bN5G+kic/4Fsqjmbbm5jgSQASWA93aP0h5DybeLc0PCNZ2iqEoQtu2FB0A8+LKTu0K930a+Nkw==
X-Received: by 2002:a17:906:76cb:: with SMTP id q11mr20427454ejn.49.1548712064892;
        Mon, 28 Jan 2019 13:47:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm14292153edc.63.2019.01.28.13.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:44 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:44 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:29 GMT
Message-Id: <f9d689a54b8f797ab598fe0fb8d2a2182620beb1.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/14] trace2:data: add trace2 regions to wt-status
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
 wt-status.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..7c5ba4e902 100644
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
@@ -2291,6 +2302,12 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
+	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
+	trace2_data_intmax("status", s->repo, "count/untracked", s->untracked.nr);
+	trace2_data_intmax("status", s->repo, "count/ignored", s->ignored.nr);
+
+	trace2_region_enter("status", "print", s->repo);
+
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
@@ -2309,6 +2326,8 @@ void wt_status_print(struct wt_status *s)
 		wt_longstatus_print(s);
 		break;
 	}
+
+	trace2_region_leave("status", "print", s->repo);
 }
 
 /**
-- 
gitgitgadget

