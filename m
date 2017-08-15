Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128B9208C4
	for <e@80x24.org>; Tue, 15 Aug 2017 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbdHORhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:37:39 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37827 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbdHORhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:37:38 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so9572130pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=blL0rZO7UY9yabBckz7tSvrHC9+FWEnXTC9/IXztOSg=;
        b=K/68vxgPb0kh21i0a/emvoBLrxqMXzTqWQOzIYpfZpfJRY8Rh5VqZ5ehH7ysfdhF1u
         ed+yTBqHAWKRP9YzkppTvETYMkuDVY5FIGF7YhzyPCO+N+AV7ua7+S75Nr/zzZw2xplF
         RH8jIyWO3epiDL6d5GeDltfA0qH64bNXICkdqIaXeWyqTblg/adB06d3mmWf+dHcA3pD
         D4Vg8YG0KP7gPJPWVGXpTX9JB9Pps7OXNRoK17KoQDj/9FIfDdRY6uIGNMxmZD58ZaXT
         yYHIYlQXs82lEEI6lKhWc0V9F5P+PeIhQfVPBZZswomyCj1P5dHoWoYlgTYTmmFjYU/Z
         Johw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blL0rZO7UY9yabBckz7tSvrHC9+FWEnXTC9/IXztOSg=;
        b=qkrJf/5CYASHzFtuFGBoHBgkvRnbZUxpcISheVeIo7UT7wEsv23o3/2emY5Dqu19kz
         ZYXaYsNJX0kQcdEMwk0NzvGb7tAOeSpBQdiqUPyNa9fnEfpwCxGssUClPGMmBmJN0JF/
         2XSJvbqW1K+FgUHaVR2Asmvo/X6RHtWByT3kArhD8KN860stdYXsU289sNA92tXJxJ31
         0cPzUFrndTRJjrTOh5JenodcEMaNTVmiWa6N+VmE1JaWFIyIbtrgPaO2iNhEuHhLcEI4
         I++WehNv3TGZwvbtTqVwc+Ed5f+x1Lq5QVBVbYEk+7JGeCuNa5e6Eoelg7UQtETeNg7z
         iFbw==
X-Gm-Message-State: AHYfb5hjg8YjmnHIy6iMuqkjCvCqD8QvWSekoqNZQxwsP+5jiJGwBkZ7
        IDy/iQ4idDAszt4YUCOURA==
X-Received: by 10.98.91.3 with SMTP id p3mr5828052pfb.20.1502818657795;
        Tue, 15 Aug 2017 10:37:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:593a:8ead:b053:9e22])
        by smtp.gmail.com with ESMTPSA id j73sm3116183pfa.117.2017.08.15.10.37.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 10:37:36 -0700 (PDT)
Date:   Tue, 15 Aug 2017 10:37:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
Message-ID: <20170815173735.GB21874@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
 <CAGZ79kau6_XeEQqYDhFC2FmyJiqWY2+SuRzvGFrfmLdhAaQS+Q@mail.gmail.com>
 <41c8c119-af98-f16f-1585-81b29429afe8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c8c119-af98-f16f-1585-81b29429afe8@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/15, Ben Peart wrote:
> 
> 
> On 8/14/2017 6:02 PM, Stefan Beller wrote:
> >On Mon, Aug 14, 2017 at 2:30 PM, Brandon Williams <bmwill@google.com> wrote:
> >>Add a '.clang-format' file which outlines the git project's coding
> >>style.  This can be used with clang-format to auto-format .c and .h
> >>files to conform with git's style.
> >>
> >>Signed-off-by: Brandon Williams <bmwill@google.com>
> >
> >Applying this patch and running
> >     clang-format -i -style file *.c *.h builtin/*.c
> >produces a diff, that I'd mostly agree with.
> >This style guide is close to our current style.
> >
> 
> I'm happy to see progress being made in helping reduce the time
> spent manually reviewing and fixing style formatting errors.  In an
> effort to help, I installed this in Windows and tried it as well.
> The tools all appear to be working fine and are supported on
> Windows.
> 
> For the most part, the formatting rules look pretty consistent with
> the existing style.  I ran the same test and looked at the diffs and
> saw a couple of things that looked odd. For example, how it wrapped
> the "static int" on the function header below was different.  Not
> sure why as it didn't wrap all the other function headers the same
> even later in the file it didn't do that with "static void
> mute_routine"
> 
> diff --git a/apply.c b/apply.c
> index f2d599141d..bb77242e3d 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -58,12 +59,11 @@ static int parse_whitespace_option(struct
> apply_state *state, const char *option
>         return error(_("unrecognized whitespace option '%s'"), option);
>  }
> 
> -static int parse_ignorewhitespace_option(struct apply_state *state,
> -                                                const char *option)
> +static int
> +parse_ignorewhitespace_option(struct apply_state *state, const char
> *option)
>  {
> -       if (!option || !strcmp(option, "no") ||
> -           !strcmp(option, "false") || !strcmp(option, "never") ||
> -           !strcmp(option, "none")) {
> +       if (!option || !strcmp(option, "no") || !strcmp(option, "false") ||
> +           !strcmp(option, "never") || !strcmp(option, "none")) {
>                 state->ws_ignore_action = ignore_ws_none;
>                 return 0;
>         }
> 
> 
> Later in the file it wraps some of them again: (add_line_info,
> prepare_image, find_name_common, etc).  Again, it appears to be
> inconsistent but there must be some rule that is causing this
> behavior.

These have to deal with setting the penalties.  When a line gets to be
too long the tool needs to find a place to break the line based on a
penalty system.  The current .clang-format file I sent out has values
for the penalties which would most likely need to be tweaked through
trial and error.

> 
> 
> 
> Here is an example of how it wrapped bit fields differently.  Again,
> it didn't seem to be consistent with itself as just below this, it
> left them on separate lines.
> 
> 
> @@ -182,8 +185,7 @@ struct fragment {
>          * but some codepaths store an allocated buffer.
>          */
>         const char *patch;
> -       unsigned free_patch:1,
> -               rejected:1;
> +       unsigned free_patch : 1, rejected : 1;
>         int size;
>         int linenr;
>         struct fragment *next;

If the return type was replicated then it would probably format the
different struct members on their own line.

> 
> 
> Big thanks to those working on this!
> 
> >As noted in patch 2/2 we'd now need an easy way to
> >expose this for use in various situations, such as
> >* contributor wanting to format their patch
> >* reformatting code for readability
> >
> >Thanks,
> >Stefan
> >

-- 
Brandon Williams
