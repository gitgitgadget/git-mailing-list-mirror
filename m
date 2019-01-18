Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA741F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfARHrF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46437 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARHrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so10360269edt.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wao26CuMYFh19ErBgGiWlHeSLyWortCrjWvgsmjx+GQ=;
        b=B2Y4mZWK9ZmQ55g/Ugyh5BDkqI6uwljx1GPHQgwvpDsJomgViVC/yTtCb+NQKozXdo
         ARMEbsrHBAmcLpoaNz+ZvM0GfCzHxe0uUxpomF7/aRiaT6yBGPxZSj9s3J/vX47PYRdo
         /FNvwq6IC+jgiu/pxWWYo3I+Io7pwS9c1CSyFMauy3yBZ2bJG4kVNWdyTTq16NZ64mZp
         rHAuaK7YFM2SEdPqTtzsfR3v3JKTSxO9Hm9mLMCpJsaeY5yCWmck87j1WLPsxF9ki7aK
         YMQh7wWNMfvkdJypwrDK30SyYCeN312OM5vdNQxZ6Grge/qR8Q7NZUPNI1XaAnMjmwwM
         1tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wao26CuMYFh19ErBgGiWlHeSLyWortCrjWvgsmjx+GQ=;
        b=reZG452xcf+zk1vh5K3uJkRhM6kdYvgRG6rMASrTXcDZGdW+4yWVluM34t/P+xpUkA
         /DVJOfSWtuR/eorrrx5LRAc4jPnJ5hiZW3WW3m0g37H6blk8byU4VrflW6tdGJ+2KcE9
         MrzStBTqnjRvta2XltdNA0JaofB9ymh4rtSUgfbqlxPP+QM/uyRTUb34xOuw+tsb+VHE
         ln1UkwIujvb/tLsCRmEww/CnE/mgIjd2sFCnJuaZ+rXuUdpSRmyh5uuCsIkDRD21vPki
         OJ26Q8Ns2RJ7+9dYsqFCHEVUGVrdQbnTF6CsfnkHFbOHc9rR9kSw47KEaX9zL7n+h2OW
         6JPg==
X-Gm-Message-State: AJcUukecQYkHntb3cUBBMIq5n4ruAgw7fDwbIcURkEgn87qvfoIQ35g2
        ZCu+pYO3haT8GELLodTW5azafITv
X-Google-Smtp-Source: ALg8bN5AdUq8MyRDdZ30ifBXlCZusTnWN7slC9hd9A9tByxKnxHHwwH1UGcynlt0DqIAAGI2tMf8Og==
X-Received: by 2002:a17:906:4896:: with SMTP id v22-v6mr13692781ejq.85.1547797622047;
        Thu, 17 Jan 2019 23:47:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5-v6sm3699794eji.25.2019.01.17.23.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:01 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:01 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:53 GMT
Message-Id: <pull.103.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Slavica =?UTF-8?Q?=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/7] Turn git add-i into built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first version of a patch series to start porting
git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
a head start:
https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u

Changes since v1:

 * rename show_help() to add_i_show_help()
 * move static const char help_info[] to add_i_show_help() and translate
   only the help text
 * add newline at the end of add-interactive.h
 * modify commits so that the test is introduced before making
   git-add--interactive.perl's help_cmd to use add_i_show_help
 * use variables GIT_PAGER_IN_USE=true and TERM=vt100 in test as alternative
   for GIT_PRETEND_TTY

Daniel Ferreira (4):
  diff: export diffstat interface
  add--helper: create builtin helper for interactive add
  add-interactive.c: implement status command
  add--interactive.perl: use add--helper --status for status_cmd

Slavica Djukic (3):
  add-interactive.c: implement show-help command
  t3701-add-interactive: test add_i_show_help()
  add--interactive.perl: use add--helper --show-help for help_cmd

 .gitignore                 |   1 +
 Makefile                   |   2 +
 add-interactive.c          | 269 +++++++++++++++++++++++++++++++++++++
 add-interactive.h          |  10 ++
 builtin.h                  |   1 +
 builtin/add--helper.c      |  43 ++++++
 diff.c                     |  36 ++---
 diff.h                     |  18 +++
 git-add--interactive.perl  |  15 +--
 git.c                      |   1 +
 t/t3701-add-interactive.sh |  24 ++++
 11 files changed, 385 insertions(+), 35 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 builtin/add--helper.c


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-103%2FslavicaDj%2Fadd-i-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/103

Range-diff vs v1:

 1:  737767b6f4 = 1:  737767b6f4 diff: export diffstat interface
 2:  91b1963125 = 2:  91b1963125 add--helper: create builtin helper for interactive add
 3:  d247ef69fe = 3:  d247ef69fe add-interactive.c: implement status command
 4:  4950c889aa = 4:  4950c889aa add--interactive.perl: use add--helper --status for status_cmd
 5:  19fdea5db1 ! 5:  cf4e913a5a add-interactive.c: implement show-help command
     @@ -16,33 +16,30 @@
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     - 
     - #define HEADER_INDENT "      "
     - 
     -+/* TRANSLATORS: please do not translate the command names
     -+   'status', 'update', 'revert', etc. */
     -+static const char help_info[] = 
     -+		N_("status        - show paths with changes\n"
     -+		"update        - add working tree state to the staged set of changes\n"
     -+		"revert        - revert staged set of changes back to the HEAD version\n"
     -+		"patch         - pick hunks and update selectively\n"
     -+		"diff          - view diff between HEAD and index\n"
     -+		"add untracked - add contents of untracked files to the staged set of changes");
     -+
     - enum collection_phase {
     - 	WORKTREE,
     - 	INDEX
     -@@
       	free(files);
       	hashmap_free(&s.file_map, 1);
       }
      +
     -+void show_help(void)
     ++void add_i_show_help(void)
      +{
      +	const char *help_color = get_color(COLOR_HELP);
     -+	const char *modified_fmt = _("%s");
     ++	color_fprintf(stdout, help_color, "%s%s", _("status"), 
     ++		N_("        - show paths with changes"));
     ++	printf("\n");
     ++	color_fprintf(stdout, help_color, "%s%s", _("update"), 
     ++		N_("        - add working tree state to the staged set of changes"));
     ++	printf("\n");	
     ++	color_fprintf(stdout, help_color, "%s%s", _("revert"),
     ++		N_("        - revert staged set of changes back to the HEAD version"));
      +	printf("\n");
     -+	color_fprintf(stdout, help_color, modified_fmt, _(help_info));
     ++	color_fprintf(stdout, help_color, "%s%s", _("patch"),
     ++		N_("         - pick hunks and update selectively"));
     ++	printf("\n");
     ++	color_fprintf(stdout, help_color, "%s%s", _("diff"),
     ++		N_("          - view diff between HEAD and index"));
     ++	printf("\n");
     ++	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
     ++		N_(" - add contents of untracked files to the staged set of changes"));
      +	printf("\n");
      +}
      
     @@ -53,10 +50,11 @@
       
       void add_i_print_modified(void);
       
     -+void show_help(void);
     -+
     - #endif
     +-#endif
       \ No newline at end of file
     ++void add_i_show_help(void);
     ++
     ++#endif
      
       diff --git a/builtin/add--helper.c b/builtin/add--helper.c
       --- a/builtin/add--helper.c
     @@ -85,7 +83,7 @@
       	if (mode == STATUS)
       		add_i_print_modified();
      +	else if (mode == HELP)
     -+		show_help();
     ++		add_i_show_help();
       	else
       		usage_with_options(builtin_add_helper_usage,
       				   options);
 6:  86d85face8 < -:  ---------- Git.pm: introduce environment variable GIT_TEST_PRETEND_TTY
 -:  ---------- > 6:  2b4714b8d0 t3701-add-interactive: test add_i_show_help()
 7:  060806010e ! 7:  6ede6d9251 add--interactive.perl: use add--helper --show-help for help_cmd
     @@ -5,11 +5,6 @@
          Change help_cmd sub in git-add--interactive.perl to use
          show-help command from builtin add--helper.
      
     -    Add test to t3701-add-interactive to verify that show-help
     -    outputs expected content. Use GIT_PRETENT_TTY
     -    introduced in earlier commit to be able to test output color
     -    on Windows.
     -
          Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
      
       diff --git a/git-add--interactive.perl b/git-add--interactive.perl
     @@ -33,37 +28,3 @@
       }
       
       sub process_args {
     -
     - diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
     - --- a/t/t3701-add-interactive.sh
     - +++ b/t/t3701-add-interactive.sh
     -@@
     - 	test_cmp expected-2 actual
     - '
     - 
     -+test_expect_success 'show help from add--helper' '
     -+	git reset --hard &&
     -+	cat >expect <<-\EOF &&
     -+
     -+	<BOLD>*** Commands ***<RESET>
     -+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
     -+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
     -+	<BOLD;BLUE>What now<RESET>> 
     -+	<BOLD;RED>status        - show paths with changes
     -+	update        - add working tree state to the staged set of changes
     -+	revert        - revert staged set of changes back to the HEAD version
     -+	patch         - pick hunks and update selectively
     -+	diff          - view diff between HEAD and index
     -+	add untracked - add contents of untracked files to the staged set of changes<RESET>
     -+	<BOLD>*** Commands ***<RESET>
     -+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
     -+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
     -+	<BOLD;BLUE>What now<RESET>> 
     -+	Bye.
     -+	EOF
     -+	test_write_lines h | GIT_TEST_PRETEND_TTY=1 git add -i >actual.colored &&
     -+	test_decode_color <actual.colored >actual &&
     -+	test_i18ncmp expect actual
     -+'
     -+
     - test_done

-- 
gitgitgadget
