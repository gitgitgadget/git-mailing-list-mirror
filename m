Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA99200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeEFOPZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:15:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43185 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeEFOPY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:15:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id j20so6508739pff.10
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gOzcY2YcmlhpYrXoeYxSZG5sa7Sf2iS+LiFcne83+84=;
        b=N8KYmKAK2Nn5zH0rk/LALV5smRgoEHc/ZYgqAlkOuCbQFCC9xq7vmlitOZbk9Mh1t8
         O2BEC0awCWH7dz5cPuWQKC9lb9vNGZGexbpgkiJGsVeBRejkKGTC4PIe/XzYhNAUcEj/
         W86q0IUEPB0Tfk27cy5IqeZh2jeh7CN2YsHU5liubFzlqGSoMLoe6UjsA7AZbiQ3tLUQ
         ImUGI1XH/dSEo+V+IHlMg1Vj6vgBjjbidwdTM3B964mR2sWbleUOWL6mfFbTMehhIFTC
         5upYCikRlpo9m/6Pr+QVqED7iYoERMV0aF8ckcXa2eX40KLQEGtbqFGn+khoRfgwOFzo
         2Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gOzcY2YcmlhpYrXoeYxSZG5sa7Sf2iS+LiFcne83+84=;
        b=QWnGVCD8JE1qSf7mXMWGM3ApfQotu93qI379cJtUIv5xFv34NmtJ7Vm3jiAQhCS/xL
         sGA6ziqb5nECsd/O4KcYzi23Zbx0vL3wlWe5iEI1g76pfPFUk3f8W9XwGahqe/p5jAhf
         E6K+ZgFBvF4Ic4dxhsk5epcghxmtGizo9HJD5aYP+uBDNLOCohzv/yrAz7vXOZCGz/ty
         FeUNArUAokOb1l+akWudvKfpmaxONF9ihr/OqhChS5j2mcYEQ13XwfGzptvPOO5FlJPe
         VThL1Lezlc5k8R1ig47wFbL4uy38+WXy8DVuHSrccaoiqyoDV3JTrK4I64y9H6RaHUCc
         tzkg==
X-Gm-Message-State: ALQs6tC2U5yRiKrWEBbpG/d4gCHPYrQV6S67FLgrI1c2Ytr5/SeNlnOb
        YE7Wt4fd3RO5w4Wmi4Q8vwUtSXoyz5muZm92K9I=
X-Google-Smtp-Source: AB8JxZon3NaShWK0rcIfz/Lk5uKt+3z7JbW2myx9AYk+QDWvIG2uo/QLcqljoEPpAZMszN1EFHc1GQfadG+6xMc+f0w=
X-Received: by 10.98.11.3 with SMTP id t3mr33694128pfi.32.1525616123880; Sun,
 06 May 2018 07:15:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 07:15:23 -0700 (PDT)
In-Reply-To: <c856c460a47dbe885bbb82babc6be6848d31ed32.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <c856c460a47dbe885bbb82babc6be6848d31ed32.1525448066.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 6 May 2018 16:15:23 +0200
Message-ID: <CAN0heSoLD0O9owCDEU5ZHje3zNDLAS_43atb75Te7KOFoS_dtA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] branch-diff: indent the diffs just like tbdiff
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 May 2018 at 17:34, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> @@ -353,6 +358,7 @@ static void output(struct string_list *a, struct string_list *b,
>  int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>  {
>         struct diff_options diffopt = { NULL };
> +       struct strbuf four_spaces = STRBUF_INIT;
>         double creation_weight = 0.6;
>         struct option options[] = {
>                 OPT_SET_INT(0, "no-patches", &diffopt.output_format,
> @@ -371,6 +377,9 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>
>         diff_setup(&diffopt);
>         diffopt.output_format = DIFF_FORMAT_PATCH;
> +       diffopt.output_prefix = output_prefix_cb;
> +       strbuf_addstr(&four_spaces, "    ");
> +       diffopt.output_prefix_data = &four_spaces;
>
>         argc = parse_options(argc, argv, NULL, options,
>                         builtin_branch_diff_usage, PARSE_OPT_KEEP_UNKNOWN);

You end up leaking the buffer of `four_spaces`. Granted, that's not a
big memory leak, but still. ;-) This was the only leak that
LeakSanitizer found in v2 when running the new test-script and playing
around with this a bit. This looks really good!

Martin
