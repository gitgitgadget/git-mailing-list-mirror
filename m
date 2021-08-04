Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFEC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A160F94
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHDCBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:01:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52875 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHDCBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 22:01:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9149ADC43A;
        Tue,  3 Aug 2021 22:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3FLcNfPTMeRWUWGVox4K/BvFPOxsqvMCJgW53L
        fwafE=; b=Acltmluc1C2GBAFWivi6Lyqo/phaefrJ5PtnJZRX8eOP7YLAFJwUwj
        sigvkpfp10FlG7x2LFRF74QvgM12NXvbdiUjZeysqg+B+BnvOVAdc6fB1gO0aeBt
        jF9rpU+dDlpEutnd4PfQoeKxBfea5qV+Kh39wD5UjIyDX2elewy/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85D1ADC439;
        Tue,  3 Aug 2021 22:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 107CDDC438;
        Tue,  3 Aug 2021 22:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/10] merge-strategies.txt: update wording for the
 resolve strategy
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <3989f194ba91e64852285064b652979861445c03.1628004920.git.gitgitgadget@gmail.com>
        <xmqqmtpyrrhe.fsf@gitster.g>
        <CABPp-BErWux0inUR_FonzVwX0eKxGrjAofo+GYjMNE4FV0qwsQ@mail.gmail.com>
Date:   Tue, 03 Aug 2021 19:01:23 -0700
In-Reply-To: <CABPp-BErWux0inUR_FonzVwX0eKxGrjAofo+GYjMNE4FV0qwsQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 3 Aug 2021 18:37:11 -0600")
Message-ID: <xmqqv94mq87g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEEF5E9C-F4C7-11EB-93D4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Aug 3, 2021 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > The resolve merge strategy was given prominent positioning in this
>> > document, being listed first since it was the default at the time the
>> > document was written.  It hasn't been the default since before Git v1.0
>> > was released, though.  Move it later in the document, near `octopus` and
>> > `ours`.
>>
>> I think it was listed first because it was written first.
>
> Do you want it to be kept first for that reason as well?  I thought it
> made more sense to cover the default strategy first, but I can move it
> back if you prefer historical implementation order.

No, I was only correcting the guess described in the log message.

> I am unsure if your double negatives are intentional
> (not..never)...but I think you're saying it's okay to remove this
> text.

Yes.
