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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C06D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeJXE2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:28:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33785 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXE2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:28:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id r25-v6so2858257edy.0
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PDAyPB8KIOqnVfj8D2GLSr5YV8iqLRpeMH7NUlfqAUE=;
        b=uYnm3ZKtt5GiUOkU/RvtFvFYmlOgnkqbIQW2w2xN5bHlRga9zLPhppdpf8OM0XnR0w
         f1eAttB0eLOa/m8+lOMYN43Qd6Cdx09PaSU1i6GitxDEYMlVoHGQekM90OKdTdAyuL/S
         +MmmEMH1Nk5dLS9SGexgnWDXOd/240Q+flQmg6NxomddVAeXgEroWJy7yWcBqUWbXgcj
         2I5i33bvtAQ6drDUBd4DfAy6OD0DZ6eVabKSBbrBkc7eugZPYpBX934SWktb8UA/44ZF
         RhQZyBCAXVbWJvISGXWjp1IkNqIqoXR2w8Pj079jjTsEnYn1MhCXFDWlIFk9ErJ6nHxI
         d9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PDAyPB8KIOqnVfj8D2GLSr5YV8iqLRpeMH7NUlfqAUE=;
        b=Sk8ypm2T05Ap/n3bGKzptXlDbnml2tEJ931UTGSSpuHNPCg3cL6UDSZinre2Aic8E8
         gEciXSsSsnSXveJq45oXzif9HzuTb4vlThqKkbc/spHNz41oxcoqorjW3uTTeOdh+K89
         EzJwuhypE9V5E59aYdcwmzQckjXJ7kLgELh0jf5WmRzjx3sKR7N6hF5P0NqIQOwnFHw3
         CJPot7kariYkc4yPKEoWbVccPwrhgztupatuoHa0dumki76wVl23iQddv+b5CZwjDeII
         BUTkkcGU4yD7O85FQdvwiomePmP+lKT3bxihdIB7wVzrbYFGZMfsSs2ah6eUKcnW1Aoo
         LzvA==
X-Gm-Message-State: ABuFfojMRALJstNs7AON2eSiiOYUxy3hxWo6sTsNuIPw0X+7BX7JDrcT
        E097hvQYF3Iyz4z/6jkCIMU=
X-Google-Smtp-Source: ACcGV63fhJ6n6KvDl78o68hYZpl8Y9vCcZ2m/M5RBYWDJwlU645XbAgJKRaWBqXjej7dCu/7XBxSrA==
X-Received: by 2002:a17:906:3792:: with SMTP id n18-v6mr38884106ejc.179.1540325007002;
        Tue, 23 Oct 2018 13:03:27 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id g22-v6sm561974ejt.15.2018.10.23.13.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:03:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181017164021.15204-3-peartben@gmail.com>
        <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
        <20181017182337.GD28326@sigill.intra.peff.net>
        <874lddc9fs.fsf@evledraar.gmail.com>
        <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
Date:   Tue, 23 Oct 2018 22:03:23 +0200
Message-ID: <87zhv4bfck.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 23 2018, Ben Peart wrote:

> On 10/23/2018 5:13 AM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Oct 17 2018, Jeff King wrote:
>>
>>> On Wed, Oct 17, 2018 at 02:19:59PM -0400, Eric Sunshine wrote:
>>>
>>>> On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
>>>>> Add a reset.quietDefault config setting that sets the default value of the
>>>>> --quiet flag when running the reset command.  This enables users to change
>>>>> the default behavior to take advantage of the performance advantages of
>>>>> avoiding the scan for unstaged changes after reset.  Defaults to false.
>>>>
>>>> As with the previous patch, my knee-jerk reaction is that this really
>>>> feels wrong being tied to --quiet. It's particularly unintuitive.
>>>>
>>>> What I _could_ see, and what would feel more natural is if you add a
>>>> new option (say, --optimize) which is more general, incorporating
>>>> whatever optimizations become available in the future, not just this
>>>> one special-case. A side-effect of --optimize is that it implies
>>>> --quiet, and that is something which can and should be documented.
>>>
>>> Heh, I just wrote something very similar elsewhere in the thread. I'm
>>> still not sure if it's a dumb idea, but at least we can be dumb
>>> together.
>>
>> Same here. I'm in general if favor of having the ability to configure
>> porcelain command-line options, but in this case it seems like it would
>> be more logical to head for something like:
>>
>>      core.uiMessaging=[default,exhaustive,lossyButFaster,quiet]
>>
>> Where default would be our current "exhaustive", and this --quiet case
>> would be covered by lossyButFaster, but also things like the
>> "--no-ahead-behind" flag for git-status.
>>
>
> This sounds like an easy way to choose a set of default values that we
> think make sense to get bundled together. That could be a way for
> users to quickly choose a set of good defaults but I still think you
> would want find grained control over the individual settings.

Would you? It seems wanting to configure reset's --quiet in particular
is purely a proxy goal for wanting to toggle off slow things in the
UI. Otherwise why focus on it, and not the plethora of other --quiet
options we have?

    # Including (but probably not limited to):
    $ git grep -e OPT__QUIET -e '(OPT|option).*"quiet"' -- '*.[ch]' | wc -l
    34

> Coming up with the set of values to bundle together, figuring out the
> hierarchy of precedence for this new global config->individual
> config->individual command line[...]

If we'd still want reset.quiet & whatever the global "turn off slow
stuff" UI option is then this part is easy and
e.g. {transfer,fetch,receive}.fsckObjects can be used as a template for
how to do it.

    https://github.com/git/git/blob/v2.19.0/fetch-pack.c#L1432-L1443
    https://github.com/git/git/blob/v2.19.0/fetch-pack.c#L859-L863

I.e. the more specific option always overrides the less specific one.

> [...]updating the code to make it all work is outside the scope of
> this particular patch series.

Is that a Jedi mind trick to get out of patch review? :)

I understand that it's not the patch you wrote, but sometimes feedback
is "maybe we shouldn't do this, but this other thing".

The --ahead-behind config setting stalled on-list before:
https://public-inbox.org/git/36e3a9c3-f7e2-4100-1bfc-647b809a09d0@jeffhostetler.com/

Now we have this similarly themed thing.

I think we need to be mindful of how changes like this can add up to
very confusing UI. I.e. in this case I can see a "how take make git fast
on large repos" post on stackoverflow in our future where the answer is
setting a bunch of seemingly irrelevant config options like reset.quiet
and status.aheadbehind=false etc.

So maybe we should take a step back and consider if the real thing we
want is just some way for the user to tell git "don't work so hard at
coming up with these values".

That can also be smart, e.g. some "auto" setting that tweaks it based on
estimated repo size so even with the same config your tiny dotfiles.git
will get "ahead/behind" reporting, but not when you cd into windows.git.

>> Just on this implementation: The usual idiom for flags as config is
>> command.flag=xyz, not command.flagDefault=xyz, so this should be
>> reset.quiet.
>>
>
> Thanks, I agree and fixed that in later iterations.
