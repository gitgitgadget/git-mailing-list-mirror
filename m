Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA50C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhLGS3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:29:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhLGS3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:29:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 339CB10A067;
        Tue,  7 Dec 2021 13:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xaj2y9/FT6UkSdEnC5YWUxvtPpcNJlhVpnxpNl
        TM0bQ=; b=eKTUuqsWa3xo7axUQ9Rw0xO7LuW53fQUDcbkoggfU7W9Py0fX80N8c
        sK6+cz0jlSqj08dy8oGH6KaKRi/O5B+YHtgxu+t/ARQP5ju9msrG9hGrq48GSRxp
        TXZgRg04Eydz1zhtAdmsM91d2s1CvJo6A08UNpJ0IGsWMOpN1CLr8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2932410A066;
        Tue,  7 Dec 2021 13:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E4F710A065;
        Tue,  7 Dec 2021 13:26:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: en/keep-cwd
References: <xmqqh7bpqhf0.fsf@gitster.g>
        <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
Date:   Tue, 07 Dec 2021 10:26:18 -0800
In-Reply-To: <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 6 Dec 2021 22:00:32 -0800")
Message-ID: <xmqqh7bk8e5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C3E83A0-578B-11EC-872E-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Dec 6, 2021 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/keep-cwd (2021-12-01) 11 commits
> ...
> If it helps, there are two parts to the review:
> - Do we want this feature?

I think we pretty much covered that we are for this behaviour
change.

> - Does this patch series implement the feature correctly?
>
> On the latter point, several folks provided useful suggestions.  I
> think I have addressed all their feedback so far, though no one has
> explicitly verified that.  Further review and/or acks to verify that I
> have indeed handled feedback to others' satisfaction would be welcome
> if anyone has the spare time.

Indeed.

Thanks.
