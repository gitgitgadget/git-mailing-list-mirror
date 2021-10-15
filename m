Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E576C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453AD61151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbhJOTvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:51:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51571 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbhJOTvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:51:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FE60D8117;
        Fri, 15 Oct 2021 15:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LuhzCKLnrO9xQGaEXz4T+vyE3037clD/TFWvw5
        0UKfA=; b=uTJJ5pxWJHk0IK63yQMId/WN3BaQjOgFfbzWhlBrsojuivKxDGcW3B
        pouVcc6/7bvjgE4epmXp3pdJTofDVWTSgDIrB8ARCYg3yt5fa00ZifWFzRHKNSfu
        VwzcW9aLHpfcSvioy9e8O/iOtblyDF53U9FQOkdGgMiyl0OjRAK84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57DD6D8116;
        Fri, 15 Oct 2021 15:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB4FFD8115;
        Fri, 15 Oct 2021 15:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/3] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20211015161356.3372-1-someguy@effective-light.com>
        <K4711R.RVTNDQG3R0UQ3@effective-light.com>
        <xmqqk0ie5bpx.fsf@gitster.g>
Date:   Fri, 15 Oct 2021 12:49:38 -0700
In-Reply-To: <xmqqk0ie5bpx.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Oct 2021 12:28:42 -0700")
Message-ID: <xmqqczo65ar1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08B1BC18-2DF1-11EC-9A37-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hamza Mahfooz <someguy@effective-light.com> writes:
>
>> On Fri, Oct 15 2021 at 11:05:24 AM -0700, Junio C Hamano
>> <gitster@pobox.com> wrote:
>>> Makes readers curious what happend in v11 and later...
>>
>> It was my understanding that no comment means nothing changed since
>> then, or is something to the effect of "no changes" preferable?
>
> Usually people do not want to spam the list with a multi-patch
> series when they have nothing new to show, unless there are other
> reasons to do so, like "there is no change, but I am sending it
> again because nobody seemed to have time reviewing the series the
> last time", in which case that would make a good explanation to put
> there.

Ah, I thought I was responding to a cover letter.  OK, so you were
saying that there was no change in 1/3, but other steps may be
different.

In that case, that makes sense (even though it is more helpful to
just say "v13: same as v12" or something).

Thanks.
