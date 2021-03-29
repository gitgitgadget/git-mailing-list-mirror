Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76393C433F1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558E96191B
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhC2NrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:47:09 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14141 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231546AbhC2Nqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:46:45 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lQsDu-0001ZE-G2; Mon, 29 Mar 2021 14:46:43 +0100
Subject: Re: [PATCH v3] column, range-diff: downcase option description
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Chinmoy <chinmoy12c@gmail.com>
References: <pull.920.v2.git.1616926582735.gitgitgadget@gmail.com>
 <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <bb5b4945-93f1-c0a9-5e7f-6b11525312f7@iee.email>
Date:   Mon, 29 Mar 2021 14:46:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Super minor nit - missing space after full stop.

On 29/03/2021 11:45, Chinmoy via GitGitGadget wrote:
> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>
> It is customary not to begin the help text for each option given to
> the parse-options API with a capital letter.Various (sub)commands'
s/Various/ Various/

--
Philip

> option arrays don't follow the guideline provided by the parse_options
> Documentation regarding the descriptions.
>
> Downcase the first word of some option descriptions for "column"
> and "range-diff".
>
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---
>     column, range-diff: downcase option description
>     
>     It is customary not to begin the help text for each option given to the
>     parse-options API with a capital letter.Various (sub)commands' option
>     arrays don't follow the guideline provided by the parse_options
>     Documentation regarding the descriptions.
>     
>     Downcase the first word of some option descriptions for "column" and
>     "range-diff".
>     
>     Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/920
>
> Range-diff vs v2:
>
>  1:  b032c2fa5b28 ! 1:  61be08b7dd73 Documentation: make (sub)command options conform to TD of option parsing
>      @@ Metadata
>       Author: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>       
>        ## Commit message ##
>      -    Documentation: make (sub)command options conform to TD of option parsing
>      +    column, range-diff: downcase option description
>       
>      -    The Git suite option parsing API's Technical Documentation suggests this
>      -    about the option descriptions of a (sub)command:
>      +    It is customary not to begin the help text for each option given to
>      +    the parse-options API with a capital letter.Various (sub)commands'
>      +    option arrays don't follow the guideline provided by the parse_options
>      +    Documentation regarding the descriptions.
>       
>      -    `description` is a short string to describe the effect of the option.
>      -    It shall begin with a lower-case letter and a full stop (.) shall be
>      -    omitted at the end.
>      -
>      -    Various (sub)commands' option arrays don't follow the guideline provided
>      -    by the parse_options Documentation regarding the descriptions.
>      +    Downcase the first word of some option descriptions for "column"
>      +    and "range-diff".
>       
>           Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>       
>
>
>  builtin/column.c     | 8 ++++----
>  builtin/range-diff.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/column.c b/builtin/column.c
> index e815e148aa18..40d4b3bee2dd 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -27,10 +27,10 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
>  		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
>  		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
> -		OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
> -		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding space on left border")),
> -		OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border")),
> -		OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between columns")),
> +		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
> +		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
> +		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
> +		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
>  		OPT_END()
>  	};
>  
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 78bc9fa77062..50318849d657 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  	struct option range_diff_options[] = {
>  		OPT_INTEGER(0, "creation-factor",
>  			    &range_diff_opts.creation_factor,
> -			    N_("Percentage by which creation is weighted")),
> +			    N_("percentage by which creation is weighted")),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
>  			    N_("use simple diff colors")),
>  		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>
> base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860

