Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FF21F453
	for <e@80x24.org>; Wed,  1 May 2019 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEAO6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 10:58:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41588 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfEAO6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 10:58:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so15128743edd.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IdU9kiPd2xUEIUrmh+Y1kxpBlZPWnQU+K4AvgSX1sz8=;
        b=tKZThdboYfr/2OlsFzjtCPsG8pFElqQg5Az1jP0HdBVZGpb7mWuJyZkF5TXDX4QJG9
         VDQlfWdEqQB0jvNe20+JSZ+10kggAKP/9ZwzJC1Xs+MiUKU1WuIyD+retoKGWvZB83P1
         8TOqQr8EvEQL/DJOHUbssPXiDw3wv+EMlF9rn8CUqP5FO6NPmUPfvPuff5+teGhzkCN1
         C5/42FhmM3EK9F20dcIxapG2O7mB1T4tRgoy8F0lqM378apqVf/n8/O+fth+BGUDwKc2
         gKC0KW9mPagaSlmPEneq7JeWJZcWmZDf/b8zxdhU5QkNHlOUvG7ua5Z9v/uqLGy1z58n
         B0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IdU9kiPd2xUEIUrmh+Y1kxpBlZPWnQU+K4AvgSX1sz8=;
        b=nULb4h3z4o+T8EDqRIn0uJTY1lTR9SBt9wrtSXAssIc9/3TIy5SCOceYs144O7QCHP
         gD/O3x+ex3mo9TTEEblbpOAyKmgE+C9If4AuvSpClE3sa/Iw4gqi4IvLpblfBVqJlouO
         mHLkNH4sS/0tMd2D2eWVdXMsYUtc3Xy4x9Tg8+8Yixbh5K23BWe1Qh2xmrN0SE/PejCm
         2ECagsaO/QnqhgKCVEiH6LNY7QCkE06rYAmgeCS2hmI368mYgh1Hq4+zAQW+8Dm64LZQ
         4Q3Nx+sJuTsELNmHFjlzT8aWKBDPFZDQRoQutWmyk4AKtMbgAyESMtL9vW4iXKeDp27e
         Bf/g==
X-Gm-Message-State: APjAAAVMS1W2zj/jGQv2Ewr01Vk5T+8BVIff6WIlMBngdYv7JtB6f7in
        VgebTAEecb3U893sE4fEVmw=
X-Google-Smtp-Source: APXvYqz6lX5SDvozPKqTnEmGG/NBQCQkoBuomRgC/moXqY7WsKie/pwtESjBiK3fmezufEq2+zaa6Q==
X-Received: by 2002:a50:a953:: with SMTP id m19mr44616465edc.93.1556722727135;
        Wed, 01 May 2019 07:58:47 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id y21sm1919827eds.31.2019.05.01.07.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 07:58:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 6/6] commit-graph: remove Future Work section
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com> <e72bca6c784c5fc727ae4cf661526eec346c478c.1556716273.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <e72bca6c784c5fc727ae4cf661526eec346c478c.1556716273.git.gitgitgadget@gmail.com>
Date:   Wed, 01 May 2019 16:58:45 +0200
Message-ID: <87o94mql0a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 01 2019, Derrick Stolee via GitGitGadget wrote:

> The commit-graph feature began with a long list of planned
> benefits, most of which are now complete. The future work
> section has only a few items left.
>
> As for making more algorithms aware of generation numbers,
> some are only waiting for generation number v2 to ensure the
> performance matches the existing behavior using commit date.
>
> It is unlikely that we will ever send a commit-graph file
> as part of the protocol, since we would need to verify the
> data, and that is as expensive as writing a commit-graph from
> scratch. If we want to start trusting remote content, then
> that item can be investigated again.

My best of 3 times for "write" followed by "verify" on linux.git are
8.7/7.9 real/user for "write" and 5.2/4.9 real/user for "write".

So that's a reduction of ~40%. I have another big in-house repo where I
get similar numbers of 17/16 for "write" and 10/9 for "verify". Both for
a commit-graph file on the order of 50MB where it would be quicker for
me to download and verify it if the protocol supported it.

I'm not clamoring to make it part of the protocol, but the claim that
"verify" needs to do the equivalent of "write" seems to be demonstrably
wrong, or perhaps "verify" isn't doing all the work it should be doing?

> While there is more work to be done on the feature, having
> a section of the docs devoted to a TODO list is wasteful and
> hard to keep up-to-date.

Agreed, whatever we decide to do in the future I think it makes sense to
remove this section from the docs, although perhaps the commit message
should be amended per the above :)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index 7805b0968c..fb53341d5e 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -127,23 +127,6 @@ Design Details
>    helpful for these clones, anyway. The commit-graph will not be read or
>    written when shallow commits are present.
>
> -Future Work
> ------------
> -
> -- After computing and storing generation numbers, we must make graph
> -  walks aware of generation numbers to gain the performance benefits they
> -  enable. This will mostly be accomplished by swapping a commit-date-ordered
> -  priority queue with one ordered by generation number. The following
> -  operations are important candidates:
> -
> -    - 'log --topo-order'
> -    - 'tag --merged'
> -
> -- A server could provide a commit-graph file as part of the network protocol
> -  to avoid extra calculations by clients. This feature is only of benefit if
> -  the user is willing to trust the file, because verifying the file is correct
> -  is as hard as computing it from scratch.
> -
>  Related Links
>  -------------
>  [0] https://bugs.chromium.org/p/git/issues/detail?id=8
