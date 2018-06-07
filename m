Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A98C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeFGTJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:09:30 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38465 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeFGTJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:09:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id 69-v6so8206185wmf.3
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=J4H/fz6eDCYwgOn+26H++tlJI2gYhWdN/232xokRuvY=;
        b=vJBA81Hb/54P+XJetht/CJheNVPeCp+7X6psL7IFrStHVKg2mhhqNu3DbLmsK46ELD
         sNLgkA/+c5ripBemvRl0KMbSd2AELpFkPtQbIrozoUhxhzHnMl0slay33zTRclcQ7KAd
         YyazqfAvcatfUaXKBYPNma9l6eCyPvqi9wxaSQ3+erUNpwOU1hnwfdnpOA1SkHjaVGp4
         OcQ19W8f6r2XwXC2oVDLDIaaBAUYDcl+JWAB+ya89VJ7ekiNlRYxf0uFTDvKv4vWI6pk
         AF0gLmCLz+OcDALpxveaHW8H4PvS7eJZODcAgQVG73zsOaO/J3id11NVuBKN4St+1JyK
         6NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=J4H/fz6eDCYwgOn+26H++tlJI2gYhWdN/232xokRuvY=;
        b=j9S4Z+k0SXQ5rgnKGRtJA02h7AgbhakOm2oasTd5CiRBUDQQ4XE0+C126g2KvDCXeM
         rZnasP84mDmmi9T+OiDmrWE4uJqJmyTZ2lbuqaZ+nHMpB2paE/LtSuyhMpWUqJJCsOrd
         I9MltbrDIBkz+jIZuHXgNP+O2pGXu6mMcmCQPCe9UhQF45Q3kCVpcsvMd6O8xIYN1GnR
         79TPOtgKw4FE/yX8mRtCmK6U0wfb4MEgQVFRInORys8tuHj1qtYqsdMLzM4Rpw/ackVJ
         +03d7yjbRyG9ezrJCoDxIZUFmmidxawIYBMyXWA2NiV9VIQ7o4Au5SoyFTfAQmJTQ9h3
         g05A==
X-Gm-Message-State: APt69E2pTn5KJvQLtLiQhdPCQ65KSsm/h9lB6mFDbnFRq/qE/EILXl9P
        PqI88S7UjPj5C5kqt+uEK7XWHLhK
X-Google-Smtp-Source: ADUXVKKvdbQJ80n03xFHMSx60S1uXALstpZnR/vGZkpo7ow8M5JN/6vknmg3NU5mrgMboI36ewooVQ==
X-Received: by 2002:a50:e70d:: with SMTP id a13-v6mr3880516edn.158.1528398566965;
        Thu, 07 Jun 2018 12:09:26 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l13-v6sm5780822edi.19.2018.06.07.12.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 12:09:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     git@vger.kernel.org
Subject: Re: git grep with leading inverted bracket expression
References: <20180607152711.GA27079@bombadil.infradead.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180607152711.GA27079@bombadil.infradead.org>
Date:   Thu, 07 Jun 2018 21:09:25 +0200
Message-ID: <87602uza56.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 07 2018, Matthew Wilcox wrote:

> If the first atom of a regex is a bracket expression with an inverted range,
> git grep is very slow.
>
> $ time git grep 'struct_size' >/dev/null
>
> real	0m0.368s
> user	0m0.563s
> sys	0m0.453s
>
> $ time git grep '[^t]truct_size' >/dev/null
>
> real	0m31.529s
> user	1m54.909s
> sys	0m0.805s
>
> If the bracket expression is moved to even the second position in the string,
> it runs much faster:
>
> $ time git grep 's[^p]ruct_size' >/dev/null
>
> real	0m3.989s
> user	0m13.939s
> sys	0m0.403s
>
> It's pretty bad with even a '.' as the first character:
>
> $ time git grep '.truct_size' >/dev/null
>
> real	0m14.514s
> user	0m52.624s
> sys	0m0.598s
>
> $ git --version
> git version 2.17.1
>
> Setting LANG=C improves matters by a factor of 3-4 (depending if you
> count real or user time):
>
> $ time git grep '[^t]truct_size' >/dev/null
> real	0m10.035s
> user	0m28.795s
> sys	0m0.537s
>
> (this is using something pretty close to Linus' current HEAD of the
> linux repository, an i7-7500, 16GB memory).

I have some WIP patches to fix all of this, which I'll hopefully submit
before 2.19 is out the door.

What you've discovered here is how shitty your libc regex engine is,
because unless you provide -P and compile with a reasonably up-to-date
libpcre (preferably v2) with JIT that's what you'll get.

The reason stuff like 'struct_size' is so much faster is because there
we don't use any regex engine at all, but rather an optimized
fixed-string searcher.

With our own benchmarks modified per your E-Mail:
    
    diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
    index 8b09c5bf32..fe4c5681da 100755
    --- a/t/perf/p7820-grep-engines.sh
    +++ b/t/perf/p7820-grep-engines.sh
    @@ -28,11 +28,10 @@ then
     fi
    
     for pattern in \
    -       'how.to' \
    -       '^how to' \
    -       '[how] to' \
    -       '\(e.t[^ ]*\|v.ry\) rare' \
    -       'm\(ú\|u\)lt.b\(æ\|y\)te'
    +       'struct size' \
    +       '[^t]truct_size' \
    +       's[^p]ruct_size' \
    +       '.truct_size'
     do
            for engine in basic extended perl
            do

I get these results against linux.git:

    $ GIT_PERF_LARGE_REPO=~/g/linux ./run p7820-grep-engines.sh
    [...]
    Test                                      this tree
    ----------------------------------------------------------
    7820.1: basic grep 'struct size'          0.23(0.52+0.76)
    7820.2: extended grep 'struct size'       0.22(0.60+0.61)
    7820.3: perl grep 'struct size'           0.22(0.56+0.65)
    7820.5: basic grep '[^t]truct_size'       4.29(29.43+0.51)
    7820.6: extended grep '[^t]truct_size'    4.27(29.59+0.36)
    7820.7: perl grep '[^t]truct_size'        0.21(0.40+0.69)
    7820.9: basic grep 's[^p]ruct_size'       0.49(2.22+0.49)
    7820.10: extended grep 's[^p]ruct_size'   0.43(2.24+0.48)
    7820.11: perl grep 's[^p]ruct_size'       0.21(0.38+0.71)
    7820.13: basic grep '.truct_size'         4.42(31.29+0.44)
    7820.14: extended grep '.truct_size'      4.50(31.18+0.46)
    7820.15: perl grep '.truct_size'          0.21(0.35+0.75)

So you need to just use an up-to-date libpcre2 & -P and performance
won't suck.

My WIP patches will make us use PCRE for all grep modes, using an API it
has to convert basic & extended regexp syntax to its own syntax, so
we'll be able to do that transparently.
