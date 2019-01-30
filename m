Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E871F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfA3U4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:56:40 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45667 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbfA3U4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:36 -0500
Received: by mail-ed1-f44.google.com with SMTP id d39so758544edb.12
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GyZVgyNIbyoM3H6tn3QkHgrYsfqFejCynW7wR5zlW6k=;
        b=AB6ciTTs8yJLPkRrOJJq9399hID61IXTt0W1Qj4m0uWh6CU+l5IncVq0Cbq0cpM0fJ
         4jsUa6jZAxvaiUGIKW5aikxyqAR5UhQZ/MCzXBOBwOmrY+o2LHZbOommiflL6RwaAniJ
         U2bhkjtncIZiMJGodzf9UtNqNDFD3ynt9c81CZrwzyBrHJyiHbT/AarSvXgQrexOBj3b
         DHGeb83nGboF3I+GIUGOMBFldzQwmUxEY5Zjlc0yIAapx2u5FLbSNrP/8UdcLL6+vYPU
         +Ck5V5cozcQuq23U1Aqt5NKJNvVWXRaa4IChds3HqI9J/SyyY89m3wavszVmhSq7smN7
         66+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GyZVgyNIbyoM3H6tn3QkHgrYsfqFejCynW7wR5zlW6k=;
        b=Yieo1IVA9xi6CJi6fQHGqC3hzDGgAS5xKGaB/tm41uH0N/IWiQV418r6Wqu4Pd2kvM
         uFaEvD+Md0g7pwYPWRCaDms2IwY5zCfJL8TnKEXbwsOyk1MxL+uxLloQlsQ4vmJq/WMg
         RF1qLV0mfs6Fvn6GUmtPgQm3VuF06a1BXM4bqRqlWRtgUCeK5dJe/Zw3tCULeV/Umgk+
         l8mIKk6jkyrhkcYJlSQx2g63JcWs8Fv2kkH75j6TthG1gqV/fT5qAUqRO9o/7Ry6cqqO
         w13OKyxvVKYDZYKEeWyfAbqjolv4jxgWQULEreidUI2RhpkX7DM+/tLvxf4in3bjY9sA
         xa4A==
X-Gm-Message-State: AJcUukePM61RzKXo+w6XeVSq0deda1Mt8CfNj0hAd9QUJkjzkQunq05C
        gJfPYLCMatPy5dx8Sd3ZtvAeJHiO
X-Google-Smtp-Source: ALg8bN6AcVRaYFqqoOMSV4Sda+/IOYRE3ndZZfT2ICrKUXeyyj5mZIy1gWQ/BUblDua4VIrNeJbLww==
X-Received: by 2002:aa7:d416:: with SMTP id z22mr31199517edq.3.1548881793849;
        Wed, 30 Jan 2019 12:56:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm755240edb.48.2019.01.30.12.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:33 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:33 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:18 GMT
Message-Id: <4f55f336245c395fa3386b3394c7bd41148ae928.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 13/14] trace2:data: add subverb for rebase
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

