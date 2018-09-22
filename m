Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C8F1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeIWBYD (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 21:24:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45117 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIWBYD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 21:24:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so13236195eda.12
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k2LPhbglgFAqV/d4/p4ECS/seKyfW+mrgKegH3kIX/Q=;
        b=RyBjlFlZKvqpsx/Oon3KTOv/wL4m2rpc+xx742KoPwhOYwWeJlLlWaYn6q+2hZkv/T
         242VYZAZ3/NT8ALdeGL53YqD1Rblpd9OWapB9q1ey1QVbvF9WxRbMAomIf4VvvFiS53Q
         783A6cUzb2gEK6yYi8wRF0NfJYxF7hN6tKRK2nOwYUEWiubWt+oqE88umsqJB8rcMKwA
         VBflPZsbSuY+H2TscoOOcMKnyNUZKwLSZD9IRlH0Bsatd7lxYWLH486xsSLNRoJaUl01
         xOizn9ks6pCoF9g8uNi+Faxf8ORKWCM6MBjjcVk9LjZE2UbfSeJ7qyOUudKuLXguhcSZ
         FXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=k2LPhbglgFAqV/d4/p4ECS/seKyfW+mrgKegH3kIX/Q=;
        b=q8dhhTpAFrq4Bay1qzUK2kHlypHw/TzuGsVcp2ox4acM+hw9Srx0vvYsZqPHFNRiCI
         AZLMBCCfA5kPHAvYs2ExB3OG+qkVvicEAoIdOiZbbECFJhl5negfUrot/1Fj4YeaWMdh
         wa9tcmSs79TBC8KWxgyxnbOmkliHWZJiMQ93D9icnuBD83XucLqr/iu+uLhY2C62rmOM
         A+G3eUoAFvxMy0UsJC+SpwVZad772vd4WTmTHdvF+kzviL8sDS9VKfy5IK9QQP8Tb0Yk
         6V82Vn2qiqya8YbYWg8bjVA/yzGYiyaquBUWATFsc8iWzulie8V6ffaEyuTUHMCEHtt7
         NPDA==
X-Gm-Message-State: ABuFfoj/uV9i0Gbo8jugaYLCygOe8/QTOBZnWA1QGmeTxQyUBllNdBzW
        DV1opD+Sv2Lm3WblQipHnYE=
X-Google-Smtp-Source: ACcGV60IQsMOftFlZCrYOhJk/VC5m1tM+k6pHR/fs74o3R4weuRdhot5nXJtQQCLSSMf82XiSFuz8w==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr5763965eds.27.1537644561711;
        Sat, 22 Sep 2018 12:29:21 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id s36-v6sm5890037edb.56.2018.09.22.12.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 12:29:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git help: promote 'git help -av'
References: <20180922174707.16498-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180922174707.16498-1-pclouds@gmail.com>
Date:   Sat, 22 Sep 2018 21:29:18 +0200
Message-ID: <87fty1jppt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 22 2018, Nguyễn Thái Ngọc Duy wrote:

> When you type "git help" (or just "git") you are greeted with a list
> with commonly used commands and their short description and are
> suggested to use "git help -a" or "git help -g" for more details.
>
> "git help -av" would be more friendly and inline with what is shown
> with "git help" since it shows list of commands with description as
> well, and commands are properly grouped.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index a6f4b44af5..69c21f378b 100644
> --- a/git.c
> +++ b/git.c
> @@ -31,7 +31,7 @@ const char git_usage_string[] =
>  	   "           <command> [<args>]");
>
>  const char git_more_info_string[] =
> -	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
> +	N_("'git help -av' and 'git help -g' list available subcommands and some\n"
>  	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
>  	   "to read about a specific subcommand or concept.");

A side-effect of this not noted in your commit message is that we'll now
invoke the pager, perhaps we should just do:

    diff --git a/builtin/help.c b/builtin/help.c
    index 8d4f6dd301..1a3b174aaf 100644
    --- a/builtin/help.c
    +++ b/builtin/help.c
    @@ -436,9 +436,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
            parsed_help_format = help_format;

            if (show_all) {
    +               setup_pager();
                    git_config(git_help_config, NULL);
                    if (verbose) {
    -                       setup_pager();
                            list_all_cmds_help();
                            return 0;
                    }
    @@ -460,8 +460,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
                    return 0;
            }

    -       if (show_guides)
    +       if (show_guides) {
    +               setup_pager();
                    list_common_guides_help();
    +       }

            if (show_all || show_guides) {
                    printf("%s\n", _(git_more_info_string));

Or is there a good reason we shouldn't invoke the pager for e.g. -g when
the terminal is too small (per our default less config)?

Another thing I noticed: We don't list -v in the git-help manpage, but
since we use OPT_VERBOSE it's supported.
