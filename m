Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC2C48BCD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 02:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED41261407
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 02:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJCaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:30:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53547 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 22:30:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7702114FB9E;
        Wed,  9 Jun 2021 22:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4rJil9YICmGk
        GWR9uzwKwAFNjVkdF+Xuge7nwdrlKS4=; b=lYxoI6/SXzTacEIocNhmgfkls1Zr
        aRzQ5sYTgqGXFgbeDujUsUdw2dNab8Z+hFMlhvc7zqVdVEHgAulY+h8YVyndmMP8
        0rzJRogVOo/DHdz5bpIlDqFOFUspB+BhB7baLXhl5013QIt3FQEGlSmETPz1EbAh
        eEkkPzxqVAt46Pk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E55714FB9D;
        Wed,  9 Jun 2021 22:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B880D14FB9B;
        Wed,  9 Jun 2021 22:28:09 -0400 (EDT)
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
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <87a6nz2fda.fsf@evledraar.gmail.com> <xmqqsg1qh3wo.fsf@gitster.g>
Date:   Thu, 10 Jun 2021 11:28:08 +0900
In-Reply-To: <xmqqsg1qh3wo.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        10 Jun 2021 11:03:35 +0900")
Message-ID: <xmqqmtryh2rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F4804F8-C993-11EB-B7A7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> + When it becomes awkward to stick to this style prefer "you" when
>> + addressing the the hypothetical user, and possibly "we" when
>> + discussing how the program might react to the user.
>
> Because I still get a funny feeling whenever I see a singular they,
> which I was taught to be ungrammatical in my foreign language
> classes long time ago, I kind of like this approach better, if we
> can pull it off.
>
> I wonder if we can avoid third-person entirely, though.

Git is primarily a communication medium used among developers, and
when one side is referred to as "you", the other side needs some
pronoun to explain inter-developer interactions.  We could say "you
as the integrator would have to ask my sign-off from me as a
contributor" to avoid third-person, but I suspect that this quickly
becomes just as awkward as using singular they.

I wonder if this makes it more workable:

    When it becomes awkward to stick to this style prefer "you" when
    addressing the the hypothetical user, and "they" in plural when
    you need to talk about a third-party that interacts with "you",
    and possibly "we" when discussing how the program might react to
    the user.

That way, we'd say "You'd ask their sign-off from contributors".

I'd stop here and continue watching from sidelines.

I think the topic tries to solve an issue worth solving, but I
suspect that a solution that requires singular they would not work
as well as a solution that doesn't would, especially for non native
speakers like me.
