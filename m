Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0CC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0448E613CF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhFKASL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:18:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51309 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFKASL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 20:18:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42419CA17F;
        Thu, 10 Jun 2021 20:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D4SnfcOJMbQ7K9LShD5mu2XnDLEswNBLvy6Dow
        E1JPw=; b=jsAOh6Bq7r6IfOEJACv5JgVs0ps+UljXMMWqhao28CUanzGiY4ydx1
        jL1XzudRgPcVzJJLjur1eN0z3sm6x/j7GHzD3D2lqRIlj+rK7IVcRNYswTNiGEv3
        BkmN8kqu6jrKhFG3TxbdlRQERLMhl5ZGJtwKujSrA5r8Egzrfz/Eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37ECCCA17E;
        Thu, 10 Jun 2021 20:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB8F8CA17D;
        Thu, 10 Jun 2021 20:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
        <60be91757c6ca_db80d2086e@natae.notmuch>
        <87czsu98ar.fsf@vps.thesusis.net>
        <790688e5-6816-9837-85e7-2fdbbdf24169@gmail.com>
Date:   Fri, 11 Jun 2021 09:16:13 +0900
In-Reply-To: <790688e5-6816-9837-85e7-2fdbbdf24169@gmail.com> (Derrick
        Stolee's message of "Thu, 10 Jun 2021 14:30:04 -0400")
Message-ID: <xmqqwnr1cl2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B5BF7B0-CA4A-11EB-BC73-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Singular "they" works the same as singular "you". For example:
>
> 	...means that _you are_ completely satisfied...
>
> Singular "you" had a similar backlash in the 1660s as singular "they"
> is having in this thread, but singular "you" has lasted (and we use
> "thou" only to signify someone using old-timey language).
>
> There is more of this in [1] and [2]
>
> [1] https://public.oed.com/blog/a-brief-history-of-singular-they/
> [2] https://en.wikipedia.org/wiki/T%E2%80%93V_distinction#English

Thanks for references.  [1] was an amusing and illuminating read.

    ... Anyone who said thou and thee was seen as a fool and an
    idiot, or a Quaker, or at least hopelessly out of date.

    Singular you has become normal and unremarkable. Also
    unremarkable are the royal we and, in countries without a
    monarchy, the editorial we: first-person plurals used regularly
    as singulars and nobody calling anyone an idiot and a fool. And
    singular they is well on its way to being normal and
    unremarkable as well.

