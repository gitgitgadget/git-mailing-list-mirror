Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0941F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfARPJb (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:09:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36336 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARPJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:09:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so11394189edb.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EguGS/Ij6ZWIXe+6jbCGARauW7KnnwKr0BDH5wbiM3A=;
        b=Ureo0Gc7Vo9o9peMkn04hzseLDaZT1NvJSfNjfluXGyyFZ+f84xPKVB+I1MGpKTAcT
         H/jIzh71mDqKusvE2gkCgIA6uF4A+6syAwNHPewDkMFe/dQ3jGVZFZLO+WyVycyc1FoA
         vmHj6AGEZksRvqAKWI1X8/KGs/1D1PRltTjKuhkLZC16AdzfhElhkoA2aqBK2KcWPVRU
         kmSah6SAeRbONa9n1t+8BEZp7uLsMxnXwkj7jZkgpqndQDX+mqgqFpZe79qYseRYpzsG
         nEpEYPyHHHQxDjiNJqRWPZ/8byVbuF29oWT/bn1M4vTmtVzEovzaaVvjWeYf4ImcjRsa
         bEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EguGS/Ij6ZWIXe+6jbCGARauW7KnnwKr0BDH5wbiM3A=;
        b=JbqDz3N7OVuHbiVurw1AbSL787KLOZ3/Pk9MSlt1LWKzIhmcFSgXz0AblFl4Dwx3vB
         j5Q2Uwm6G1NI9ZFgyJuteyjXyiG03OsHK+Fv5FlsDEaz4vrC4VRlbw3G7/Ia79HWasUd
         gkb9GA7o8ThxHBx5XyvlTByumjXV5GNdDUfFcpmbe401nWSzY9LjSGuyBywWQ+Ix8Lc+
         qV+lxzo4CpuWAyjntTmQVXMOsn1yc3tGM80CX9g7u6kR2d7HDYnIFZfdY45eaeAplHDp
         nGsr+/+NfajOe69NdIVHnY5OVhe+l506FtAQvn727Yt7OVAR5hOfGduytbiGNRY43zpi
         wshw==
X-Gm-Message-State: AJcUukdsL+gDZwd0td2hSJrINXGKoTe90ABmQfVMHWOy0XrW/YonnBwO
        4IVYU3OWsJfbBiaBblZO1FMIwr6+
X-Google-Smtp-Source: ALg8bN679SBXpgq9D5UVFMg60ZNLyhF2j2AOsqnJse0cO/4vJygiuq+UH/EDLaSFHo+ngUrfbyL8Zw==
X-Received: by 2002:a17:906:6085:: with SMTP id t5-v6mr15067630ejj.47.1547824167559;
        Fri, 18 Jan 2019 07:09:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b49sm7377261edb.73.2019.01.18.07.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:09:26 -0800 (PST)
Date:   Fri, 18 Jan 2019 07:09:26 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 15:09:21 GMT
Message-Id: <387071dcd77fde6ceef1daea623b4ae2e0e08166.1547824162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.v2.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/4] rebase: teach `reset_head()` to optionally skip the
 worktree
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

This is what the legacy (scripted) rebase does in
`move_to_original_branch`, and we will need this functionality in the
next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5c827b2f03..c65493a484 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -337,6 +337,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_REFS_ONLY (1<<2)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -344,6 +345,7 @@ static int reset_head(struct object_id *oid, const char *action,
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -359,7 +361,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -372,6 +374,9 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (!oid)
 		oid = &head_oid;
 
+	if (refs_only)
+		goto reset_head_refs;
+
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
@@ -412,6 +417,7 @@ static int reset_head(struct object_id *oid, const char *action,
 		goto leave_reset_head;
 	}
 
+reset_head_refs:
 	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
 	prefix_len = msg.len;
-- 
gitgitgadget

