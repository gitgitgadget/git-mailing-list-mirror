Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FA21F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfA3TvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:20 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:39302 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbfA3TvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:18 -0500
Received: by mail-ed1-f41.google.com with SMTP id b14so636774edt.6
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GyZVgyNIbyoM3H6tn3QkHgrYsfqFejCynW7wR5zlW6k=;
        b=Xo9wo8ZVSlYNQVhIyu08CX/C4YWHqmMu7ls+k5iFDeOyhHerCmmmSRqlL10YdMV4ky
         WfANbsNUlEtQ+J94+uQdaT+B84VgN3a1eHh6cz87tELFG97oCSwYhjozD6c87wmTDmd5
         Bb2Pi/MUj3oJbzYiq7gJ97mgPmDuBz26LUeEAbLWQiXXqC8yDnQlJJ4BNDs9gaRMp0RF
         dQXRAEMtEyn0Tl8oNIIg/tlUvuFbTJ8LEzMr3mtWeymYN0jkt0MphXzY4SMEr1UxnIGO
         7ZLBXbK+ZpGvwUe45S/5/FpRm/l0uj0VqfGZ2nHQm0Tt5kMeEqrLA2rPrJX/1HTlX64p
         jV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GyZVgyNIbyoM3H6tn3QkHgrYsfqFejCynW7wR5zlW6k=;
        b=S5GBjyHZ+5Ew3RHvNJmWUHpVZv4Fhi4GWgb9GqEooQOvNwwlHZC8yEXUJU8Nrap9Sg
         8qI30ecFjnsvBpm/eOsR8YSKfn0nHGhI044jeNXa4HxOxL53nrGYhoVbFo+OD9tvvGf4
         ymZ1mfUWXPP+1neOZMYizwK3okg1cR0d4a3xAFjh4H7tBM5J5Vg9/r/3uGfTU7KMLdAR
         d8sVheTCVrjKikyaLyHV6ogdHXRPIWmizR6ufV8G2+6TYYaVAtNsvzyQFbvB6gsZXr/A
         JSoG7nse0ccOEIdBJvChf8JBJgssUQ1IcAUe8cnkipjISVyKRXsAv2pk8dtryWnzWY7k
         U/3w==
X-Gm-Message-State: AJcUukdGtjHU5IAMpaCw2xt0PTCW8wLzbOTvTml5592gQtQWHRH0/Wcj
        X+4VAHUxAcv+1sTt0c72RR4WgmUL
X-Google-Smtp-Source: ALg8bN6DE/3wp1ulMQ1tWxqG883bwUzSQYiSjKdpPcw3OLVsVCJieS8nUasqXWGiT4swuo7Clk/n7Q==
X-Received: by 2002:a50:b5a5:: with SMTP id a34mr30938889ede.52.1548877876178;
        Wed, 30 Jan 2019 11:51:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-v6sm454123ejf.9.2019.01.30.11.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:15 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:15 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:51:02 GMT
Message-Id: <0a05e15978509cd6d2394d7eab1ced1ee3614605.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 13/14] trace2:data: add subverb for rebase
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/rebase.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 774264bae8..49cef31184 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -850,6 +850,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	static const char *action_names[] = { N_("undefined"),
+					      N_("continue"),
+					      N_("skip"),
+					      N_("abort"),
+					      N_("quit"),
+					      N_("edit_todo"),
+					      N_("show_current_patch"),
+					      NULL };
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1039,6 +1047,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
+	if (trace2_is_enabled()) {
+		if (is_interactive(&options))
+			trace2_cmd_subverb("interactive");
+		else if (exec.nr)
+			trace2_cmd_subverb("interactive-exec");
+		else
+			trace2_cmd_subverb(action_names[action]);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
-- 
gitgitgadget

