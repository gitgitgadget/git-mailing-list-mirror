Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925FF1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHAWeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:34:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43659 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHAWeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:34:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so133011edt.10
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CnHbWbIX6dt5GOZR2zwyIiA3E8wzJytfQFcA9YqSzqY=;
        b=a0buzUP7e2NCb3ZmtvEPAbjABAiM6oLrSo0DB5EPDyjZmFnMjrsbuCM2B5Jpz2Zyc3
         L0Q2jTF35vNoKbzVlvJnMpGBYlZM6X1x2lN63vUDI9eAigm7N4FR1c1ZLLtQjEhukykl
         1WAUxtZnh/6QfUjY34/scDHdPD+giz+ZYEvdh8OBCgMTDddvS3D+uQZAi03o135zdTtL
         FDxZ5Wv5IiTOiYvDsjpXrzBmPjkrhvDEu8zaEK06E6KwNh8ZCmody3BgZzh1G65zKxwb
         ymLc0ovFBAEVmCdjYL3ltRTn9pJheVW+fMP/EJXfU6seQWe+UKPj096eOD6A5PJoh9MK
         R8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CnHbWbIX6dt5GOZR2zwyIiA3E8wzJytfQFcA9YqSzqY=;
        b=gOmfksQRmGtREwtnVrndf+i1l81VMVGi7Ae0iKT3WpOHH9zuoUPL0WlagJLO8kbe+0
         JX/tNsgaWXwZrqvIMYX9M0Bskgh9rhv2Y8de9Y1G4TItApPl7HzrzJpbrWiVbsO8V6YI
         Bx3X8bymrM3ySRqhbTVkVG7JxJAlXOSnMK+BvCw2Z3qTJWyE+Er0YVp5PD9U3YVNuvd9
         wEBDDEYBgjmYMnKPjZgmAE8q0kki1gfCIAYKUYxXtOyrLCAif0KJVZSWTvhJH+L6MZ/9
         7GaWU4114PBa02Es1FgIzbxQf9uCYrgYalh2TcQpjrO+sKvVqkWc1XHtCrI3eCFdMVfr
         E3IQ==
X-Gm-Message-State: AOUpUlHz61dCKn8wA2bhdhfUFhDkM5aBAqARC6IVQF2l86FiNtlvMkC4
        pJWBqOcOJU9bfq7jvVIQ694=
X-Google-Smtp-Source: AAOMgpfx8WZWqcEzU0EqbNGuAyAONSgR/uuRQiTEFvHNhRR+AGPjWEJ8jL2osRKFtPbr9zdPc2Uzog==
X-Received: by 2002:a50:9356:: with SMTP id n22-v6mr371701eda.206.1533156392772;
        Wed, 01 Aug 2018 13:46:32 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id 8-v6sm91650edv.77.2018.08.01.13.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 13:46:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 01 Aug 2018 22:46:31 +0200
Message-ID: <87k1p9u860.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 01 2018, Junio C Hamano wrote:

> The option help text for the force-with-lease option to "git push"
> reads like this:
>
>     $ git push -h 2>&1 | grep -e force-with-lease
>        --force-with-lease[=<refname>:<expect>]
>
> which come from this
>
>  		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>
> in the source code, with an aparent lack of "<" and ">" at both
> ends.
>
> It turns out that parse-options machinery takes the whole string and
> encloses it inside a pair of "<>", expecting that it is a single
> placeholder.  The help string was written in a funnily unbalanced
> way knowing that the end result would balance out.
>
> Add a comment to save future readers from wasting time just like I
> did ;-)

There's something worth fixing here for sure...

> +		  /* N_() will get "<>" around, resulting in "<refname>:<expect>" */

...but this comment isn't accurate at all, N_() doesn't wrap the string
with <>'s, as can be seen by applying this patch:

    -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
    +                 0, CAS_OPT_NAME, &cas, "refname>:<expect",

Resulting in the same output:

    $ ./git --exec-path=$PWD push -h 2>&1 | grep -e force-with-lease
        --force-with-lease[=<refname>:<expect>]

Rather, it's the usage_argh() function in parse-options.c that's doing
this. Looks like the logic was added in 29f25d493c ("parse-options: add
PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).

Also because of this I looked at:

    $ git grep -P 'N_\("<'

Which shows e.g.:

    builtin/difftool.c:706:         OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
    builtin/difftool.c:714:         OPT_STRING('x', "extcmd", &extcmd, N_("<command>"),

Producing this bug:

    $ git difftool -h 2>&1|grep '<<'
        -t, --tool <<tool>>   use the specified diff tool
        -x, --extcmd <<command>>

But these all do the right thing for some reason, just looked briefly
and didn't see how they're different & manage to avoid this:

    builtin/read-tree.c:134:                { OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
    builtin/show-branch.c:673:              { OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
    builtin/update-index.c:969:                     N_("<mode>,<object>,<path>"),
    builtin/write-tree.c:27:                { OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
