Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9270C83F12
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 01:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjH3BAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 21:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjH3BAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 21:00:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADFDCC4
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 18:00:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B34D195319;
        Tue, 29 Aug 2023 21:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xggHA0q2vaNiZUgV2TDzZuls++0ReXoiP8Mw0U
        /asCc=; b=oJ/feCXyToaskPtPa+uBWtTn0htscqdmlOqF9T1XpB+HmN8aqnglFW
        IbXRowndqmwlrnfUbcf2oBE5xNsprFcipaohdl8DTpWwMe8dpin1QBkNhGcLW8JQ
        icA2rzshSW4S1ggB0+R6LZ2kl4OH19o4DqC5wmsXchq5DfAIrw4lk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30C02195318;
        Tue, 29 Aug 2023 21:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68A8D195316;
        Tue, 29 Aug 2023 21:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/22] Yet Another Unused Parameter Series
References: <20230828214604.GA3830831@coredump.intra.peff.net>
        <20230829234305.GA226944@coredump.intra.peff.net>
Date:   Tue, 29 Aug 2023 18:00:10 -0700
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 29 Aug 2023 19:43:05 -0400")
Message-ID: <xmqqwmxd9wf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 922D75B4-46D0-11EE-BEE0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 28, 2023 at 05:46:04PM -0400, Jeff King wrote:
>
>> I'm back with another exciting installment of -Wunused-parameter warning
>> fixes. Most of these are pretty boring and obvious; the first two are
>> the most interesting in terms of rationale.
>> 
>> I promise we're closing in on the finish line here. I only have about 20
>> patches left after this, at which point we should be able to turn on the
>> warning by default for developer builds.
>
> And here's a v2 based on feedback from round 1. The changes are small,
> so I'll let the range-diff below speak for itself.

The first one in this round is consistently more conservative
compared to the previous round, which is very nice.

All other updates do look good, too.

Will replace.  Thanks.
