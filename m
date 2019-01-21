Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEBA1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfAUJNn (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38290 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAUJNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so15971062ede.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OV1zRCFKO0r2YPXDCcFFmnhQa/exQycigcw6qF7R6Xk=;
        b=nKtcGeW8oUzjOQf+9OrXuy63jUT+SdiFumYkhDBzsndE2BwFvh82ByREI/6O4fhNdu
         sM94gUoYFE+DdTKme9g4HFAfTviDi2z3wkJ+fg0KDGL8XjY2LDdneZxM/PR0OsBaOah3
         TvgOHAg/VNHGp0W8o/IzyHX5jAJF+UMmm1Xc0pvTCqgCN/jo5fyNAKTAFpePQ2HLdPqg
         laMiGuKwkqIczw0iRh8jm3/4KG3cpVBgppw04wa9aJ14kko4cXfXADxnmibNyRPts+/m
         8GiU8wl5h84HLaFSI4O0Dao9pa5uTkJlD8mr60KyUUNGozUVqAkX/GJoyahIa/hQLO0y
         15Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OV1zRCFKO0r2YPXDCcFFmnhQa/exQycigcw6qF7R6Xk=;
        b=Jj/4nOMXBMj7OM3q3SbFISyCUXFf82/MlvjSipomb3eIiaCRJpJVzy08ZqCsrOlciU
         iZRTpOjHCdjfPOnh085aaKz8idJd/NJbEj4Le//DO/MlKCfELUxxvMOQ25zvT/L/t+YO
         ftUit7YDTDaBKsnCXNyihR9pv6swMgyq2QnUwkxoiZagd/o3euj/mgIEUSkaeXOLGgXb
         +cJbWyB1qh+SB1zYgEwnb1Go3IbyqoHkD5gSx4kTk6SOeiNYm6e8ocx3DgkCf8/BlcIl
         BcKcozuWAjKEusox0x6RfyaL1MN+3WJVdjD1YhsbWReNTH+f4XI2cXBcGZO+8nqn85DO
         Brrw==
X-Gm-Message-State: AJcUuke9GnQe6Wkar/JI+diitdM2YSLz7jmGtOWkuHyt+UQAw+TSaaNv
        LHAwauLwqywvM6rEzRQSFg2JVgFY
X-Google-Smtp-Source: ALg8bN6ACnq6F9ZWXKQuwCvEFuvGnz9/YW0LpmT3mGLC3JM38r+P++fWUJKrcXru0HJiX2G834Y5tQ==
X-Received: by 2002:a50:8b26:: with SMTP id l35mr25200720edl.146.1548062020543;
        Mon, 21 Jan 2019 01:13:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm8840507edm.31.2019.01.21.01.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:39 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:39 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:32 GMT
Message-Id: <pull.103.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Slavica =?UTF-8?Q?=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/7] Turn git add-i into built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first version of a patch series to start porting
git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
a head start:
https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u

Changes since v2:

 * fixed translation misuse and avoided command names translation in 
   add_i_show_help

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
 add-interactive.c          | 263 +++++++++++++++++++++++++++++++++++++
 add-interactive.h          |  10 ++
 builtin.h                  |   1 +
 builtin/add--helper.c      |  43 ++++++
 diff.c                     |  36 ++---
 diff.h                     |  18 +++
 git-add--interactive.perl  |  15 +--
 git.c                      |   1 +
 t/t3701-add-interactive.sh |  24 ++++
 11 files changed, 379 insertions(+), 35 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 builtin/add--helper.c


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-103%2FslavicaDj%2Fadd-i-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/103

Range-diff vs v2:

 1:  737767b6f4 = 1:  737767b6f4 diff: export diffstat interface
 2:  91b1963125 = 2:  91b1963125 add--helper: create builtin helper for interactive add
 3:  d247ef69fe = 3:  d247ef69fe add-interactive.c: implement status command
 4:  4950c889aa = 4:  4950c889aa add--interactive.perl: use add--helper --status for status_cmd
 5:  cf4e913a5a ! 5:  581b108c9c add-interactive.c: implement show-help command
     @@ -23,24 +23,18 @@
      +void add_i_show_help(void)
      +{
      +	const char *help_color = get_color(COLOR_HELP);
     -+	color_fprintf(stdout, help_color, "%s%s", _("status"), 
     -+		N_("        - show paths with changes"));
     -+	printf("\n");
     -+	color_fprintf(stdout, help_color, "%s%s", _("update"), 
     -+		N_("        - add working tree state to the staged set of changes"));
     -+	printf("\n");	
     -+	color_fprintf(stdout, help_color, "%s%s", _("revert"),
     -+		N_("        - revert staged set of changes back to the HEAD version"));
     -+	printf("\n");
     -+	color_fprintf(stdout, help_color, "%s%s", _("patch"),
     -+		N_("         - pick hunks and update selectively"));
     -+	printf("\n");
     -+	color_fprintf(stdout, help_color, "%s%s", _("diff"),
     -+		N_("          - view diff between HEAD and index"));
     -+	printf("\n");
     -+	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
     -+		N_(" - add contents of untracked files to the staged set of changes"));
     -+	printf("\n");
     ++	color_fprintf_ln(stdout, help_color, "status        - %s",
     ++			_("show paths with changes"));
     ++	color_fprintf_ln(stdout, help_color, "update        - %s",
     ++			_("add working tree state to the staged set of changes"));
     ++	color_fprintf_ln(stdout, help_color, "revert        - %s",
     ++			_("revert staged set of changes back to the HEAD version"));
     ++	color_fprintf_ln(stdout, help_color, "patch         - %s",
     ++			_("pick hunks and update selectively"));
     ++	color_fprintf_ln(stdout, help_color, "diff          - %s",
     ++			_("view diff between HEAD and index"));
     ++	color_fprintf_ln(stdout, help_color, "add untracked - %s",
     ++			_("add contents of untracked files to the staged set of changes"));
      +}
      
       diff --git a/add-interactive.h b/add-interactive.h
 6:  2b4714b8d0 = 6:  aede733318 t3701-add-interactive: test add_i_show_help()
 7:  6ede6d9251 = 7:  b9a1a7e37a add--interactive.perl: use add--helper --show-help for help_cmd

-- 
gitgitgadget
