Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804A7209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdIKSr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:47:59 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45058 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdIKSr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:47:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id f199so46684717wme.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GKlStBb5Ui9uPh6uHqqXgpd+AYzP0gt2Q6vX5X54xfY=;
        b=lFZctnwm1XFRy5uQX3rLL6WTOfKkiav1LvCciTjjZjYBjkqRGVMFP9t83qem+npagG
         ifXsPGwjLS31Z9XpyvtaKDqHvluMl1xfqLXMyLmcHYAzP8C7gVFu0304bWajgHLQ2avV
         PAClzI4+IfugarUEg8jVWty64eZ041AAxyejJyw2ZbQh/qXg4KKDJ1eKuALyRP2LMmJA
         RBFcoBFSpLqM2MqfhO6MTIHQulQytWI2mXp/OGyjQ0kRXYdgWq5+NMXd12DFT+d3PybN
         0l/ZIvsD0NF1hT7Svz19QRfjqpz3okulPRwahKoehLf47m7e2Xt9UP39qlNHzi0X58kG
         N50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GKlStBb5Ui9uPh6uHqqXgpd+AYzP0gt2Q6vX5X54xfY=;
        b=rgirdazmb/Hd/r8VurTobhiZxKLYzrUrGXd1LSGYG5g84FSei+ie59OgvXHraxU2Rr
         KACZu2XHuRxnHntrxAC5cggusP5SvpcK3qCwUm/i6zr1Fi4JY2Iu9stvqxUCxxqDHM+R
         1YYY7cEZEDIZbgvcxzd+wQij3CeQ+dN7A9TwOgMwW/d3OYCXTtCgrpRJdDpbOkSbHzFk
         5PLTftJJgVIKgVwFneZ6EDnjQAEpCfgUTwRFZIOj75Dpp4jnV0xPM6vwCi17e6ikVJt3
         ueGfeGEU0fOHiWRtUR0jpVPhF/UoLtTYREL357UjIW4Y3BWmhHHbpU3zsu7wvpmnxitE
         DFvg==
X-Gm-Message-State: AHPjjUi+pAp4cvIPtWWGts1TSDf71Ve77NeZAO12RM7nQ7S2HxIR4SZH
        +pCGN12aFQfMBOI00dSpk7ngAzj1M3eM
X-Google-Smtp-Source: ADKCNb7a1KTJpe77f/6Y7RfEUd4tCxTV44P/YCtlsWqlEGjg7zuJbqoh4KDb1VgIXKu6uG+ujotjsO+fITuPuUEzIG0=
X-Received: by 10.80.208.208 with SMTP id g16mr4218541edf.246.1505155676846;
 Mon, 11 Sep 2017 11:47:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Mon, 11 Sep 2017 11:47:36 -0700 (PDT)
In-Reply-To: <CAGZ79kacL7TodpBFmrPJtasjXYVKTVDb-FmM5QJyAPS-+NYf7w@mail.gmail.com>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <CAGZ79kacL7TodpBFmrPJtasjXYVKTVDb-FmM5QJyAPS-+NYf7w@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 11 Sep 2017 11:47:36 -0700
Message-ID: <CA+P7+xqFrC9MFm+b65q53_SGK7JJUJFYeeLUgxXd8te5rrg5Rw@mail.gmail.com>
Subject: Re: [idea] File history tracking hints
To:     Stefan Beller <sbeller@google.com>
Cc:     Pavel Kretov <firegurafiku@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 11:11 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Sep 11, 2017 at 12:11 AM, Pavel Kretov <firegurafiku@gmail.com> wrote:
>> Hi all,
>>
>> Excuse me if the topic I'm going to raise here has been already discussed
>> on the mailing list, forums, or IRC, but I couldn't find anything related.
>>
>>
>> The problem:
>>
>> Git, being "a stupid content tracker", doesn't try to keep an eye on
>> operations which happens to individual files; things like file renames
>> aren't recorded during commit, but heuristically detected later.
>>
>> Unfortunately, the heuristic can only deal with simple file renames with
>> no substantial content changes; it's helpless when you:
>>
>>  - rename file and change it's content significantly;
>>  - split single file into several files;
>>  - merge several files into another;
>>  - copy entire file from another commit, and do other things like these.
>>
>> However, if we're able to preserve this information, it's possible
>> not only to do more accurate 'git blame', but also merge revisions with
>> fewer conflicts.
>>
>>
>> The proposal:
>>
>> The idea is to let user give hints about what was changed during
>> the commit. For example, if user did a rename which wasn't automatically
>> detected, he would append something like the following to his commit
>> message:
>>
>>     Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
>> dev-vcs/git/git-2.0.ebuild
>>
>> or (if full paths of affected files can be unambiguously omitted):
>>
>>     Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
>>
>> There may be other hint types:
>>
>>     Tracking-hint: recreate LICENSE.txt
>>     Tracking-hint: split main.c -> main.c cmdline.c
>>     Tracking-hint: merge linalg.py <- vector.py matrix.py
>>
>> or even something like this:
>>
>>     Tracking-hint: copy json.py <-
>> libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
>>
>> If file transformation cannot be described by a single tracking hint, it shall
>> be possible to specify a sequence of hints at once:
>>
>>     Tracking-hint:
>>         split Utils.java -> AppHelpers.java StringHelpers.java
>>         recreate Utils.java
>>
>> Note that in the above example the order of operations really matters, so
>> both lines have to reside in one 'Tracking-hint' block.
>>
>> * * *
>>
>> How do you think, is this idea worth implementing?
>> Any other thoughts on this?
>>
>> -- Pavel Kretov.
>
> This was discussed a couple of times on the mailing list
> (though not recently).
>
> I searched for "rename tracking files site:public-inbox.org/git"
> and came up with
> https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org/
> (the nearby emails seem to also be relevant to this discussion)
>
> tl:dr: When encoding these hints, you do it at commit time,
> but the heuristic can be improved upon later.
> So you can assume the heuristic is better for the
> common case, as someone will fix the heuristic for the
> common case. Also Gits model is to track objects.

Linus has a pretty long post about this, it's somewhere in that
discussion. Essentially, if you bake in rename detection (or other
hints) at commit time, then you're stuck with it forever.

Additionally, there are similar but not *quite* the same operations
which you probably wouldn't bake into at the start, and the types of
questions a user wants to ask isn't known at commit time, but rather
known at *debug* time in the future when you're digging up history. In
this time frame, the user does know what to care about and what kind
of questions to ask, so it's already natural to ask these questions at
that time.

Additionally, if you have to generate the heuristic every commit,
you're increasing time "wasted" every commit, where as doing the
lookup later when a user starts asking questions like during blame or
diff would only add time during an operation the user already expects
to take some time.

Thanks,
Jake
