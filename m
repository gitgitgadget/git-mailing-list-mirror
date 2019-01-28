Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36811F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfA1Vrz (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:55 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41241 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfA1Vrx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:53 -0500
Received: by mail-ed1-f49.google.com with SMTP id a20so14326432edc.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EJ95PQqHzSBcG7NICHPsSKArfsai5JdwDxdML/7q1Io=;
        b=r1aeJuyuJChj4DGGY6BM/7fZqb5TD4WWvW+LYCMwyfJXfFYsdcTRWcxU0+uFBsBHpC
         5y0Fg5YaLoZADJBgJXv8jblcewIg88IXbjinT8H5ru+RcgqiQIKLqI7q+PzJSQOIHGKY
         2hfhSzurkEcO4so9u3ySRgsSq20FO9TArciT6mS9MpK2NIGeJLAGZF3FiaBBmXGLVjvw
         oJg22HpByyoFeR4/0aHyJqnPvzffU6dXZV5RupsAzzLDDsUu8kT3Hw9dWq64nlKabz6V
         bSliZpResGkSjMFaZeFp9DGcHTP0JmhZOxUVpJb1/sJRBlSQnGPsXwex5ybUdU8ulTaW
         RWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EJ95PQqHzSBcG7NICHPsSKArfsai5JdwDxdML/7q1Io=;
        b=YVUvu9gvBYCVXetp0dbB4ygBC+RSGUCgk7QsMNcgSngo+Y+zjRHiFLD93He0BDQylK
         MuMDpgvAW+s3xtBAlwYWNDwMm5lGp3GB6GaiO7rm51QodyhKzbQQVH5iKaka8qDiyUPl
         ZWL6ps84KbYAQtfkrMb83nf1HIZsl7gOVmff0s3YaWI1xSGqogu9aJbZjH1YeKpidFYw
         t5mPzocje4Kcjja8S/3j1JWe4xY2IyAHkf3/A2ATmyDOX0oQIhjc5TCSYkLvpttlAGdd
         cEdwg1mGddbEdjwwSHnApCsahm+UX6iCAKIgK7ilCFNixBQ6UXZihh23KKfVgH9BeuWE
         0K8A==
X-Gm-Message-State: AJcUukeGnfZpPP78OkIxoasrO7ZZjw0sI4UPFJfWYIhZMti53WXGQJrX
        9BPmxRBMbsojNoi6HyO3tE8h21b5
X-Google-Smtp-Source: ALg8bN6W3DhMehQbB2ndVB9JkmBjpeDU4bMVl4qjef/g19KRSAYAfetsTdY9xew2ssel/t3F/Ro51g==
X-Received: by 2002:a17:906:a499:: with SMTP id m25mr18328688ejz.104.1548712071678;
        Mon, 28 Jan 2019 13:47:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35sm14039588eda.13.2019.01.28.13.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:51 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:51 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:38 GMT
Message-Id: <06ccce9632398558e4f58607adce3876a8b4fac5.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/14] trace2:data: add subverb for rebase
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
 builtin/rebase.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..aac0d52ade 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -819,6 +819,16 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	static const char *action_names[] = {
+		N_("undefined"),
+		N_("continue"),
+		N_("skip"),
+		N_("abort"),
+		N_("quit"),
+		N_("edit_todo"),
+		N_("show_current_patch"),
+		NULL
+	};
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1001,6 +1011,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

