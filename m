Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037201F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfEMR2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37725 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfEMR2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:28:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so18708159edw.4
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oyomobdEds55cxv9JJOTjAXMRXJwGkwf03eDae/+Oew=;
        b=mMT+BOnC/XjOOP1kmmeFLohHNL3D5fJWFWxnxxJ70MhQZ/7TW6ZTCMOy/e42KjUtHj
         oPMWf9pvdC0adLxVgNoZ1XYyJA3ANGfHMPrx8+Td7O1y7S4T4hTQDHmKr80NRLE24gIZ
         twwCzlkQTDNVmaW21brhQqDOnUwK/OBaaO1h9iyj5nfKU/yjebL+841ts0vXjXx6yuZH
         TK9Ce41jfd1WzoqXjJypLML3fs/WU7IAunGkRV3yRxac4vChzvqO4exM3DksBWqYPOfn
         yhlgPDc7iBTP/0wq5JK0V/nhICHpSBEi+IW5X2jdhQnFl+vi9xRViIUSn9IbPuv7m0dz
         /Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oyomobdEds55cxv9JJOTjAXMRXJwGkwf03eDae/+Oew=;
        b=kfWtcLyuTMpGQRjWGc+SSjmi0KvZQdru9BVH7gkHcMUx5yxoqoBO07m/VYOF/hAN86
         DeI2MM919lyUTNolHzFfwPLGzQ5QkqWLvi5krR2x44ZOfF1MyFdDiV+RSylMPJj/YM1e
         SVUZwMDJ8bzxIOMbT5guH/IqRf91ySK3g8+QSMAsDIsUvWq2E7OHfOcgEFJNwZA6duMb
         D4VUrynOCdxmb6FbKFtoTcFhv7LwlsA7prc2lmqh5mKIpWCioRQmkavHEILI4JzCU8A5
         sXPAZROAhPs2LD4FHNdHsNR8RxJc+9Vq8TEL97JzNv0v4Eu6613UsjmxLa4/0LNaL1Vk
         zNFg==
X-Gm-Message-State: APjAAAVzfahUwHThS1tXRLKRv/HlISjOOO97w2l/3/4EAQ3EI2DyaW5G
        8krYqqHvmSnugcRr9N4rYkJb7OL8
X-Google-Smtp-Source: APXvYqxYSyeUQ+k6wuropLeMyCsin7YQUA5ra1dfVEukFhMPY+vd9fBu4h+SQAn5FTqbJJ3wccgEZg==
X-Received: by 2002:a50:95f8:: with SMTP id x53mr30489476eda.204.1557768482641;
        Mon, 13 May 2019 10:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a32sm160041ede.76.2019.05.13.10.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:28:02 -0700 (PDT)
Date:   Mon, 13 May 2019 10:28:02 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:51 GMT
Message-Id: <266dbf2a6bd32a60fbcf25d26b40189430e21c9a.1557768472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/11] built-in add -i: implement the `help` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This imitates the code to show the help text from the Perl script
`git-add--interactive.perl` in the built-in version.

To make sure that it renders exactly like the Perl version of `git add
-i`, we also add a test case for that to `t3701-add-interactive.sh`.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c          | 27 +++++++++++++++++++++++++--
 t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 538658dfa7..c431c72e3f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -428,6 +428,27 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+static int run_help(struct add_i_state *s, const struct pathspec *ps,
+		    struct file_list *files, struct list_options *opts)
+{
+	const char *help_color = s->help_color;
+
+	color_fprintf_ln(stdout, help_color, "status        - %s",
+			 _("show paths with changes"));
+	color_fprintf_ln(stdout, help_color, "update        - %s",
+			 _("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, help_color, "revert        - %s",
+			 _("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, help_color, "patch         - %s",
+			 _("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, help_color, "diff          - %s",
+			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
+			 _("add contents of untracked files to the staged set of changes"));
+
+	return 0;
+}
+
 struct print_command_item_data {
 	const char *color, *reset;
 };
@@ -473,9 +494,11 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		N_("What now"), command_prompt_help
 	};
 	struct command_item
-		status = { { "status" }, run_status };
+		status = { { "status" }, run_status },
+		help = { { "help" }, run_help };
 	struct command_item *commands[] = {
-		&status
+		&status,
+		&help
 	};
 
 	struct print_file_item_data print_file_item_data = {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..91aaef2932 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-EOF &&
+
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
+	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
+	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
+	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
+	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
+	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>>$SP
+	Bye.
+	EOF
+	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
gitgitgadget
