Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30621FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbcH2Wmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:42:35 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33282 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbcH2Wme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 18:42:34 -0400
Received: by mail-lf0-f43.google.com with SMTP id b199so1232829lfe.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3Q2L9GSjeW4SywRhufGj1FxPlpr3ek/rwUxsiPiseFI=;
        b=WZcoy+0Kec1+D0CI+MORWNaw8IWkTo6PN4ffME/xwseuw0/INP2di1fgxo6cc4aV2M
         bn1PggYMeKT6fmFzupEZ5YX8cmDL0UQoLHYjyTAXKrscNkSsahlh7b1WrB9qgQr+AcRR
         7csYOwsFl/PeALkuixyROlKIPGAlEYA57CVQlWURjk77x8oeKViEuNkq8CPwdTX2HpXT
         UU5ZmfgvEpHrz4J5LGpx+l9zKQEKfMcWzHcIeyC0wu2YvcyKwgpqf+u3aK5cS+Lpgh4r
         F6Xs3gST5nRLtxfwKpfwseYgUHHkCk3ZuhuzcGaTyC8ZFwn74HiM7CPEHgDrx9O8pLql
         GUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3Q2L9GSjeW4SywRhufGj1FxPlpr3ek/rwUxsiPiseFI=;
        b=dd5CuXlKXaRTsaoBq3B0fbKizdDJ8Kuy242irYL8eSLr8/m54oF0mILTt2OqXUGvh6
         dpUSX+vLG3YeBqANgpGoMgV9TT8j/PDY4v+vJfI2D4Ehp7i1nQC/iONL6vsBJHjUgykB
         qyL9BvVY3gT+2GZGrSEvD90Bdof+nHQyL1kmqj2z3ie/FfQ7Ffsz9t8E/4hg3yw2rRFo
         Dtw4jpR70hzlyxcAw+w3oUx9l5+s7S/oVlBmw3sl8AdiJHVLDuV+YVwtCNUGEj6Uh+m/
         vbcXXbC+ogSk7ud0fsq72vpUAy4ruhvjvgMBnEJ1u5I+gQUGACFrk90gMjiCcFXdRFWF
         jGqQ==
X-Gm-Message-State: AE9vXwOmDV2D2oV2xTnSCaP7/GrMKakTdgTZVj1A6HCWbinUvKRTELHh1oeoYRSJAdxuDoOE5niGdFIHrpW4vQ==
X-Received: by 10.46.71.84 with SMTP id u81mr99491lja.19.1472510550470; Mon,
 29 Aug 2016 15:42:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.78.226 with HTTP; Mon, 29 Aug 2016 15:41:59 -0700 (PDT)
In-Reply-To: <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net> <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
 <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
From:   "W. David Jarvis" <william.d.jarvis@gmail.com>
Date:   Mon, 29 Aug 2016 15:41:59 -0700
X-Google-Sender-Auth: zPBteMJ51LMk5KIynZNoCgU8SFg
Message-ID: <CAFMAO9zfMtF6Vc+Uyt+UdgOVf4hzOqMN3o8QLf8pRHx3_U4DPQ@mail.gmail.com>
Subject: Re: Reducing CPU load on git server
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Pegging CPU for a few seconds doesn't sound out-of-place for
> pack-objects serving a fetch or clone on a large repository. And I can
> certainly believe "minutes", especially if it was not serving a fetch,
> but doing repository maintenance on a large repository.
>
> Talk to GitHub Enterprise support folks about what kind of process
> monitoring and accounting is available. Recent versions of GHE can
> easily tell things like which repositories and processes are using the
> most CPU, RAM, I/O, and network, which ones are seeing a lot of
> parallelism, etc.

We have an open support thread with the GHE support folks, but the
only feedback we've gotten so far on this subject is that they believe
our CPU load is being driven by the quantity of fetch operations (an
average of 16 fetch requests per second during normal business hours,
so 4 requests per second per subscriber box). About 4,000 fetch
requests on our main repository per day.

> None of those operations is triggered by client fetches. You'll see
> "rev-list" for a variety of operations, so that's hard to pinpoint. But
> I'm surprised that "prune" is a common one for you. It is run as part of
> the post-push, but I happen to know that the version that ships on GHE
> is optimized to use bitmaps, and to avoid doing any work when there are
> no loose objects that need pruning in the first place.

Would regular force-pushing trigger prune operations? Our engineering
body loves to force-push.

>> I might be misunderstanding this, but if the subscriber is already "up
>> to date" modulo a single updated ref tip, then this problem shouldn't
>> occur, right? Concretely: if ref A is built off of ref B, and the
>> subscriber already has B when it requests A, that shouldn't cause this
>> behavior, but it would cause this behavior if the subscriber didn't
>> have B when it requested A.
>
> Correct. So this shouldn't be a thing you are running into now, but it's
> something that might be made worse if you switch to fetching only single
> refs.

But in theory if we were always up-to-date (since we'd always fetch
any updated ref) we wouldn't run into this problem? We could have a
cron job to ensure that we run a full git fetch every once in a while
but I'd hope that if this was written properly we'd almost always have
the most recent commit for any dependency ref.

> That really sounds like repository maintenance. Repacks of
> torvalds/linux (including all of its forks) on github.com take ~15
> minutes of CPU. There may be some optimization opportunities there (I
> have a few things I'd like to explore in the next few months), but most
> of it is pretty fundamental. It literally takes a few minutes just to
> walk the entire object graph for that repo (that's one of the more
> extreme cases, of course, but presumably you are hosting some large
> repositories).
>
> Maintenance like that should be a very occasional operation, but it's
> possible that you have a very busy repo.

Our primary repository is fairly busy. It has about 1/3 the commits of
Linux and about 1/3 the refs, but seems otherwise to be on the same
scale. And, of course, it both hasn't been around for as long as Linux
has and has been experiencing exponential growth, which means its
current activity is higher than it has ever been before -- might put
it on a similar scale to Linux's current activity.

> OK, I double-checked, and your version should be coalescing identical
> fetches.
>
> Given that, and that a lot of the load you mentioned above is coming
> from non-fetch sources, it sounds like switching anything with your
> replica fetch strategy isn't likely to help much. And a multi-tiered
> architecture won't help if the load is being generated by requests that
> are serving the web-views directly on the box.
>
> I'd really encourage you to talk with GitHub Support about performance
> and clustering. It sounds like there may be some GitHub-specific things
> to tweak. And it may be that the load is just too much for a single
> machine, and would benefit from spreading the load across multiple git
> servers.

What surprised us is that we had been running this on an r3.4xlarge
(16vCPU) on AWS for two years without too much issue. Then in a span
of months we started experiencing massive CPU load, which forced us to
upgrade the box to one with 32 vCPU (and better CPUs). We just don't
understand what the precise driver of load is here.

As noted above, we are talking with GitHub about performance -- we've
also been pushing them to start working on a clustering plan, but my
impression has been that they're reluctant to go down that path. I
suspect that we use GHE much more aggressively than the typical GHE
client, but I could be wrong about that.

 - V

-- 
============
venanti.us
203.918.2328
============
