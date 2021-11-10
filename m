Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F072EC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD7B61247
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKJVqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:46:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63504 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhKJVqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:46:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCFCC1010E8;
        Wed, 10 Nov 2021 16:43:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FFRbenTd+d2rrz8wMdMlxgvn8qsr6q+3qUpagC
        K2Ao8=; b=d4X7nFy6QAs1jydLhxEaMwqxo4AFORqGmRLZ3EZD6FHZiZz8U4/2WQ
        2KpoyL3QGBQ22VCC41I8avbricNdFyri0lprfKaItqy1pZKmywUTCVfb4djLUk9A
        8FrSZfd3ohoTc4n6ofyYp/4rw71dgCMDGwcCt3QfBPHXVCwAtw+FI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D56721010E7;
        Wed, 10 Nov 2021 16:43:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5084F1010E6;
        Wed, 10 Nov 2021 16:43:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Altmanninger <aclopte@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
References: <xmqq4k8kzuz2.fsf@gitster.g>
        <20211110063547.xcpjjzoobha3eeff@gmail.com>
        <YYuBY3jIjqrMxNPJ@coredump.intra.peff.net>
Date:   Wed, 10 Nov 2021 13:43:52 -0800
In-Reply-To: <YYuBY3jIjqrMxNPJ@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Nov 2021 03:22:59 -0500")
Message-ID: <xmqq8rxvy9d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C792E6C-426F-11EC-8146-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 10, 2021 at 07:35:47AM +0100, Johannes Altmanninger wrote:
>
>> > Fixes since v2.33
>> > -----------------
>> > 
>> >  * Doc update plus improved error reporting.
>> 
>> This should be something like
>> 
>>  * Warn when iconv(3) fails to reencode log messages.
>
> Yes, though note that we ended up reverting the warning. So probably it
> could be removed from the release notes entirely.

True.  Thanks for carefully reading these entries, all.

