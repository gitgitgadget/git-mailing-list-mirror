Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81FE1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFAUIE (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:08:04 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:46704 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFAUIE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:08:04 -0400
Received: by mail-yb0-f172.google.com with SMTP id p22-v6so9133586yba.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c47AaUT3uF2VGpfxHKxlwB+kVS1TCPwsnT3dnznWsKc=;
        b=Ahzz8SNgcnMvyAnJ3Zd09Aao2xP4E+346uO1gcRql3uy56lMWeKcazrfMSXO5ZO4x7
         laNi/Nbwz7BnleCoSSbGcAROR3PP4G2GbIdgvNOuzVCYcpS0ST8a2Y7ZkjhPRu11vFb9
         Reb+E0R/7DOUoidK4jilJ4o6cGpOFA/BQ+bfOS9VEWzuspZUL9FINlY7fWMamteEwObe
         9rAls8iUJQmvetg8vgUaUwhgiDB79nkyjUbqmA3fmTskhPRcQYQyLCR6LgctvfIlSvfD
         acXqB95HS/fR68doMiyCUIY6l+QvsHU217BcY+vSIDIamtJE1wdqoz5wezHhh4lNsrO2
         uQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c47AaUT3uF2VGpfxHKxlwB+kVS1TCPwsnT3dnznWsKc=;
        b=sTFiD0zWsoYiomMJG4fk5Kx/ifVv7RioO/QttSv8GdgiSiV6qMzMvMXAc8ZhHyRyEM
         yh+7zrAJWG88Z5US7o4OcXY65LpJM/LySRmbxdRe+WHLls8c0NG8P73lV7ell0FG6GpJ
         jb/ySLiAyFv3IYgmldX3V3yFmYZVbrrvHgd7/byzYwkDW4/2erMGDZEGDaeIBK+S53Tu
         xLkso90P5/m1XCuZy8GdS1upMAqRvnOaWMACi3Or7hFWzJU6Rx9HRTX+FwdpSOc/qHzi
         46XyM6SwIkxboVYPoW2xOa3gSAe46QckqfUTM9qgDPFA6oHBtknL2cYiQ2pWe5e87nzF
         Z0DQ==
X-Gm-Message-State: ALKqPwd3KtuEdsqryKjX/ApCLBMCvN02Bu10AKFf2EA4t0wn0mwZONjU
        2QjxI6ayJUS8DEudEPstNSgG5ixjkKNVIxSQueV81EI6FDQ=
X-Google-Smtp-Source: ADUXVKLcb1BS+P/YQxabPlxUED/madqKVvJmjRY6TG4TdxFryVfKK6n6BzJ5LIIc/N5CP8pUMj+sAsRgfc7syYALwXE=
X-Received: by 2002:a25:2e06:: with SMTP id u6-v6mr6905258ybu.247.1527883682908;
 Fri, 01 Jun 2018 13:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 13:08:02 -0700 (PDT)
In-Reply-To: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Jun 2018 13:08:02 -0700
Message-ID: <CAGZ79kZYEzW6hVangMJP9=W6Mp4Fqm5b5UtNUQ=ggm0WF8X2gg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #01; Fri, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jm/cache-entry-from-mem-pool (2018-05-24) 7 commits
>  - block alloc: add validations around cache_entry lifecyle
>  - block alloc: allocate cache entries from mem_pool
>  - mem-pool: fill out functionality
>  - mem-pool: add lifecycle management functions
>  - mem-pool: only search head block for available space
>  - block alloc: add lifecycle APIs for cache_entry structs
>  - read-cache: teach refresh_cache_entry() to take istate
>
>  For a large tree, the index needs to hold many cache entries
>  allocated on heap.  These cache entries are now allocated out of a
>  dedicated memory pool to amortize malloc(3) overhead.
>
>  Is this ready for 'next'?

https://public-inbox.org/git/CAGZ79kZ-1jwnhzZrCeoZTZrNSwmnO=6asWQgWXRj7tjfYVr=-A@mail.gmail.com/

I wanted to give it one final read, as Jameson mentioned to
he might resend addressing questions from the last round.
I think it is not quite there yet.


> * sb/object-store-grafts (2018-05-18) 19 commits
[...]
>  (this branch uses sb/object-store-alloc.)
>
>  The conversion to pass "the_repository" and then "a_repository"
>  throughout the object access API continues.
>
>  Will merge to and cook in 'next'.

> * sb/object-store-alloc (2018-05-16) 13 commits
[...]
>  - repository: introduce parsed objects field
>  (this branch is used by sb/object-store-grafts.)
>
>  The conversion to pass "the_repository" and then "a_repository"
>  throughout the object access API continues.
>
>  Will merge to and cook in 'next'.

Thanks.
Should I continue to build on top of these series or merge in side branches
to have a newer base? c.f.
https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/


> * sb/diff-color-move-more (2018-05-21) 8 commits
[...]
>  "git diff --color-moved" feature has further been tweaked.
>
>  Will kick back to 'pu'.
>  cf. <CAGZ79kag9m02xtJKg05aPE4Grq2wBWSmUr3JdwfyHsMawR7m5Q@mail.gmail.com>

I hope to get this out again, today.
