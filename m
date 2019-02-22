Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D672C20248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBVWZU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:20 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35381 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBVWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:11 -0500
Received: by mail-ed1-f49.google.com with SMTP id g19so3116971edp.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=khSxRh2ufpsoXYxlQBgVTC0SjtgzaeYtoeFK+GIadSetgw8HdT+h9Lj3VMa0VSLtZ6
         TQonE1EVRDAPkDG8E38ir6Saebg/6w8idy4cPRHJWGJsk5urgcMfjEGMfUfYkqn8CC8A
         dVSgWquQRyqJXoLh+XR3hQRi+FayJgpFetKSXTl+wVm7zofHiEDlihrRbdC5NHImtgN/
         fYmtu+PW9vA7m5viUrKfQNChDkzzWzFmYAQ6miQaOR5eHtP40b3kSf/MsEpsIN/q4+ab
         wXOAMnZU+umX8yhmiozQH5F/zOkCdkZLPVT/J50qZ3fXU5paC/yDqNO8Q0PvLUueEIM8
         +35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=A5njDRR7d0UM3qX4ctTwqsYmFkNLWFRb8Apxg4DFR+0VrEKXxS5FpFCI0yi73AFDBs
         ZEsxXfiTb/xWf5YhdOpqPwYofkcj8PQsiH3ky5p03JXi9uocawY74xDpE6xvtObAQSIx
         TbPvRDEn8azXUfTi799kMCmVKcEzfQD4s0mHL0t9vMS2iswZ4TvsFxoO5bgBEzf5B8aX
         RfpZHBUJJbcHESNAVAAgZloT5dNEtEsmNA6zJ5F084aww/GLbg3MHlBqS6TgG9WY3w9W
         NUuMXRpnsHxf6oUo+99oa6zjFcEFOFR9vMfmgM1xE+sHw8YTNrL289KkewnZ4e8nVpcU
         cqbQ==
X-Gm-Message-State: AHQUAuYNRQ8o3mOTdEU+iJsOcME7iQMA57s5qc26eYVQUbb7oqde65Z0
        LFmLhLQlUUCWKssfAytgHga0TVKw
X-Google-Smtp-Source: AHgI3IaG3GxDvVrpASmQDXyyaNWoYhbs1xi24OYpXIdiFetlS4FcsmF48jpq9GRtv+xMjJanzbe5kA==
X-Received: by 2002:a50:d5ce:: with SMTP id g14mr4749051edj.213.1550874310032;
        Fri, 22 Feb 2019 14:25:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o37sm699979edc.32.2019.02.22.14.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:09 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:09 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:55 GMT
Message-Id: <ebaa9b1d807957ed41b277fdfbf7ecabfd60e92d.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 12/15] trace2:data: add subverb to reset command
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

