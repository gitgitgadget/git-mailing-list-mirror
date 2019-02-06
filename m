Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756971F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfBFRQH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:07 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37897 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfBFRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:05 -0500
Received: by mail-ed1-f53.google.com with SMTP id h50so6542909ede.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=euEfixk0Fvtl5I74aNTlhTWDvJci6gb558ABxz0v173qX0X7Cqbxc0K+qLKpdarVGx
         GaaJJRuUNVioxiJkergamVkCYfb0z/KMbz5uuj0UgzY5YWBZMVWn33EQXzZ3OgptC0k4
         lGg2TKB1aNCmYeahaHW0DqcHLcPw1LEnmGseRFsMBzdI0V00m1KN3yIah9BZBQCn06Co
         p6vADjCwvLtei+PngiCHAYQP6jBqhPzCESQcswvuq6xHNrXyXUiKlEbro9ScDNXdyRVQ
         Sc5suMl7EL1lIRQ6pAzovrQ6xd5k8UImkQAz1N5tdbse/rr47eKDlpJGWBLB1mgGQg3V
         9EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=ijpXZdv2MAKWQGqyX3uQiENPQP2vhRaua0x3evkWLE8X63qdij/pn1pBmbA7Cx7kYx
         84f4pczTnXWy/UrmGkKhA6E3EFdjA6eAwX+qZVlQJE1x405emXYlMacwG8iH06dW4eyQ
         HKtSjI1MyCPFM7GtTOKkCEIK3B1wn/nFHZLFcCuacBY9Xg6epqrxOCeC0qdSGGH5rxA/
         KI4ShMTfeesUd1wIhG3A7mCeJkWT6IQ1nFyz2l07KlgcPwQtLSFQs+awkS+/+86ac21T
         RxohvuswUJC1VDxxoQoCtubeFjuRqW61GbAyFWNmivvMNbe18N8ZcUpUfY6rZJ9GGHvk
         zH+A==
X-Gm-Message-State: AHQUAubwa6gp9zX6I/fmtAOryFieE3OCjEHiMQeOUr9P28PQyVA//BtM
        3J+VlfSUzTUSm9J0Husq+Bukqwiy
X-Google-Smtp-Source: AHgI3IZGJ0kwoOg5vEUhghn0KdmyBRYsRCe92Q4diQTM1ZghNfoEB/to3V9sFLVxliJXGyKL689/Vg==
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr8295676ejn.62.1549473363896;
        Wed, 06 Feb 2019 09:16:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm3659464ejb.10.2019.02.06.09.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:03 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:03 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:47 GMT
Message-Id: <24d8d8d76837e0ae921d79f4534c8bd02b3157ff.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 12/15] trace2:data: add subverb to reset command
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
 builtin/reset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..4e34c61401 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_mode("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_mode("path");
+	else
+		trace2_cmd_mode(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

