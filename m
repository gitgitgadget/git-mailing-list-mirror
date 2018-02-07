Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3E81F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbeBGWvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:51:32 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56144 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeBGWvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:51:31 -0500
Received: by mail-wm0-f46.google.com with SMTP id 143so6055490wma.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LRiGUJK5BqB4G37mT8l8oeQh7F/jb6iqpnt5ZJ+bBWU=;
        b=dx8fAV2mkrVJjCUw1Qfn0t0tM/s+9t3hkasoiVnS3AAYHn6y5Mv+CtLp/jrw/smCAJ
         VbfUItnZPlHQw4ZjVNHCILsH5h6wZ23LLWsgH0kBtmxSTB0UfU1YhpYJBLBo5rNEe06Y
         xlY66vbTCPu3Jmv4nF8s249AnC7J+C7d01J2Z+3pXLfmcp5WpCX9wjoKy0TZ282HYyHH
         ni0n79LCDI8MZv7m6hg3yTw8A4gnyaE0UvGwyeF9L1bFg33vFYe4XVLHHg52geVwyx5d
         KIx7nP/3rcb4lqavyDMMN393NZP4hivP6c5F6cfjRK3wSEYwj17btCEdmcZa2jws5HOU
         7n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LRiGUJK5BqB4G37mT8l8oeQh7F/jb6iqpnt5ZJ+bBWU=;
        b=l3I5IYebKNKSOBwokINjHWFOYnbyQOJimHCy16vxulTDkyijnTZSTsDJTXBiAfrxK+
         Wo7Sr5Cruxuo485DR8PFVvUAvqzuuhVjTFKexWXbNOYo7UA4kj9zpWsJ9z5fM9tAMs/Q
         SCvtIw3UJKJ9L78osMzLZYCou+9TSJCFTWqz7y3lClVGYJNb10GrN8nhUWvC2xyVyMLC
         RdFt8Em1VhmrVufmeNUNWAfSH+No8UTlpiB4zDAsRXURfDHXk4KjuCMUB9NFxq0VTAV0
         Jt42i6W8/Xhy7MgZmOtoMrrRJZrkY+W6eBO3KC8mnv3oYbCji66JQTpN0Xv1+ao4kp4U
         LqeA==
X-Gm-Message-State: APf1xPASWq6CLrDTKcfv9ucSahbQ3/Y4y0kJuloUbDkl/NwuWA9QxZyj
        YqGNVWy2bOpjqVzPfodg5W80j1Sm
X-Google-Smtp-Source: AH8x226VJOcbR0eYM0UzUXrEW/0qBUdYIcFSkwcgYwsIjnBCVqWtnbvtlsb8cdrwhjUfkl/pS0agXA==
X-Received: by 10.28.45.151 with SMTP id t145mr5772057wmt.129.1518043890046;
        Wed, 07 Feb 2018 14:51:30 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id w3sm3650796wrc.22.2018.02.07.14.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 14:51:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     git@vger.kernel.org
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
Date:   Wed, 07 Feb 2018 23:51:27 +0100
Message-ID: <87inb8mn0w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 07 2018, Leo Gaspard jotted:

> Hello,
>
> tl;dr: Is there currently a way to have fetch hooks, and if not do you
> think it could be a nice feature?
>
> I was in the process of implementing hooks for git that ensure the
> repository is always cleanly signed by someone allowed to by the
> repository itself. I think I've completed the signature-checking part
> [1] and the push hook [2] (even though it isn't really configurable at
> the moment).
>
> However, I was starting to think about handling the fetch step, and
> couldn't find any fetch hook. Is there one?
>
> If not, would you think it is would be a good idea to add one, that
> would eg. be passed the commit-before, commit-after and could block the
> changing of the reference if it failed?
>
> The only other solution I could think of is using a separate script for
> fetching, but that would be fragile, as the user could always not think
> about it well and run a git fetch, breaking the objective that after the
> first clone all commits were correctly signature-checked.
>
> Thanks for reading me!
> Leo
>
> PS1: I am not subscribed to the ML.
>
> PS2: I've tried asking freenode#git, without success so far.
>
>
> [1]
> https://github.com/Ekleog/signed-git/blob/master/git-hooks/check-range-signed.sh
>
> [2] https://github.com/Ekleog/signed-git/blob/master/git-hooks/pre-push

There is no fetch hook, however you may find that the
post-{checkout,merge} hooks are suitable for what you want to do.

Setting those to some custom comand is a common pattern for
e.g. compiling some assets on "git pull", so you could similarly check
the commits from HEAD, of course those are post-* hooks, so they won't
stop the checkout.
