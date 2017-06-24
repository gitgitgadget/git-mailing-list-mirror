Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249FD20401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbdFXSXn (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:23:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34738 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdFXSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:23:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id d5so12208940pfe.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q4FBcbYdd3B4g0QzypM22ENDgZsJTr0Ijskb1WJUF7o=;
        b=o3ujOCqUdHH13q3wByRf9ZCbgWJKAnjNNJdNNrnDj5zgs1gO4oviXdrDu3I3yzzhZf
         KMVabeuqxVPOGaNWB8RQl1v7Tld+HImcusEoN/ALPGckDBijxl3bXoodlsG+KZMOa5zO
         c7xbA1daOL1L3Wc65khZTXhj2KXYXVBVXtZ3YwcKrDE5cWcn2gDV06cMtAqQwuItp6Io
         6LZqF2w2dWX8w1VIHSEcq5fFi1c/9OO6RC5wHMcRL2LdBGP5+QSVaAQdE3icunENCJht
         ZP6RPIubcQlr+EBJhDqdOIPvGcw3P75Xt9yFSmswVrqx3AT4F/gwfsO15FzVSqdG/8Qe
         WogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q4FBcbYdd3B4g0QzypM22ENDgZsJTr0Ijskb1WJUF7o=;
        b=LBh7oEjUQU4WjUxE9OHixfTYG1oK75BCtX1vtlTmGrhEsxD1Vapid412iOgvcnZmZO
         t1DL3Mpy+hUHgzyOAj/v4ralk/Pfhqd/AlLStMnSrvpEKcT+ZAEbfKcnfQ3Tv+c8LkuJ
         N7fQOTao8QrXKVUfSUMOVBR8inDP1r1INcYp4iGJnelJ8QaLva+Daqsuf87QeCtFqBal
         P9p8b4qoH2DdqMUF8GNYcEHwSeAKBtfOpHZgz2HAZ0smA+t85MYrWN6dfVNbGBjCYPz0
         Ts9BXKMGlGgBPUhIJEPejN44h5i3u1KmrYcQPBU+qcdscJJQa0x/5Pf4pbvEdXIEG44X
         OD6A==
X-Gm-Message-State: AKS2vOwPNZY2s/dVglUwQSGCTuvQHA26xgn6wEfdPyG9B+VK3ahJrWMR
        ZcNLXHULFPodww==
X-Received: by 10.101.88.133 with SMTP id d5mr2564765pgu.255.1498328622345;
        Sat, 24 Jun 2017 11:23:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id d15sm2778569pgt.44.2017.06.24.11.23.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:23:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify syntax for %C(auto,...) in pretty formats
References: <20170624072258.6832-1-asheiduk@gmail.com>
Date:   Sat, 24 Jun 2017 11:23:40 -0700
In-Reply-To: <20170624072258.6832-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Sat, 24 Jun 2017 09:22:58 +0200")
Message-ID: <xmqqfuep9rdf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> The change actually adds only 
>
> 	(e.g. `%C(auto,red)`)
>
> but reflowing the paragraph blows it up a little.

In such a case, you can avoid re-flowing and make the resulting
lines of a-bit uneven lengths.

The end result can be checked with "git diff --word-diff", so do not
worry too much about this either way, as long as the real change is
small.

Thanks.

>
> -------- 8< --------
> The manual correctly describes the syntax with `auto,` but the
> trailing `,` is hard to spot in a terminal.  The HTML format does not
> have this problem.  Adding an example helps both worlds.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 38040e95b..b03985101 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -174,11 +174,12 @@ endif::git-rev-list[]
>  - '%Creset': reset color
>  - '%C(...)': color specification, as described under Values in the
>    "CONFIGURATION FILE" section of linkgit:git-config[1];
> -  adding `auto,` at the beginning will emit color only when colors are
> -  enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
> -  respecting the `auto` settings of the former if we are going to a
> -  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
> -  on the next placeholders until the color is switched again.
> +  adding `auto,` at the beginning (e.g. `%C(auto,red)`) will emit
> +  color only when colors are enabled for log output (by `color.diff`,
> +  `color.ui`, or `--color`, and respecting the `auto` settings of the
> +  former if we are going to a terminal). `auto` alone (i.e.
> +  `%C(auto)`) will turn on auto coloring on the next placeholders
> +  until the color is switched again.
>  - '%m': left (`<`), right (`>`) or boundary (`-`) mark
>  - '%n': newline
>  - '%%': a raw '%'
