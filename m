Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EFD20248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfDOUjx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35905 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfDOUjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so15266551edm.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=mnSKne8YZDSgJlbOOAZNC6X0V3W/Xjrrn4vtAVHfOCqdz5PvAS0jNqwdP1u/l6ZFZ2
         hIyyQyKQTsEDrT2qfoelLVI/I19JYCgjNo6Yzgs+UCK2KRLiKpLwCWs1pxQiira6QKZe
         TlE3fGgxay4igVqAYYVUBsw8F26+MlvSlx9hmM6+6D0n+6xe9q/Zf28rAcadUQLoL7Rx
         OZzHkIuZnzRSrmQjYVyKPrWZ7OrwmqEkMrHc4LFUz1IfFSM8NKQtzlrPxtmx7ae2q5gI
         EhendDtuiD1BSZI7SHQDjCycc/9ExSlfm9wCS7UG1fMC1qg7x6SFXXzRL3fuCnhSUymd
         W2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=MJOP8ZwZrpQ5yvcRblWp9KhIBv+yT1UWnHrMZbG5A1djhBVsh5mbrqM76VxqSvBVuO
         jU1iXBJYHVV1aN5H/E6IfCiELlg9TPhiZZU0zycVkjnBrGqwfaQW+yKaTC7u+BpIyZfF
         5skT2C7vTRraWx5n+6VwNcRc7usw6Mc/mwVtl0+WntygZ+WPh0tykttS80IxiMoQ34nd
         qbNjqZPVbJfX/h1PtplR0kieMmv6lTQFSsHPp76Ayk1QYeUI4aY1E0Lfcu7VegVZRUxQ
         c/niT5h8TZFoiBEsMYgVATz0DMxlWoUbf8wOXPdHfYpfbFCoPPF5LRKK0F+usWb66cN4
         O7vg==
X-Gm-Message-State: APjAAAWj8TFNTJUxd3rpA3tJkQuav5bEhe3YN9ebmRH1Xmx23vZxfaJt
        3t/EKiXB36Kgh0agEJa2p8twr3OL
X-Google-Smtp-Source: APXvYqwCCtD0od7TYH0Yhhqh3kxoyJWHjTfR+XlvkELuo7ZxlqmYhdz1JFl7hNEs9S5lJ12uyEST7g==
X-Received: by 2002:aa7:d0d3:: with SMTP id u19mr48940422edo.234.1555360786114;
        Mon, 15 Apr 2019 13:39:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t52sm15771292edd.54.2019.04.15.13.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:45 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:45 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:34 GMT
Message-Id: <94729b284c4338aa40d4287eea909e835820ff4b.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/10] trace2: find exec-dir before trace2 initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to resolve the executable directory before initializing
Trace2.  This allows the system configuration directory to be
discovered earlier (because it is sometimes relative to the prefix
or runtime-prefix).

This will be used by the next commit to allow trace2 settings to
be loaded from the system config.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-main.c b/common-main.c
index 6137af0e63..299ca62a72 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,12 +37,12 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 	restore_sigpipe_to_default();
 
+	git_resolve_executable_dir(argv[0]);
+
 	trace2_initialize();
 	trace2_cmd_start(argv);
 	trace2_collect_process_info();
 
-	git_resolve_executable_dir(argv[0]);
-
 	git_setup_gettext();
 
 	initialize_the_repository();
-- 
gitgitgadget

