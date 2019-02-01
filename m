Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675321F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfBAR7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:21 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34938 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfBAR7M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:12 -0500
Received: by mail-ed1-f52.google.com with SMTP id x30so6172663edx.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=akQpWA1vRimouPBh8rIACapGdPvbK5nBcYm8w0PF+YoiRYcKqXHXjp9KCiXTrHqCr5
         ZLzazJBVD/6N1qObTAwHTwNNxr+EncRse1kCm9Eu9GfVnlQ4Syicq69a9MYnljOYbzmy
         VQDHEKVDVT00H+LlYmZ64E787awmMdEMxZpYE7Gqj/jFsdye3RN2buhjQy4PBdpLa2Nj
         W8zJneA6E06iuRagBnFch4E+ACp/nVnbc56PHNDEEHHr/mr7aXlJoIhTJ/KHxVnyaaxW
         b3JYPAQOaLITrUBDpF3qHj4xjPZZTIvxnyo7GjKuajuCRm9aDb4DgGo+I/aoBPWKBGmf
         U5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=p3kTssEY62pg4oHh2eWCXOausapINy7XTsC0Ie/rXUfPi+EXzEl3oSlUFp3DOZJTwS
         K2xHS6Md7gMBu5oEIxtzLeTAUyiW1LH00vJCZrxy/hFJjbq7C1j12CPOq5gPjGxBVeAr
         BAeJVagSdUBv5qlX/K+XSkhiLG+yiiR+I3B577en84SYNV2z10i9EMocQBaFF/Wgygg5
         Uu6V5tw9PH6/J5TFQ4qv/GLe+B9K5twUXVorJOs8DMfDlUH5ATMgdb77yZf8vulMjEGu
         HeZgET3xXlptc2oIDfRs3nJOGfUWf5VVZR1hHN97s+hwIXuLdXYADs8xiEFilUeb3K0G
         jfeQ==
X-Gm-Message-State: AJcUukdjbz2CScQyyQhCsZlFEWQVNMVgi/HqkUgVRvkF/uSgMacFyn/M
        wJHpFALpH8L9O0xh1bsKU1TWBEGA
X-Google-Smtp-Source: ALg8bN7M84WgZzNBvu2PFo4Ag9S5sZW3nimlwsqRcnVlVDw7oE0S5cDVSw1hjUYvTQLrKE/9XRrFZQ==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr40451124edb.160.1549043950469;
        Fri, 01 Feb 2019 09:59:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm1331997ejz.4.2019.02.01.09.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:10 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:10 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:54 GMT
Message-Id: <cc612010610c2f9ff90e412a6f798976118fc028.1549043937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 13/15] trace2:data: add subverb for rebase
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

