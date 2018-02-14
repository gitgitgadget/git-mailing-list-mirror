Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D045A1FAE2
	for <e@80x24.org>; Wed, 14 Feb 2018 18:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161971AbeBNS2O (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:28:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37638 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161778AbeBNS2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:28:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so23686382wmv.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AZuHE1i+d75uJXK9WT0Wlc+J6TqTqVBZ8p1v893Rulw=;
        b=jYsfplk+YGCbl6flYvY2Xs54EfsyJ8I1d9L8FLzD7fnv6SZoN/C/ishWAxHaBbdKVL
         s2NSGPSamJIBXM5V6QO+khpbkw/5etnNnIi2VPw4BniY57g0yMWxrbVthUyWrJ9dNVyb
         Sjjos2foaeagtOnju0i2cPkVm21bGW8EFcqsyKK36oOOH2oaAZ6w3ISM+Zmc4rh/doKQ
         EHwB6SaSWoB9yTp0u7s7UssQncXg8ljfhKcBJSPWXHS64Q53twiGx7HjzszhUtYugbZK
         17e4k45FWQdvfitytZuD3jdUgUFiFuVY/Lxh8W5X8qfM6G90DhB+PaFhQIyv0gKxd1H9
         XZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AZuHE1i+d75uJXK9WT0Wlc+J6TqTqVBZ8p1v893Rulw=;
        b=Ha1ST4qmVBCxJmaw247n2yuMnOHqFbxH/2Z+vGMP63+GP17XP/6rWAZMZysUv7TOBG
         xvDIWXeyyivQZS/y1c3UbZdI+lUnXjTvbzpmD7JQ8TaUW9jo89OuDUkJVcr5ZcXie+ZC
         UbDyXxsaPWrkjIBIRPFPHohSdR4ypk6fiULwTSlQjExb+vNUWbSwkZHaEk12s0ntyFpd
         mViG9DRQtn4R2YJw8/eT6RZAdbkizmetMITavWe6OuaZvAsILrS7rKzjWe5UIVf6PP8V
         ekg7QiS3FEnM5MZ+YT/OZqXdWTtz/PYd71+1rpphIK8gPvplJGi8QcdaByP8b6qcU0eA
         tD8g==
X-Gm-Message-State: APf1xPDkokSpfJUfQiu8Pnf/DrfqKalOaMv8J5LYEd/8AxsjjX6y0Lao
        ApuYzMU5QpHuBqgLuWwfSDk=
X-Google-Smtp-Source: AH8x224jVQbFUHD579s/kZ2FR+TXi8k1VkTaQ6JSkCmMOUVXNkPVYO7ckB6NKpZNu8iuZ3MUm+E0Nw==
X-Received: by 10.28.21.136 with SMTP id 130mr10139wmv.152.1518632889375;
        Wed, 14 Feb 2018 10:28:09 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k5sm7059353wmg.47.2018.02.14.10.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 10:28:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] fsmonitor: update documentation to remove reference to invalid config settings
References: <20180214154130.111708-1-benpeart@microsoft.com>
Date:   Wed, 14 Feb 2018 10:28:08 -0800
In-Reply-To: <20180214154130.111708-1-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 14 Feb 2018 10:41:30 -0500")
Message-ID: <xmqq7erfo287.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> Remove the reference to setting core.fsmonitor to `true` (or `false`) as those
> are not valid settings.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---

Thanks.  It is a bit embarrassing that nobody caught it for this
long.  Will apply.

>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/4b7ec2c11e
>     Checkout: git fetch https://github.com/benpeart/git fsmonitor_docs-v1 && git checkout 4b7ec2c11e
>
>  Documentation/git-update-index.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index bdb0342593..ad2383d7ed 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -484,8 +484,8 @@ the `core.fsmonitor` configuration variable (see
>  linkgit:git-config[1]) than using the `--fsmonitor` option to
>  `git update-index` in each repository, especially if you want to do so
>  across all repositories you use, because you can set the configuration
> -variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
> -and have it affect all repositories you touch.
> +variable in your `$HOME/.gitconfig` just once and have it affect all
> +repositories you touch.
>  
>  When the `core.fsmonitor` configuration variable is changed, the
>  file system monitor is added to or removed from the index the next time
>
> base-commit: e7e80778e705ea3f9332c634781d6d0f8c6eab64
