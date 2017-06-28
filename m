Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7105B1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdF1QsU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 12:48:20 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35295 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdF1QsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 12:48:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id c73so36293971pfk.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XW1CIMlPr4/PhK0UVF5tlAMuif4HqWTc0cqOwjzcFEg=;
        b=Zzi7qGuLgbQ+0zphyw7EjP8bUR3ZVhpU1O4wRtGURdo9TKSuH1eJ0lMl+fVH/IuDyU
         FcXx/9ZJ7LqwDGWbZzcKXHrkiiBfSrXh3/XtSjob2NrTuWBLi5lmCq/yTkqykyrYipQ8
         HnQy0PA7vYksj9iOWqRmSRUDYbpFVzAI6L4/Wj8VTFdUyblEAUwcXOay+QHemy12HXdV
         2b4RJXCgvljS0ax0PszNqjvft3LvfYDuhnb09S6XjYS4qpsv4UkGySv5+mExW3VlhbfV
         /cCA7i7w1JpTv+bw0LFUoslMNPf6uFDNjPT3nZ3mEGnxD842GytwDADruMrAnrWNn51O
         G1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XW1CIMlPr4/PhK0UVF5tlAMuif4HqWTc0cqOwjzcFEg=;
        b=RVEqn2CNXiz/t9zy3l1wfDrR5gUcfDAlKEKfkZrva5lB85F5iMMG1X2UOB285OB43u
         cpwlTtupfShEshNWcoO1Z0zXYPK7OgP0i4U/Dbt9hzmYeoouzyGYpnhk1xY1rvKKMMGc
         1m4aBpUkhqP2wW0Xd+YTxrnHgGQla/5UkGwsSX+ftAPD4VTYQ2KquXLss/w61/2Ufx+1
         HWC2kr3ImmA5r2FxncVto1VEHOACwkQM1TMiN0BcuTVYn5pyGckZY1/y95cqE65lcRnY
         QF1HK1wNQECemYqgNsNVNAp7sIZvM/OqRKDQtvs8w7GJCEHiG3ET/RLwRoLTHSLQngB4
         RPvg==
X-Gm-Message-State: AKS2vOw/eH2/nwD+t5PnroYVP7wFAhLs0j6o1pfnucuz0gbFTzgqQSXI
        4OxesKb9YWpZOsC5s1A=
X-Received: by 10.98.81.129 with SMTP id f123mr11897927pfb.195.1498668497283;
        Wed, 28 Jun 2017 09:48:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id c19sm5990320pfj.15.2017.06.28.09.48.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 09:48:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-template: improve readability of commit template
References: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
        <20170628132910.7940-1-kaarticsivaraam91196@gmail.com>
Date:   Wed, 28 Jun 2017 09:48:15 -0700
In-Reply-To: <20170628132910.7940-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 28 Jun 2017 18:59:10 +0530")
Message-ID: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The commit template adds the optional parts without
> a new line to distinguish them. This results in
> difficulty in interpreting it's content. Add new
> lines to separate the distinct parts of the template.
>
> The warning about usage of 'explicit paths without
> any corresponding options' has outlived it's purpose of
> warning users about the usage '--only' as default rather
> than '--include'. Remove it.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  builtin/commit.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

I think I can agree with both of the changes, but this commit does
two things that may be better done in two separate commits.  If I
were doing this patch, I probably would make [PATCH 1/2] about
removing the only_include_assumed (which is all except for the hunk
at -877,8) and then [PATCH 2/2] about giving a separating blank line
before the "git status" output.


> The warning about usage of 'explicit paths without
> any corresponding options' has outlived it's purpose of
> warning users about the usage '--only' as default rather
> than '--include'. Remove it.

With a bit more digging of the history:

    The notice that "git commit <paths>" default to "git commit
    --only <paths>" was there since 756e3ee0 ("Merge branch
    'jc/commit'", 2006-02-14).  Back then, existing users of Git
    expected the command doing "git commit --include <paths>", and
    after we changed the behaviour of the command to align with
    other people's "$scm commit <paths>", we added the text to help
    them transition their expectations.  Remove the message that now
    has outlived its usefulness.

perhaps.

Thanks.


> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8d1cac062..22d17e6f2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -139,7 +139,6 @@ static enum commit_whence whence;
>  static int sequencer_in_use;
>  static int use_editor = 1, include_status = 1;
>  static int show_ignored_in_status, have_option_m;
> -static const char *only_include_assumed;
>  static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
> @@ -841,9 +840,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				  "with '%c' will be kept; you may remove them"
>  				  " yourself if you want to.\n"
>  				  "An empty message aborts the commit.\n"), comment_line_char);
> -		if (only_include_assumed)
> -			status_printf_ln(s, GIT_COLOR_NORMAL,
> -					"%s", only_include_assumed);
>  
>  		/*
>  		 * These should never fail because they come from our own
> @@ -877,8 +873,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				(int)(ci.name_end - ci.name_begin), ci.name_begin,
>  				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
>  
> -		if (ident_shown)
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
>  
>  		saved_color_setting = s->use_color;
>  		s->use_color = 0;
> @@ -1208,8 +1203,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>  	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>  		die(_("No paths with --include/--only does not make sense."));
> -	if (argc > 0 && !also && !only)
> -		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
>  	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
>  		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
>  	else if (!strcmp(cleanup_arg, "verbatim"))
