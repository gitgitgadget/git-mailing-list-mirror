Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEADF211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeK3CPl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:15:41 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43285 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbeK3CPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:15:40 -0500
Received: by mail-ed1-f45.google.com with SMTP id f4so2152985edq.10
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JGaHH/2Bz6GHSdxhEz0wWYdoWWBeOXUQXNBkouUjFwU=;
        b=Bs8kyNvBmyehuiJmRoWymkdeFlattDzZl8fSsLKKcS7DsTViJQ3SC0dIQ6dzRIJsev
         hahHu6h7bRF2FrY+Ma3BFokNlT/uuf/q+u8ZXVtFlavNk+YBDIRULV3Gohcu+TQdVjWz
         iZtnTHMR5E8z/CU5X7XiMr9E5GXhmaZQg6HKtwcyIsYyy8uwJ0EF+bWbqVF5rfB0FwEf
         MH099HBmGEHvBfbhcOfAhvNAYU3gZ7FhULdZmdwoSIlEWNp+5Cs9LRJ+Hd8jxtVkfdPy
         Blei/2CdepMOOz460/sOgTDLnc9cpiFr0Uh7RP4ycTJeOvsV8XZDtwmFGnlkYpmG5VbY
         mUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JGaHH/2Bz6GHSdxhEz0wWYdoWWBeOXUQXNBkouUjFwU=;
        b=dJ10tnKFoYpSTV606y8Fk8law1mYFSuevNeiNwMQh/G97AlZk7OUpFoAP8jjCS1KW5
         lyHXW93c9qanMxLsMb87FEC2G45hb8o00HJV9mNLidDtUI6+bQj6iBXeB4WsiYuk3Sp7
         ikjpU6WX1HcNJXSSEdfZjJDb5lwARI5Sr+zzC/js4/INZdzoJCo3+bnJUK1Dy9qvsjJd
         GwXWTTYRL0CEqd4xtlqLJdg9toOl2z6VI6cnJ2Wn/fPNOCOxnQPYrOzyV8VyNJkfVDnO
         LN71tTz5316wWMo+KrABc1q/RBeM7RYjK4WOcedrTaN2WemvShJV3MekU9AYD1mxA0eM
         1oVQ==
X-Gm-Message-State: AA+aEWY7C9fFNyyi1DibWJLP6Hc6C3gbpXN/MB092JXbImcP2DtOQDRY
        8txxUMFBFAUBeLuwukDYxcZ9wdvM
X-Google-Smtp-Source: AFSGD/UYKjlR3bxJL0GcPEpcNJA807cQxI1XLBCmWMYeCoXCYu8MUQaCbAXJXqAlWDvGJMKkaqUszw==
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr1960721eds.265.1543504199205;
        Thu, 29 Nov 2018 07:09:59 -0800 (PST)
Received: from evledraar ([5.57.21.10])
        by smtp.gmail.com with ESMTPSA id f6sm690296ede.53.2018.11.29.07.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 07:09:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git Tags
References: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
Date:   Thu, 29 Nov 2018 16:09:57 +0100
Message-ID: <87woovyl6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Stefanie Leisestreichler wrote:

> Hi.
>
> I have done this (on box A):
>
> git commit -m "Message"
> git tag -a 0.9.0
> git push origin master
>
> In my local repository, when I run "git tag" it is showing me "0.9.0".
>
> Then I did (on box B)
> git clone ssh://user@host:/path/project.git
> cd project
> git tag
>
> Now git tag is showing nothing.
>
> Why is the tag only available in my local repository?
>
> Also when I try to
> git clone --branch 0.9.0 ssh://user@host:/path/project.git
> it tells me: fatal:remote branch not found in upstream repository origin

Because --branch <name> means get refs/heads/<name>, tags are not
branches. However, because we're apparently quite loose about this in
the clone/fetch code this does give you the tag if it exists, but
probably not in the way you expect.

We interpret the argument as a branch, and will get not only this tag
but "follow" (see --no-tags in git-fetch(1)) the tag as though it were a
branch and give you all tags leading up to that one. This would give you
a single tag:

    git clone --no-tags --branch v2.19.0 --single-branch https://github.com/git/git.git

But this is a more direct way to do it:

    git init git; git -C git fetch --no-tags https://github.com/git/git.git tag v2.19.0

Which'll since you said it failed that's because you haven't pushed the
tag. Try 'git ls-remote <url>' to see if it's there (it's not).
