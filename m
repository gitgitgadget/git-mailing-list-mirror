Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD30C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DBD61139
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhJFU1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:27:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62559 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJFU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:27:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73BF2EA972;
        Wed,  6 Oct 2021 16:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGtk3chYJZKByK71kU+P6KbUZw/T0RwZ7JkPTD
        bq/v0=; b=WdlmG6KOaBlwjySypcCwaPf0i8l/pmkgCDmnfiPT9af2aRdQ1i5TC+
        ywZJstFRhEEyjFfBKmYWeMx64zgDK9tdD3+pEgGeWRUxky/bsGfEWW5/58KnIWZC
        l/KYT92Rk87WthNdLW4uF3OsllpuxGQpYfehvQrx0ZfbWRHZ509dU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 697ABEA971;
        Wed,  6 Oct 2021 16:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC4D7EA970;
        Wed,  6 Oct 2021 16:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <87r1dydp4m.fsf@evledraar.gmail.com>
        <87ilz44kdk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
        <87mtofnzv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
        <xmqqilz32hhr.fsf@gitster.g> <xmqq1r5qzv35.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet>
Date:   Wed, 06 Oct 2021 13:25:10 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Oct 2021 22:09:47 +0200 (CEST)")
Message-ID: <xmqqr1cxrjdl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81CA1128-26E3-11EC-AA5B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I don't think that there is a lot of sense in that. The main benefits of
> `scalar` are in the `register` and the `clone` part, and the most natural
> end game would hence be for `git init` and `git clone` to sprout new
> options to support Scalar's features, in a Git-native way.

Yes, that is even better.  An endgame where everybody benefits
natively would be highly desirable.

Now you are back, do you think we can have the "no more preserve
merges backend" topic graduate to 'master', or do you prefer to cook
it over the cycle (or even two)?

Thanks.
