Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1BB1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfH1PKi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:10:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57446 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfH1PKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:10:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 376AF173443;
        Wed, 28 Aug 2019 11:10:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AjgwRfUS9/yziEF53S2UpSy3zfM=; b=ZOGqOi
        Vgy7I64R0XA1+VRmj2fBvj8iQ0nOjjPiT2sTbkfqFExNy0KOkKQXiAtR8PDFLFVt
        qCDWOFPOWTibvjmfE9PkJ2TibQUm/Cr/OoEHgckbEptXwyE5HZnQuVOiDtbfhala
        bruu8OjD/i6K9GSDgXKpLy+d3XtgbZf8t//G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X/N0lMAMlLozuZ7E/0kdhjAk2axraXid
        20ojCxfXTLFfvdoHZIMweAJ9xYd3LkEI4b837QqkOQS4Y7AmFjZf17F4pBsSXrwA
        sibyewQqlYadqSoxcsR2dxzJNxanQ7dGx6twvsdC6fKN8U2x1uIEABOhPSzoeJnx
        VQsSG7mkcHY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EA77173442;
        Wed, 28 Aug 2019 11:10:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F969173441;
        Wed, 28 Aug 2019 11:10:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2019, #06; Fri, 23)
References: <xmqqpnkvl61q.fsf@gitster-ct.c.googlers.com>
        <CAPUEspi0z7cjdH7J5=VKcG1jXbhi0EeJecs-ApT39PyhAWp2Qg@mail.gmail.com>
Date:   Wed, 28 Aug 2019 08:10:34 -0700
In-Reply-To: <CAPUEspi0z7cjdH7J5=VKcG1jXbhi0EeJecs-ApT39PyhAWp2Qg@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 28 Aug 2019 02:55:06 -0700")
Message-ID: <xmqqo9091g2d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC96518E-C9A5-11E9-8C58-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, Aug 23, 2019 at 6:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
>>  - grep: avoid leak of chartables in PCRE2
>>  - grep: make PCRE2 aware of custom allocator
>>  - grep: make PCRE1 aware of custom allocator
>>
>>  WIP
>
> this was v3 and doesn't sufficiently address the issue raised on
> windows so might be better to drop it and requee it later ...
> we have two alternative versions of v6 that could be used as a reroll
> if you would rather do that, but will still not address the full set
> of issues that will be required to stabilize it into next.

It sounds like by queuing a premature iteration, by not picking up
updated ones and by not following the discussion very closely, I am
doing more harm than simply waiting, so let me step aside, drop this
one for now and let you folks figure it out.

Thanks.
