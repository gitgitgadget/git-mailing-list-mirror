Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63DB1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH0M6G (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfH0M6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so18707266wra.6
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MDS3VyEtjqlxL22NPuOn2c1gYCHbJCWQ5MSerLrc6II=;
        b=QIifbr6lTbBUoCzOogOa13Zf+NnRpeedVpOXIJ95zjY7V24E8sSmhFcEviSjnPtv5t
         vRSzbvfAhAguZacM/9n2+dBV+h2PtH5W2ZD9xjGrfM8heJg+UWzK22iIPY2BrWVEcXG9
         jyese+kvD5OrhxPNGu3HPW1jchu94431BOi0NTnYV8Kp/gxPEsmBbxK+A+I7wgzMTu4D
         cwL3dkks26nFRIFKTqcEHHjKzFRSOT7FqBw98Ol0WV3tBFcyJj3zaccCTI+hSUmJdowO
         NTKQl0z/RdpqxrVFJqBI5H79V4lPZ+wbqNuYOkmUEaF31kRHSe43JtJpm3GpWhsJSYjD
         buLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MDS3VyEtjqlxL22NPuOn2c1gYCHbJCWQ5MSerLrc6II=;
        b=DNiXWQBB/UpYADIgFMFD8+jVcyZuPHzB8XnnfUPVJSBpCjjc9dpK0L6YbAWjeLIpci
         T+R8w8zP5hiazAHI03qCjj7PlkkNYvOtR5fjK+EjxNLqlBlhLR9TPH/yhkNle+d4LoxR
         iP6i5UUutb0Lq5qHjABfoI16ij8kWxK/Si/HauI9aE6IFj7uvoGpAryTg+rp9TovK40c
         QXX6TtC20mNuSeaKnfsWOScoTxhFXgUxD01CMhArFgyn0k9Vb4KVpWXXQQ3PbWjI8p/Z
         HnNH9zN67u0unHPT57PtnjzArJn+btLb0bmYt65JWdD+Dr5dFPWRmPhY3+cmgaOVFCLb
         0yvw==
X-Gm-Message-State: APjAAAV1coDGXKmyy/Oz/rHzJ8bpHVs4oVAhfJ33dNRuocf2q52V+blh
        q8lo+eRXtKJukX4r4yS37/fLuRRARMU=
X-Google-Smtp-Source: APXvYqxEPcu0I/52WsG5s+qH2nCmyRQxNeGIAPudfjo0mE1uhEVZWhDy7BNYugA7LQGLXfEXodXO3w==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr28063373wrm.83.1566910682300;
        Tue, 27 Aug 2019 05:58:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l62sm4559416wml.13.2019.08.27.05.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:52 GMT
Message-Id: <b27fbe289f18201466ce996e29b2788e22b2b17a.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/11] built-in add -i: implement the `help` command
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
 add-interactive.c          | 26 ++++++++++++++++++++++++--
 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index a343195a67..765455a3fc 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -429,6 +429,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
+		    struct file_list *unused_files,
+		    struct list_options *unused_opts)
+{
+	color_fprintf_ln(stdout, s->help_color, "status        - %s",
+			 _("show paths with changes"));
+	color_fprintf_ln(stdout, s->help_color, "update        - %s",
+			 _("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, s->help_color, "revert        - %s",
+			 _("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, s->help_color, "patch         - %s",
+			 _("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, s->help_color, "diff          - %s",
+			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
+			 _("add contents of untracked files to the staged set of changes"));
+
+	return 0;
+}
+
 struct print_command_item_data {
 	const char *color, *reset;
 };
@@ -474,9 +494,11 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
index 69991a3168..cf67756b85 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -647,4 +647,29 @@ test_expect_success 'checkout -p works with pathological context lines' '
 	test_write_lines a b a b a a b a b a >expect &&
 	test_cmp expect a
 '
+
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
