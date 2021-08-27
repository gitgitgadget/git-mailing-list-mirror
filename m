Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4490C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846D460FE6
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhH0TsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 15:48:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57498 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhH0TsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 15:48:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACEFBDDB5C;
        Fri, 27 Aug 2021 15:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DRW1GhiSZ8JY/2Sx/CdZPMXD+R7LeuiYZaJNr5
        pF18s=; b=xZ5v8rhONagAUfUiJCvrZMxRCa+V2PJDSaUYTVXRPB/9bUILRLF1ip
        Rl73dD+2v9g1cGnI+Y9T+AOBmen2Pi/yYN7fp16gdR28hVi6AxFkdYt10qyyuYLA
        tMAVlbec0dIKzyu1/Fe7OTvdsJ2mwbfBcJG0DvqK1NTHS80QyO8GI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A15EEDDB5B;
        Fri, 27 Aug 2021 15:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C241DDB5A;
        Fri, 27 Aug 2021 15:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
        <xmqqeeahjxj4.fsf@gitster.g>
        <YSkvNyR4uT52de13@coredump.intra.peff.net>
        <YSkvpqiW09DugNoz@coredump.intra.peff.net>
Date:   Fri, 27 Aug 2021 12:47:08 -0700
In-Reply-To: <YSkvpqiW09DugNoz@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 27 Aug 2021 14:32:06 -0400")
Message-ID: <xmqqo89iacw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91369B4C-076F-11EC-94FC-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 27, 2021 at 02:30:16PM -0400, Jeff King wrote:
>
>> Here it is polished into a real commit.
>> 
>> Subject: [PATCH] logmsg_reencode(): warn when iconv() fails
>
> And here's a minimal documentation I'd suggest on top. We can discuss
> going further in discussing subtleties of iconv() if we want, but IMHO
> it would work to stop here.

Thanks, both patches look sensible.

Will queue.
