Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DED1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIEByN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45263 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so2214493pll.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8bGiep4pIZkeQWaXhgVHQINFIUf/Mx+Lp7zT4sdD8YE=;
        b=jUDNP7L2yfjZ0Wd4G7V9XaJKoB48fzuWdg9q2I7jc44gHOYsO5Wyyxl7zeh17TJx/h
         jAJXJQJI97HyB+ZVdjpkWFRus61MLdGSQoJoC2D69Ky/3+cDqQYGb/grSPIwHGLzwqo1
         a8SWegB7DEWA48H5ADMfmk+DXHY/NYsJIlNMrZio98njqH8TpoPxW4gZWDnvVqeJ8BVk
         Xlfdj+qO+nsFJF+PT9/e2zdPOYQ0ZUVTSgJ0e5PnjcoQXf3Ed8SiQBDrI0Yf5Ol2/3n/
         vVpDYigbRMzkyCD3kOC24Q4XbzG8JYF8DN2ZMvtJpvd9EmOOHCRWCQb16iurqb8bSm6x
         yUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8bGiep4pIZkeQWaXhgVHQINFIUf/Mx+Lp7zT4sdD8YE=;
        b=pfYK133Ec9B/aqJ/vBvldQGVb2zfWogIbLNWKEP4BgVbyKkllWrX1B7o4EhC1oA//K
         bEzYlKk9d7w17uikU2zsW9MCp17qC+T9o+k/JKvqQDkJ+Sh/iVXy9MhpSbHCvP44JPHP
         QgwSsa+LdVCHDo1wgOmJ6prOQCg9r1+oEbgCAGgbBOM+AaqKXrpGvKpwM2hRnqplrQKg
         ZpO/B7/KCzG6/aydtQAoDYf1kq1cyjKMOgh/4iaMXNcJ6djTDcREJc8nWuCHab2gYiVJ
         H7CyLFkGNlqljFxmckPDQ4W6nUzeYvCYVfz4q5nH71JJK7hxlQ+eqMUCXDtE0ZbJRvjl
         fgHA==
X-Gm-Message-State: APzg51A/RnZbxyZwMKTJRaA0RVZO2MXIXcoU5uBgzN5jP4lwkW2DINkD
        ZNU/pb+LMayMlLwrBFJW/Q0jLem/
X-Google-Smtp-Source: ANB0VdbLuzQY4zTrgXJkzSfT1N0yQ6dbf8/xCqS2B12iMWfb35/IOh9F3tOuN8Il/oYJzfLW6se69Q==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12-v6mr32674948pll.283.1536096435596;
        Tue, 04 Sep 2018 14:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r85-v6sm51369025pfd.144.2018.09.04.14.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:14 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:14 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:59 GMT
Message-Id: <f11f21d5c68e66c15e8845cdde09a0c70c98d2e0.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/11] builtin rebase: require a clean worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit reads the index of the repository for rebase and checks
whether the repository is ready for rebase.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2d3f1d65fb..afef0b0046 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -19,6 +19,7 @@
 #include "parse-options.h"
 #include "commit.h"
 #include "diff.h"
+#include "wt-status.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -479,6 +480,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Could not resolve HEAD to a revision"));
 	}
 
+	if (read_index(the_repository->index) < 0)
+		die(_("could not read index"));
+
+	if (require_clean_work_tree("rebase",
+				    _("Please commit or stash them."), 1, 1)) {
+		ret = 1;
+		goto cleanup;
+	}
+
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
@@ -528,6 +538,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	ret = !!run_specific_rebase(&options);
 
+cleanup:
 	strbuf_release(&revisions);
 	free(options.head_name);
 	return ret;
-- 
gitgitgadget

