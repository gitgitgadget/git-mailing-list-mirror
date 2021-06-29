Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB6C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3D66187E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhF2BPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:15:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53019 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhF2BPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:15:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7A701326F7;
        Mon, 28 Jun 2021 21:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LQh+c5ebcvxUGVDniwmBolk2tM8+ANRgnaB0ygflgys=; b=ULmB
        S1wsWAERqtGGOFOeOLfGi9MvTN+tpHNrH1QWQd8WO40B0HSWcyH6gfwMVSEyfQcc
        M4tNo2XdZJoO179w5J3l+GGsYGobeshV/RUvA72lq+pdJp9dThEDWeVUamFWpeRa
        nNC5+A9SJvZwSHlwwQNU8BxAWkccinUlaB3khL4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A06E81326F6;
        Mon, 28 Jun 2021 21:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA8F61326F5;
        Mon, 28 Jun 2021 21:12:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
        <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
        <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
        <YMfLO9CT+iIDR3OA@google.com> <87lf7bzbrk.fsf@evledraar.gmail.com>
        <YM0alLP5U81D+ZI0@google.com> <87im2848pn.fsf@evledraar.gmail.com>
        <YNEoMZ1QhZwmS0v2@google.com>
Date:   Mon, 28 Jun 2021 18:12:43 -0700
Message-ID: <xmqqzgv93244.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C23E976-D877-11EB-B3F3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Ok. Thanks for clarifying.
>
> Yes, I do like this direction, and I'm pleased you were able to chop it
> up in a way where partial submission made sense - I struggled with that,
> myself. Yes, I am excited that you want to drive this series :) :) and
> will be happy to rebase on top of it.
>
> I'll have a look at the range-diff for v3 this week. Thanks.

Thanks for working together so well.  Very pleased to see
contributors and reviewers working together constructively.

