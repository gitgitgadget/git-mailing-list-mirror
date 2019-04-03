Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6C420248
	for <e@80x24.org>; Wed,  3 Apr 2019 21:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCVHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 17:07:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42137 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 17:07:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so731933qtc.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDDWOucOhVKfDLm7kdQeslDgPlVVPK0xF9wbxFFOg3g=;
        b=HmxpdWlRmL5W3qhIg0EVB91PyQr3Fl0TIN2MWR1+BUP+O+k+DvB0kpFu433O/K97V3
         sNb0UHRRCjorwKCzKSYs6a1UcgqTJiMm8Cr1gW0eLR6C+SyfmQb0dVU8OOAvpSSG4ozQ
         YkjFLugOjDzB+N2XhYOr8hLoykcXZdDfd6ntQuL3Ii8mGY5L7HpsryjgW++HsC9ASJ64
         GrDjrm47WEpRMmJnfKB00b3TkahVuotj0WtFWg1ovr3ZjlOSvKyad88yFiMtw5DgiNLw
         w5y+PCE1RiC/IAi47lXUPSOmaNLplVnlp81aELC5nYaEa229hag+J+IA7cCaq9obuUDK
         /6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDDWOucOhVKfDLm7kdQeslDgPlVVPK0xF9wbxFFOg3g=;
        b=gBcrWWpfEYikvWfUjIqiJVlMbbkJ7zEgk7hXL5B1M58KbJC8vMlMI352urLZW3ccyf
         ynL2tG/2QnBDolFd/OeSub5xlkLOQcd4EQIr64Sqk6db8cX0rbvHh5wErjXqyk5RoEj5
         LkQaQVmoEeHu0EBj5qNWCKjQ9m93+aPd2OBwM+N1eQty9TtfRKv+6RKq+clzqIaI9Tbv
         mS6VDY+pkxv0lM+8r3ATo/75furZFZOMeG/EIA7jQZylukUfdbyHdIN2Xi5HT2zEb4rM
         NGz4RqvaeqbpPCTCbfs0wva/LJTQbhtbZEptltiBpdcrQ9bnntkGW3srUaiOnap3NDbb
         i5Dg==
X-Gm-Message-State: APjAAAXnnfkhaXFoG0ZQAxQbnWG00lCufCT+8UeeK+t2waJG6TWORluT
        Fyi2x2G1fANKKWp+YQ2r5ezUjPN/QaQNAlaVv9syyCiJ
X-Google-Smtp-Source: APXvYqw0XM6L0ch4R78C7dLEfJm4DBduPLR/85U0iL0wON4ylg/0Gq0KFDorGfCt92W59uQHUFgd2mq+G94JGdr/oJA=
X-Received: by 2002:ac8:2a2e:: with SMTP id k43mr2032004qtk.353.1554325668097;
 Wed, 03 Apr 2019 14:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904031957480.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904031957480.41@tvgsbejvaqbjf.bet>
From:   Khalid Ali <khalludi123@gmail.com>
Date:   Wed, 3 Apr 2019 17:07:34 -0400
Message-ID: <CAD8q83Rz6myozY1aJqaZjEfjgmSkQ0059=m=mmkJ9O90u+9spw@mail.gmail.com>
Subject: Re: [GSoC][RFC] proposal: convert git-submodule to builtin script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thank you so much for the detailed feedback. I wasn't sure
how much to include in the proposal, but I see it still needs a lot of work.

> When you talk about "Convert each main task in git-submodule into a C
> function." and "If certain functionality is missing, add it to the correct
> script.", it is a good idea to back that up by concrete examples.
>
> Like, study `git-submodule.sh` and extract the list of "main tasks", and
> then mention that in your proposal. I see that you listed 9 main tasks,
> but it is not immediately clear whether you extracted that list from the
> usage text, from the manual page, or from the script itself. If the latter
> (which I think would be the best, given the goal of converting the code in
> that script), it would make a ton of sense to mention the function names
> and maybe add a permalink to the corresponding code (you could use e.g.
> GitHub's permalinks).

Yes, I actually did extract the tasks straight from git-submodule.sh. I will
definitely add the appropriate function names and permalinks to the
proposal.

> And then look at one of those main tasks, think of something that you
> believe should be covered in the test suite, describe it, then figure out
> whether it is already covered. If it is, mention that, together with the
> location, otherwise state which script would be the best location, and
> why.

Ah, alright. I'll have a look at the test suite to see what is covered and
include a section in my proposal.

> Besides, if you care to have a bit of a deeper look into the
> `git-submodule.sh` script, you will see a peculiar pattern in some of the
> subcommands, e.g. in `cmd_foreach`:
> https://github.com/git/git/blob/v2.21.0/git-submodule.sh#L320-L349
>
> Essentially, it spends two handfuls of lines on option parsing, and then
> the real business logic is performed by the `submodule--helper`, which is
> *already* a built-in.
>
> Even better: most of that business logic is implemented in a file that has
> the very file name you proposed already: `submodule.c`.
>
> So if I were you, I would add a section to your proposal (which in the end
> would no doubt dwarf the existing sections) that has as subsections each
> of those commands in `git-submodule.sh` that do *not* yet follow this
> pattern "parse options then hand off to submodule--helper".
>
> I would then study the commit history of the ones that *do* use the
> `submodule--helper` to see how they were converted, what conventions were
> used, whether there were recurring patterns, etc.
>
> In each of those subsections, I would then discuss what the
> still-to-be-converted commands do, try to find the closest command that
> already uses the `submodule--helper`, and then assess what it would take
> to convert them, how much code it would probably need, whether it could
> reuse parts that are already in `submodule.c`, etc.

I definitely noticed the option parsing in multiple parts of the function, but
the pattern didn't click until you mentioned it. I'll do as you recommended
and take a look at submodule.c to see how the code and functionality in
git-submodule.sh can be merged.

> Judging from past projects to convert scripts to C, I would say that the
> most successful strategy was to chomp off manageable parts and move them
> from the script to C. I am sure that you will find tons of good examples
> for this strategy by looking at the commit history of `git-submodule.sh`
> and then searching for the corresponding patches in the Git mailing list
> archive (e.g. https://public-inbox.org/git/).
>
> Do not expect those "chomped off" parts to hit `master` very quickly,
> though. Most likely, you would work on one patch series (very closely with
> your mentor at first, to avoid unnecessary blocks and to get a better feel
> for the way the Git community works right from the start), then, when that
> patch series is robust and solid and ready to be contributed, you would
> send it to the Git mailing list and immediately start working on the next
> patch series, all the while the reviews will trickle in. Those reviews
> will help you to improve the patch series, and it is a good idea to
> incorporate the good suggestions, and to discuss the ones you think are
> not necessary, for a few days before sending the next patch series
> iteration.
>
> Essentially, you will work in parallel on a few patch series at all times.
> Those patch series stack on top of each other, and they should, one after
> the other, make it into `pu` first, then, when they are considered ready
> for testing into `next`, and eventually to `master`. Whenever you
> contribute a new patch series iteration, you then rebase the remaining
> patch series on top. Ideally it will look a bit like a fern, with the
> first patch series being along the farthest, and each subsequent patch
> series at an earlier stage than its predecessor.

Ok, so I'd be doing each of the portions and submitting them to the mailing
list as I finish to let other coders take a look and give feedback.

> Phew. Long mail. Hopefully this amount of information does not scare you.
> And maybe some of it will help you with the proposal and/or the project.

Once again, thank you for the detailed feedback. This really gave me a good
idea of the project as a whole and what I need to include in my proposal.

Sincerely,

-Khalid
