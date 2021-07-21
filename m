Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84069C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C060720
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 18:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhGUReh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 13:34:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50601 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGUReg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 13:34:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9766FC0058;
        Wed, 21 Jul 2021 14:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j1JNYBhujE1c
        Pg+3McmYsqqssUNTPMwhnGAgIxRr0/w=; b=TCAvU1XEnRCR9FI2YAydZavuU/1l
        58EqyJ5hWRF4QaEOJzzblp1lS8dIqWHYqy1hHm2rUntlTeY3vxlPc+wXACi2JVYA
        d/lDV3BEVA2dODS6Or6WDZlLIcMxwvI0JjGHH+EfT8wPD8/AueYsJt2+QJAbwFBi
        Ta6UENxuNFKmVS0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E896C0057;
        Wed, 21 Jul 2021 14:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11811C0052;
        Wed, 21 Jul 2021 14:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #02; Thu, 8)
In-Reply-To: <87tul24iw2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 10 Jul 2021 10:56:19 +0200")
References: <xmqq8s2ga19f.fsf@gitster.g> <87tul24iw2.fsf@evledraar.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 21 Jul 2021 11:15:11 -0700
Message-ID: <xmqqsg07cz4g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96F4FA52-EA4F-11EB-814B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/serve-cleanup (2021-06-28) 8 commits
>>  - upload-pack.c: convert to new serve.c "startup" config cb
>> ...
> I have a re-roll of this queued locally. It seemed people were on the
> fence about the whole "startup config" thing so I initially planned to
> just drop it, but then I started fixing some other related serve.c code
> and found a good/better use for it, so maybe I'll keep it. Will post it
> soon.
>
> FWIW Han-Wen's "let's rename the serve() function" suggestion sent me o=
n
> an Odyssey of discovering various unused/overly-complex-for-no-reason
> code around protcol v1/v2 that I think we should just clean up...

I do not think the startup config thing got much traction, either,
but in any case did I miss an update for this one?

Thanks.
