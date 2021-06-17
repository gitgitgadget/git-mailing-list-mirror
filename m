Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C53C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009B961359
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhFQALa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:11:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58010 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFQAL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:11:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1931DD7E18;
        Wed, 16 Jun 2021 20:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vwfzHnbWpSgy
        PYW2WnL9sfe6Hvg2LzKLYrwwGcY8HlE=; b=vrgOUHyCK3vtlHPdJ/5XaMlZ+fz1
        Ol1fz6eHGlJbgsAy7m1OW/Z+yWOcY2qvaro8PlIXqkMxEBGi1Nagf1+2EB1CQCBe
        o5G83+RazuJ6J6NGC7bhvg3B0EFljL67CodxTsk9KS2WUIqkgQZV03qDWZJcCF0x
        7Fi6aWc44Zy3qng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E1CDD7E17;
        Wed, 16 Jun 2021 20:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B788D7E16;
        Wed, 16 Jun 2021 20:09:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
        <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
Date:   Thu, 17 Jun 2021 09:09:20 +0900
In-Reply-To: <87bl85y15s.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 16 Jun 2021 21:54:20 +0200")
Message-ID: <xmqqtulxnyhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4430CFC2-CF00-11EB-BE8A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>   - Discussing command-line options, and program functionality:
>
>     Prefer succinctness and matter-of-factly describing functionality i=
n
>     the abstract.  E.g.
>
>      --short:: Emit output in the short-format.
>
>     Avoid more verbose constructions, such as:
>
>      --short:: Use this to emit output in the short-format.
>      --short:: You can use this to get output in the short-format.
>      --short:: A user who prefers shorter output could....
>      --short:: Should a person and/or program want shorter output, he
>                she/they/it can...

This applies the most broadly and addresses common readability
issues, which is why I like this part the most.

>   - Addressing the reader:
>   - Discussing Git, "the command" etc.:

I am not sure if these are even worth saying, especially when we do
not explain why we recommend to do so.

>   - Discussing other users:
>
>     When referring to other users on the same system prefer talking
>     about "a user" or "another user". There's usually no reason to
>     invent a cast of characters with names, titles and hobbies.
>
>     Your OS's users don't cleanly map onto any particular people, a use=
r
>     of git might be having a merge conflict with another person, or an
>     automated commit from a cron daemon.
>
>     We prefer the style typical of standard library adn system tooling
>     documentation in this and most other cases, you can look at the
>     documentation of chmod(2) and other commands, syscalls and librarie=
s
>     that deal with UIDs or GIDs for examples.

I cannot exactly put my fingers on where this feeling comes from,
but this part appears to spend many lines to tell me very little.

For example, it is unclear why the second paragraph is there at all.
Sure, some commits may be created by a non people, but how does that
fact affect how I write the documentation?  Writing about such an
activity by non people, what are our recommendations?  The third
paragraph does not do much better.  Unless you have UNIX man pages
handy, chmod(2) may not be very easily accessible.  It feels as if
it wants to encourage descriptions without human actors, without
doing a very good job at explaining to readers why the guideline
does not want to see them in our documentation.

Unlike chmod(2) and getpwnam(3), but more like any dSCM, Git is a
tool to help inter-person communication, and at some point we will
have to talk about contributors asking their upstreams to pull their
work from their repositories.  It won't be like system calls dealing
with pure numbers.  We do not have to give them names like Alice and
Bob, but we do have to refer to repositories of these cast of
characters individually to clearly explain/describe how data flow
among them.

>   - Discussing other systems:
>
>     As with discussing other users, git might interact with other
>     systems over the network. In these cases we also avoid a cast of
>     characters, preferring to talk about concepts like "fetching data
>     from a remote", having a conflict with "diverging histories" etc.

Unlike the above "other users", I have littleproblem with this part.
It however feels funny to warn against use of "cast of characters",
when the first sentence talks about "with other systems", which are
clearly not people.  Even when you are "fetching from a remote", you
are getting the result of work by "other people", so I would not
have separated "other users" and "other systems" in separate
sections.

> The references to "gendered prounouns" etc. are gone, perhaps there's a
> good reason to re-include them, but the point of "isn't that issue
> solved by recommending an orthagonal approach?" is one of the many
> things Stolee hasn't been addressing in the threads related to this
> series.
>
> To me that whole approach is somewhere between a solution in search of =
a
> problem and a "let's fix it and move on". Not something we need
> explicitly carry in our CodingGuidelines forever.

This I think is the crux of the differences between you two.  I'd
love to hear Derrick's response and eventually see a middle ground
reached.
