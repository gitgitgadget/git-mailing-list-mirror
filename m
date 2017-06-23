Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE47A207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754768AbdFWV73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:59:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34349 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754667AbdFWV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:59:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so15516990wrc.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=c6VkpGxZkPnOxBTvpNUZOeiMOo0D+LeVAHqJaCoYVJc=;
        b=IAIljFh0iRo8Xi9FeLNoPDZf/KpOdtmNhSwKy/HJ3yGsCxIQeQ9ja4gBdpkTd0L/Ps
         tXETNaB4/P5j2ZsOlddhBYdSqMNJfVs20tSz2kcOD0mZF2EtfTQKwKOK8jqqWZRyjnka
         aR+6nI9WxmNVq16l/sUfBUUQkOD6VRAZOXkcCSEXPll+85M9GvUYhic6UqQ3MNF2PTyD
         O+7U9Dy/vvw9zYrmW/GH2MleA6PNNG4Y2+EYiq2wu2bhzd6irOBIAmfEaWePxkiUut/P
         jCIWT2jVTVf8Z81mk6ahxpdXjIgg1kzpj8oT+PTVohBW0RroUJQNDoL0ahZCOPPwGIhX
         V2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=c6VkpGxZkPnOxBTvpNUZOeiMOo0D+LeVAHqJaCoYVJc=;
        b=a+GTqKsFo8tPGgoEwEGa+iW2C801PEAUKZO9yRu8JWqvFx6TE7R4PQbLq0lQCVZz84
         iiK9bu7s89h3Up3b38uVLWH5pJBS6ZotIlAMaOoyOxLoCtjXW+v4EGfTaJr383/23Ch9
         Vw/zfLRpgUncJBc8NzV9tVZgl9P1CHSS2kzYOTsHYPPQiGZKlcXJnPwf7EqYXGudgZwc
         eEhU5m/kEGcNmiG2tK4y6Mp3+0MyYgdXos0h/897NCPU71y5Uy77YKwXGzF0hKH/BFZw
         XXh2N8gQ2YAT51phJ+OnPyAe/DoSmBjZj07kNlpknw1rmcHRIMRZxHkJfs+5Xwi4Gphz
         UNGg==
X-Gm-Message-State: AKS2vOzNQM9euHj1ggu7jEygKcQ1B5uKmd93HDR+UWdxgFuq/ue4Fs/L
        uzQ97G3+P9VLdg==
X-Received: by 10.80.179.209 with SMTP id t17mr7516484edd.62.1498255166845;
        Fri, 23 Jun 2017 14:59:26 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id j29sm2616833eda.26.2017.06.23.14.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 14:59:25 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOWbt-0004v6-9G; Fri, 23 Jun 2017 23:59:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 23:59:25 +0200
Message-ID: <871sqajrgi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 22 2017, Junio C. Hamano jotted:

> * sb/diff-color-move (2017-06-21) 25 commits
>  - diff: document the new --color-moved setting
>  - diff.c: add dimming to moved line detection
>  - diff.c: color moved lines differently, plain mode
>  - diff.c: color moved lines differently
>  - diff.c: buffer all output if asked to
>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
>  - diff.c: convert word diffing to use emit_diff_symbol
>  - diff.c: convert show_stats to use emit_diff_symbol
>  - diff.c: convert emit_binary_diff_body to use emit_diff_symbol
>  - submodule.c: migrate diff output to use emit_diff_symbol
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS{_PORCELAIN}
>  - diff.c: migrate emit_line_checked to use emit_diff_symbol
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
>  - diff.c: introduce emit_diff_symbol
>  - diff.c: factor out diff_flush_patch_all_file_pairs
>  - diff.c: move line ending check into emit_hunk_header
>  - diff.c: readability fix
>
>  "git diff" has been taught to optionally paint new lines that are
>  the same as deleted lines elsewhere differently from genuinely new
>  lines.
>
>  Is any more update coming?

I guess here's as good a place for feedback is any, this feature's
great, but I discovered some minor warts in it:

This is good:

    $ ./git --exec-path=$PWD show --color-moved=crap
    fatal: bad --color-moved argument: crap

This is bad:

    $ ./git --exec-path=$PWD -c diff.colorMoved=crap show
    fatal: unable to parse 'diff.colormoved' from command-line config

Fixed with:

    diff --git a/diff.c b/diff.c
    index 7cae4f1ddb..036dbc1c3c 100644
    --- a/diff.c
    +++ b/diff.c
    @@ -278,7 +278,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
            if (!strcmp(var, "diff.colormoved")) {
                    int cm = parse_color_moved(value);
                    if (cm < 0)
    -                       return -1;
    +                       die("bad --color-moved argument: %s", value);
                    diff_color_moved_default = cm;
                    return 0;
            }

But I'm not familiar enough with the code to say if just dying here, as
opposed to returning -1 is OK or not.

Also, I think something like this (very lighty tested) patch on top
makes sense:

    diff --git a/diff.c b/diff.c
    index 7cae4f1ddb..d195d304d3 100644
    --- a/diff.c
    +++ b/diff.c
    @@ -257,6 +257,15 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)

     static int parse_color_moved(const char *arg)
     {
    +       int v = git_parse_maybe_bool(arg);
    +
    +       if (v != -1) {
    +               if (v == 0)
    +                       return COLOR_MOVED_NO;
    +               else if (v == 1)
    +                       return COLOR_MOVED_PLAIN;
    +       }
    +
            if (!strcmp(arg, "no"))
                    return COLOR_MOVED_NO;
            else if (!strcmp(arg, "plain"))

I don't want to set this to a specific value, just "true" and it should
pick whatever the default is (and that in the config yields a very bad
error message, hence the first patch).

If you don't want to have a default for whatever reason I think the docs
need to change:

    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 1ab7bdfb49..4b6f8c6d5c 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -1085,8 +1085,9 @@ This does not affect linkgit:git-format-patch[1] or the
     command line with the `--color[=<when>]` option.

     diff.colorMoved::
    -       If set moved lines in a diff are colored differently,
    -       for details see '--color-moved' in linkgit:git-diff[1].
    +       If set to a valid `<mode>` moved lines in a diff are colored
    +       differently, for details of valid modes see '--color-moved' in
    +       linkgit:git-diff[1].

     color.diff.<slot>::
            Use customized color for diff colorization.  `<slot>` specifies

Right now the lazy reader (i.e. me) just reads "if set...<blah blah>"
tries it out, and then gets a cryptic error. "If set" to me immediately
sounds like a bool variable (but then I read the diff docs and found
it's not). So with that bool parsing it could be changed to:

    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 1ab7bdfb49..e62d926740 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -1085,8 +1085,10 @@ This does not affect linkgit:git-format-patch[1] or the
     command line with the `--color[=<when>]` option.

     diff.colorMoved::
    -       If set moved lines in a diff are colored differently,
    -       for details see '--color-moved' in linkgit:git-diff[1].
    +       If set to either a valid `<mode>` or a true value, moved lines
    +       in a diff are colored differently, for details of valid modes
    +       see '--color-moved' in linkgit:git-diff[1]. If simply set to
    +       true the default color mode will be used.

     color.diff.<slot>::
            Use customized color for diff colorization.  `<slot>` specifies
