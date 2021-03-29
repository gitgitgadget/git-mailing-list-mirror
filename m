Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D65BC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5531061976
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhC2VE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:04:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhC2VDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:03:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1AFAC5F3C;
        Mon, 29 Mar 2021 17:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E6b31dAVDmNzw1B2JrlM42BEWFk=; b=mFWApq
        RXjY6vp+bl8mitPPjcLAG/kCQJztF8mfM4xTI1H5KnQ1TrcBkX0XxHFnFc0kmc10
        zuuerwFCEN47JDy2R4j7f/dJGDM8sZ04ZTadH11HOq9qsPUZcAi9vqOpDW17JVOS
        jJpyQmLpqVURSWq13DUtAkXryokwUFNzatYVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oaTJiJb+2hzNlFkaN60/GFzAZRmtukmC
        RUJ1nKg9mhQoNwpN1vxjiHp+ew8YyVaixRQLNpZ+y0/Z4WBssi/jk3MRVtmsU9yY
        GXCRIYgWzr17OPUXzMHVvvkn75oNXiCSbrUQDmEhO8TDkLtz/hXGmX+YfOP5Lh46
        v9ubqW1fgkQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A448C5F3B;
        Mon, 29 Mar 2021 17:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24ED4C5F3A;
        Mon, 29 Mar 2021 17:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Upstreaming Reviewed-by to git.git
References: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
        <CAP8UFD1TmckvQLVQ7eWMKakMKOF76J+Z+E25vUCGkWveXMWv1g@mail.gmail.com>
Date:   Mon, 29 Mar 2021 14:03:53 -0700
In-Reply-To: <CAP8UFD1TmckvQLVQ7eWMKakMKOF76J+Z+E25vUCGkWveXMWv1g@mail.gmail.com>
        (Christian Couder's message of "Mon, 29 Mar 2021 14:15:17 +0200")
Message-ID: <xmqqr1jxisee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4518D554-90D2-11EB-BD04-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Mar 29, 2021 at 1:03 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
>> I had reviewing patches here, but how can my reviews be credited with
>> Reviewed-by tags to the applicable patches on git.git (Git SCM)
>> repo (upstream)?
>
> When you have reviewed a patch or a patch series, you can tell the
> reviewer you are ok with the patch or patch series, and that you are
> ok with them adding your "Reviewed-by: yourname <youremail>" to it.

I think you meant "you can tell the reviewEE", not reviewer.

In general, anybody can review a patch, but a review by somebody who
is not all that familiar with the codebase does not carry a lot of
weight.  Reviews from those who have already invested a lot in the
code that is being fixed or extended would obviously be very
helpful, as they are expected to know how the current code is
supposed to work well, and reviews from those who have worked on
other parts of the system that depend on the code that is being
fixed or extended would also be usefl, as they know what the callers
of the code being changed expect out of it.

So my suggestion to Bagas is not to worry too much about
"Reviewed-by" with your name, until you have your own code in the
codebase (and while doing so, you should worry about adding
reviewed-by by others).

In any case, reading others' patch, together with the original
version before the patch changed, is a great opportunity to learn
the codebase and how the project work in general.  It is highly
recommended.

Thanks.
