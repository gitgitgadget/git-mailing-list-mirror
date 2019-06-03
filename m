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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C9C1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFCUS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35181 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfFCUSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so28652064edr.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJ1Ti10njS9BL/HuXiX+d0N7jKi7cBIA9Od8GnBBr8I=;
        b=nxVm8ViRwyy+nniBqWUIwR0HIHFAqTxgY9I5r7w6RpIfCcPgKKVBwzTKB/64oRfnJR
         XYqljqG7ggD1O7IeiqBKCAKtxt0eMT7TpcSDigN2PmvHYT60XBJIbjpBBIBjRi18v48z
         9GWInI2btnJrQ9EDW+ne1WaAtMoAWhxxUBkCmQT4uIxrS+VwTWdFWU5oNXHvMuDFlxgx
         gTPDwip6kPziL7EPq3PgF9YabLFHkC665v31vTNw+HO2nD8DJy0iueyQ+WWHX2ceGDln
         1mY8BK83Q4OZ38P+Q//1Eydf1Vh7kC9zGtj15AJ5ZtnReDMdbibctAEUaoxXw0FPaiuI
         Z0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJ1Ti10njS9BL/HuXiX+d0N7jKi7cBIA9Od8GnBBr8I=;
        b=uYSUeqestGY97GbonpvoRy0/dQB8uBvh+ni0YpSDEdOzmBvwMHlB6QtR52pTFFB0br
         wT4CQnIGm5fVCI8ZX6HrarHCu+QmtC6rfioIBaIBkYrmk+ju8T2SY6APU5SZCc9rUZnO
         M/Ph0HQ7fjnYAOlGYrc29/uslREwLAuetAGJzx2C2qWNC31VOkxA4ZnZgqY5lCsg5dVu
         cRGCbmV1fs9N4ShHspMaKoFaZBFe75LRrFnvoXrFEyLVNdDdVY4M3vivHqDOnKWnOSGS
         y+VUQZjtHfeEaoCrFjPAIBfLvxaihy8eo/CBDEcoVhB/tYRNGNFlZfgXdg5Q6NhlZEHc
         hysQ==
X-Gm-Message-State: APjAAAXrC9mEMmPS9frT4YvHt/Q3kjbFqe85bwx/F9Y71iJ3FNJjBtfD
        vUN/Ifhw3i1Q+eGZa3Mhj86Gl5GJ
X-Google-Smtp-Source: APXvYqxaV65h965yIB/7i59fxT6tXqpCY75bn7D+f9q0+rq4bi4ZKKcYghWS9GjOG3UfXEdCHEW6Cw==
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr6284367ejb.216.1559593103434;
        Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22sm4163576eds.66.2019.06.03.13.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:12 GMT
Message-Id: <82ae00e49571f2621769c3cea07f806b89142efb.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/11] status: ignore status.aheadbehind in porcelain formats
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

Teach porcelain V[12] formats to ignore the status.aheadbehind
config setting. They only respect the --[no-]ahead-behind
command line argument.  This is for backwards compatibility
with existing scripts.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c        | 10 ++++++----
 t/t7064-wtstatus-pv2.sh | 12 ++++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 71305073ad..79cb238d87 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1111,11 +1111,13 @@ static void finalize_deferred_config(struct wt_status *s)
 
 	/*
 	 * If the user did not give a "--[no]-ahead-behind" command
-	 * line argument, then we inherit the a/b config setting.
-	 * If is not set, then we inherit _FULL for backwards
-	 * compatibility.
+	 * line argument *AND* we will print in a human-readable format
+	 * (short, long etc.) then we inherit from the status.aheadbehind
+	 * config setting.  In all other cases (and porcelain V[12] formats
+	 * in particular), we inherit _FULL for backwards compatibility.
 	 */
-	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+	if (use_deferred_config &&
+	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
 		s->ahead_behind_flags = status_deferred_config.ahead_behind;
 
 	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index a0baf6e8b0..537787e598 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -436,10 +436,6 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
-		# Confirmat that "status.aheadbehind" works on V2 format.
-		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
-		test_cmp expect actual &&
-
 		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
@@ -449,6 +445,14 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		EOF
 
 		git status --ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm that "status.aheadbehind" DOES NOT work on V2 format.
+		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm that "status.aheadbehind" DOES NOT work on V2 format.
+		git -c status.aheadbehind=true status --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget

