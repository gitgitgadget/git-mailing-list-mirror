Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF6C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B176108D
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhEYRN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 13:13:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhEYRNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 13:13:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D605FD0BC7;
        Tue, 25 May 2021 13:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=64aWJBXkcPBT53bxJyri87oKXu0lVEC8uzFcp6ppASE=; b=GK4E
        2xfxrZZMGoVO+LrLJsPB5l+QbBvY44A/UH7wyqHaWZLp+aEixd2kPQHNXnZ9BKYh
        OOZw3Caw17/fAnYkqaQlmxbPCUoOFg+uezsXlQgwvsU1XZsHGcyiEI6mmEh4vBxS
        dgg1wSEFTnsHR6M14TRUXgvYV2UWQtXxO5bIA0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD5AAD0BC6;
        Tue, 25 May 2021 13:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C462D0BC5;
        Tue, 25 May 2021 13:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
        <20210521222941.525901-4-felipe.contreras@gmail.com>
        <xmqqcztgj9za.fsf@gitster.g> <60abf32038579_1b209208d2@natae.notmuch>
        <xmqqwnrnh626.fsf@gitster.g> <60ac9f332eeec_225d820832@natae.notmuch>
Date:   Wed, 26 May 2021 02:11:53 +0900
Message-ID: <xmqqim36eo12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DCEDA50-BD7C-11EB-9BCA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >  * helped-by: 17% (1336)
>> 
>> I actually think people use this one to say "person X gave a
>> valuable input in the review discussion", which is exactly the case
>> here, and that was why I wondered you needed to invent a completely
>> new one.
>
> I think the opposite: "helped-by" encompasses virtually anything...

But your own stats disagrees with your opinion, so don't invent a
new thing, period.

