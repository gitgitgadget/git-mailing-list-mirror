Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DE120248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBVWZN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:13 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39924 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfBVWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:13 -0500
Received: by mail-ed1-f52.google.com with SMTP id p27so3098134edc.6
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=ZDw823pH5qt0VcgBLZrYz8+PbxsGspt+1eiHysJ928OFiCO9gVYDggcDtW+YRGqjDE
         n2CZ0zFFmIHTRY80YWXjxdBAvVYKvn5z0RxfWHsoT5kUwzWMDsopl8tWUpXbqREBqxvM
         pyyD3sRcGYS12BWzA/VquLt/8tqG966wrq9Z0blD4gZ/bZtzx7adhbQOowPzfFXF3nLY
         Ff276IsMy5/ZVn5XerUcJZXKNjxsek1eMG5k2b21O/reSPBQj2/LPkB02tuMyeF25xKy
         4j4KXmwtYwglxh0jZApXWeSoj/Yw3W13er1zNoG2m/IBlvUjtgH9HrTY6nx9Xu32t2+h
         OI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=OZty3IKyFa6dhiYqmSYyFqhBoDf9XgNGnJm3iZSkNiltpQ9YEebwr1uZaaenHkHBmP
         LdHk7KJ8LJF87aVfm07YDGlZZdcZxY65nsDwqqGG0/ZBHRrpAk/AqJ4ndeP1JDH/zzr0
         /dVVtDanlRIZ3HCC0qUZVmD+K/o8bS+CfxAEtYSHhD7foOUZlUoSgwamr+3/vB3UARGv
         dDLjlspk7VOalmrqKz7JQnS4/1PLdcIf9fxsmqhX/cPhrIVF5eZxB79NHu8eK4Mz7TSX
         tRXbhigzHfRMyr+QSDyDT9oJahBHGK3xn9gY/t8GQsRJY19Ec93AfzfpfM66f8FtJY1I
         Ij0w==
X-Gm-Message-State: AHQUAuZnGOwFxcJXFI3cVhKLiJoobaQwxRzs4ilbNyC98qkvcNgOUJJM
        +nfePZS52kKDNux2mZhBmWxfO15x
X-Google-Smtp-Source: AHgI3IbiFXrbpyfunLNZWGkuKGwpT9li4e+wn1EtRF4ioMHxaU0cHddK29pwtNnk4lFf14yT6C6uQA==
X-Received: by 2002:a17:906:e201:: with SMTP id gf1mr4491604ejb.10.1550874310721;
        Fri, 22 Feb 2019 14:25:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm462435eju.74.2019.02.22.14.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:10 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:10 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:56 GMT
Message-Id: <3e6fee40b07b29eb62c96c08bae4a615d247de85.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 13/15] trace2:data: add subverb for rebase
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
index 774264bae8..f5ac4fe2ea 100644
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
+			trace2_cmd_mode("interactive");
+		else if (exec.nr)
+			trace2_cmd_mode("interactive-exec");
+		else
+			trace2_cmd_mode(action_names[action]);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
-- 
gitgitgadget

