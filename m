Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F70C3DA66
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjHXBVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 21:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbjHXBVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 21:21:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75D10E4
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 18:21:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B59211A3068;
        Wed, 23 Aug 2023 21:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2o9LQVNUz7Br0eZwCoJm/pm0Ec1f+/MO0qjcSk
        +PNIE=; b=Cd9IXe2Nh5b5uPxte1W2+c02NlS2AgTNq5PZb3/Zcl//QyBrAXJkZX
        PWvjQSccZ7lc+3vK0r5vanD5f92CbCGn/zCemM9Q3c9q+2arn2uKdL2tC9RvqJBD
        xV7Ob2u/RpbRsZyiPnRtIIHNqQno85ugLX9wyJE2+G8g4uGPGw/40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADB1B1A3067;
        Wed, 23 Aug 2023 21:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18F9E1A3066;
        Wed, 23 Aug 2023 21:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
References: <ZOYdG8RtPIgymtBV@nand.local> <xmqqpm3dg27i.fsf@gitster.g>
        <ZOZR0jesPpCDNbRj@nand.local> <xmqqh6ope8v6.fsf@gitster.g>
        <ZOZ+cbkrXsEcQyaW@nand.local> <xmqqcyzde7r2.fsf@gitster.g>
        <ZOaJXSZu4Bv6aXEH@nand.local>
Date:   Wed, 23 Aug 2023 18:21:33 -0700
In-Reply-To: <ZOaJXSZu4Bv6aXEH@nand.local> (Taylor Blau's message of "Wed, 23
        Aug 2023 18:34:05 -0400")
Message-ID: <xmqqo7ixck0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9037DECE-421C-11EE-A143-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Aug 23, 2023 at 03:03:45PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > No specific reason to expect bugs. Just trying to line things up so that
>> > we have (a) people around when the release is tagged, and (b) don't have
>> > a release hanging over our heads either during or immediately after a
>> > week when most US developers are offline.
>>
>> That is exactly what I call "expecting a post-release fixes".
>>
>> A much more important thing is to make sure we catch them before the
>> release and devise ways to help us do so, perhaps opting more userbase
>> into testing early.
>
> I agree, but shouldn't we still plan such that we have folks around for
> a week after the release in case something was missed?

I would rather want to see us try hard to avoid regressing in the
first place, instead of plan to have regression in the release and
have folks around after the release date.

