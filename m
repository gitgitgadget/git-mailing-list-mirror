Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6733D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeHOAyw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:54:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42233 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHOAyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:54:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so10915540edp.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jX+JeCPUo8xczp/RihlGhpWcxRM4Z9OiMExl2EmnHKw=;
        b=jqPUsuZKKLTbHMNhlnUQzjwkpiJpiy/hMMRc1N/VIMo6PgEzwyOl6D8N4jtpPw8TB2
         0kJ6al8qgVPKZ5uaHsjh5MmvZKtD/+L9Gfhy9V+5HdBK+yjSBI9qZtS7A7FwXlwu9a4D
         +9VijB6NvE+LAc4gDFP/s86nLV3e6k6TDOfn5XURP1O0YfsDVP67YsTSzvCiOXi6GLfV
         JtstGOrrNFIHqliYL/u3ZHNuPJXhPPewoAl1S7GfI4qlCaFr/w7BAf7k1FGtaAIifF/1
         7Y7ilIk1GEIdpelUS21wGAM08PRnMhqb/QHhvg7Hsskll4cSsmyUBSPUe4IKuPVCnFAO
         JpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jX+JeCPUo8xczp/RihlGhpWcxRM4Z9OiMExl2EmnHKw=;
        b=EcpFNQmCUZhX5u2wUxaJZl3Dghwzj260jwywLbS03jWYeQYbWGWfx41IS2GYtjd0fN
         /kEdJnOxzIS8orTb/9YKgweIih/S1P05uub35GiErc/NY0/nD78BW1vCTbuns651rylU
         IpGMfqZcjlFz8ZaSv1twdSFKk7JWh5pXSTE/lny+CMUa1zENIOvQpkT4HU1qPx9DJFKY
         gqF920ffqY4SPvSIeRlOtfJwJQpmPcO2N11cvnO0e8utKAP7RzzjE9IezauUjXLpq3rj
         SRjHQvgA1syDhqhXcvLECEeOr6q2rOru34SYbBRq7+rVkapaVhDtQQsJW1VIUJM4zwtw
         RGOw==
X-Gm-Message-State: AOUpUlEafdAc8+lvYY7Ayub5PkIQ3w7gDf24Eja3TA8h0mnvf3FmZOyt
        voP3osgb003v29URFawrTbU=
X-Google-Smtp-Source: AA+uWPxM5lhTnz2gD65Biu4W0s6w9LSrd1ror3ow1hAeuI+UnAqMUZuS3pdwsbjyP//N8Axv+xT7gA==
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr28804914edb.6.1534284338387;
        Tue, 14 Aug 2018 15:05:38 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id g28-v6sm19908195edg.67.2018.08.14.15.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 15:05:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 27.0.50; mu4e 1.1.0
In-reply-to: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
Date:   Wed, 15 Aug 2018 00:05:36 +0200
Message-ID: <87a7pohadr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 14 2018, Christian Couder wrote:

> Hi,
>
> When cloning with --mirror, the clone gets its HEAD initialized with
> the value HEAD has in its origin remote. After that if HEAD changes in
> origin there is no simple way to sync HEAD at the same time as the
> refs are synced.
>
> It looks like the simplest way to sync HEAD is:
>
> 1) git remote show origin
> 2) parse "HEAD branch: XXX" from the output of the above command
> 3) git symbolic-ref HEAD refs/heads/XXX
>
> It looks like it would be quite easy to add an option to `fetch` to
> sync HEAD at the same time as regular refs are synced because every
> fetch from an origin that uses a recent Git contains something like:
>
> 19:55:39.304976 pkt-line.c:80           packet:          git< YYYYYYYY
> HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow
> deepen-since deepen-not deepen-relative no-progress include-tag
> multi_ack_detailed no-done symref=HEAD:refs/heads/test-1
> agent=git/2.18.0
>
> which in this example shows that HEAD is a symref to refs/heads/test-1
> in origin.
>
> Is there a reason why no such option already exists? Would it makes
> sense to add one? Is there any reason why it's not a good idea? Or am
> I missing something?
>
> I am asking because GitLab uses HEAD in the bare repos it manages to
> store the default branch against which the Merge Requests (same thing
> as Pull Requests on GitHub) are created.
>
> So when people want to keep 2 GitLab hosted repos in sync, GitLab
> needs to sync HEADs too, not just the refs.
>
> I think this could be useful to other setups than GitLab though.
>
> Thanks,
> Christian.

Isn't this some other facet of (or the same) bug I reported in
https://public-inbox.org/git/87bmcyfh67.fsf@evledraar.gmail.com/ ?
