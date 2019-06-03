Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02791F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfFCUS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40745 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfFCUSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so27588057edo.7
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HFC9/i6a4bKxfAGC539ovO2CdF/OPBkFYJfuCD6yPxc=;
        b=rQTdlX72Y6hdVEvY2a/OfnLI8RpugNT8nEePSCU6ObuKq/zuSlH3xGb8P2umbbt+qC
         Ciq5TFpQvUmnulm9M7GFFZCq1zPXsqgVP2icoJ2u6UQ84efHKXbInuNb6uiP3eCSXSU5
         FbfMm5lMm+GCJWycN9wSm+qklVSzoQU4kOjvtdD1NfeoDbjLaVT+hKqoFhUrxBayCSCO
         XJiw97Q6C8rq5KusnMnK8rXIX+9uUFbEKjv6n1Kw9wCf3w9YQ70UXH/zwxWp3fTMKr1r
         aZrpYhvsG56LqijYYrD4HUUY32oIf2/wB/Z5zQNdAG29rb/kaC3n4Rkh4gzhLOamvLJa
         ICDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HFC9/i6a4bKxfAGC539ovO2CdF/OPBkFYJfuCD6yPxc=;
        b=Xo/mVR5fr2hK+dvOM/OUEIt4AOgYog/5Qpp3n6wkbXw2DY7Pxo8FB4b5UUji1Kp4en
         5/IxYnsHrms53NYJraPkffFJBUKxU4Z4FSxGv1/hq/jpKd7aBAE7/qjXKH/X0fJ0rxES
         QhEPhU7wCb7AO/W+n+9Axc6EOQKACrgL7mcMFaxM/OSQEvlnGKTtZKEtQAoQpnSAm7T2
         7+vUxmwO4DyqUNuky98cvhYi/GXqFvOdl3NSHnM3EqBKCAZFiwSvqvim1qak91/oim8q
         zlYTrgoxj2hBN++cHCQKajZRWtk15wUJeuuQaxznVBeXmO2sG++3N4elql9RdXZEzZUH
         pQmw==
X-Gm-Message-State: APjAAAWit/b9BtjCpgBOJN7TyVe86Ai93pWBPF3YNHIA+tSTgNFT7TAC
        s5vrEEvu80Be0PEt72xq4y8plJAa
X-Google-Smtp-Source: APXvYqz0cP3xOkbQ2xlR4kqllDn0LGl2XTn0ifCpA2dT1sUnL9GI3pKdhgVox0Ew+wXOzzNvp/RFAA==
X-Received: by 2002:a50:b665:: with SMTP id c34mr32341112ede.148.1559593102723;
        Mon, 03 Jun 2019 13:18:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm2750640eju.25.2019.06.03.13.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:22 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:22 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:11 GMT
Message-Id: <d2e5cf185711385643999493fcfbcf03afe13e34.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/11] status: add warning when a/b calculation takes too long
 for long/normal format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 advice.c    |  2 ++
 advice.h    |  1 +
 wt-status.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/advice.c b/advice.c
index ce5f374ecd..54f8dea30c 100644
--- a/advice.c
+++ b/advice.c
@@ -12,6 +12,7 @@ int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
+int advice_status_ahead_behind_warning = 1;
 int advice_commit_before_merge = 1;
 int advice_reset_quiet_warning = 1;
 int advice_resolve_conflict = 1;
@@ -68,6 +69,7 @@ static struct {
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
+	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
 	{ "resetQuiet", &advice_reset_quiet_warning },
 	{ "resolveConflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index e50f02cdfe..c86de9b9b8 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
 extern int advice_status_hints;
 extern int advice_status_u_option;
+extern int advice_status_ahead_behind_warning;
 extern int advice_commit_before_merge;
 extern int advice_reset_quiet_warning;
 extern int advice_resolve_conflict;
diff --git a/wt-status.c b/wt-status.c
index d2a1bec226..c94d43879a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -19,6 +19,8 @@
 #include "lockfile.h"
 #include "sequencer.h"
 
+#define AB_DELAY_WARNING_IN_MS (2 * 1000)
+
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
 
@@ -1085,14 +1087,29 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	struct branch *branch;
 	char comment_line_string[3];
 	int i;
+	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
 	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
 	branch = branch_get(branch_name);
+
+	t_begin = getnanotime();
+
 	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
 		return;
 
+	if (advice_status_ahead_behind_warning &&
+	    s->ahead_behind_flags == AHEAD_BEHIND_FULL) {
+		uint64_t t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+		if (t_delta_in_ms > AB_DELAY_WARNING_IN_MS) {
+			strbuf_addf(&sb, _("\n"
+					   "It took %.2f seconds to compute the branch ahead/behind values.\n"
+					   "You can use '--no-ahead-behind' to avoid this.\n"),
+				    t_delta_in_ms / 1000.0);
+		}
+	}
+
 	i = 0;
 	if (s->display_comment_prefix) {
 		comment_line_string[i++] = comment_line_char;
-- 
gitgitgadget

