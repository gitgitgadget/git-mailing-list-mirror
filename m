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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3C61F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGDJQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:16:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35427 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfGDJQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:16:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so4769157edd.2
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=quf5qCCWC2hkgD7IOLQQQiVVhVNyb7O2aVqTJb6h/F0=;
        b=pKDd/I28/KQPJM7Of9Nv7aXwfg+MfUeM4MqIITQTjrG8cQVN7OsxBt8ppzFZ8A5bus
         MqASPvsspFlzDPODDwChoele83nW/hoClkFIQO02HPe1i2euVhVX9xM3mQgLl8HHp8xI
         nkU95tdl9TUjTWIeJ4hAx37YyUgQ4jjJHbB5Z95SQYR4+K5LMpBt+aWc8FzfiyyT3J7z
         2VKolFO0HR8s2lh7RRAJywQrsyHiglWLljs7cwRcSnlXdZ51bwDw3IJm57bV/xauFFCZ
         Uu94Y/upQWsphNHqFOHFpyQ7nl08HbMceWowTkGox6jEhq3TgigbktViYaYKB0fGG4JH
         IRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=quf5qCCWC2hkgD7IOLQQQiVVhVNyb7O2aVqTJb6h/F0=;
        b=lQxPPmAqtdAmW28XU8DL+E9pZifadwG1hpbwOOFThs6Dqv9CRzG6cDtc+nkcBXH/Ve
         EyEMRwwRGgHcB1yPyMp5TSmRTLz5q3AJzIsY3L3VlaOMbe5N+tteqfZipYA9PmquuKCU
         YXWeMEB6tJLoBF3tGoLouo0VPhNShQUvv/e6Scvz63wqLJLvo9gsPRt9Hf47uSOh5AAK
         PyYKvrMheTRGmAdlXfhfwXq/uSNZVSS6GKpm4xUD9J5OPftSaxGJHMaJyf3TK07OH5dU
         /T35jM8WveA+itfBgVQ+VtF8koFU+NMPtC0LlVMrf+lh9h/ZY71M+g37NE3HIx2rzk9C
         kfwA==
X-Gm-Message-State: APjAAAWOWFmTiTipA7fafpiS7paR65ZWmXSux/iShCGmWQ9JWn+075Wz
        sm8VWoAKEzLk3nIa9TqURkfiuJX2
X-Google-Smtp-Source: APXvYqzLuElrcPXF6Mz+dYAu+8YqnD8da9fmAjXu2hRt7Aq2X/bG0mZwc0EILMyO/O8l9ZVqfD3T0Q==
X-Received: by 2002:a17:906:9609:: with SMTP id s9mr35146278ejx.233.1562231783040;
        Thu, 04 Jul 2019 02:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm1506064eda.79.2019.07.04.02.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:16:22 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:16:22 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:16:21 GMT
Message-Id: <bef83fc20b9e2048872316e3f396da0cb6775086.1562231781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.213.git.gitgitgadget@gmail.com>
References: <pull.213.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] diff: munmap() file contents before running external diff
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

When running an external diff from, say, a diff tool, it is safe to
assume that we want to write the files in question. On Windows, that
means that there cannot be any other process holding an open handle to
said files.

So let's make sure that `git diff` itself is not holding any open handle
to the files in question.

This fixes https://github.com/git-for-windows/git/issues/1315

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..0afb76bbca 100644
--- a/diff.c
+++ b/diff.c
@@ -4206,6 +4206,10 @@ static void run_external_diff(const char *pgm,
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
 	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
+	if (one && one->should_munmap)
+		diff_free_filespec_data(one);
+	if (two && two->should_munmap)
+		diff_free_filespec_data(two);
 	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
 		die(_("external diff died, stopping at %s"), name);
 
-- 
gitgitgadget
