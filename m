Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567DFC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiGRR0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGRR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:26:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61DC2A964
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:25:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54035144643;
        Mon, 18 Jul 2022 13:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vTYcwe7vvo/E
        Fzr3hnM5eD44Au9CjgQo/6ZCSxPYppY=; b=waylVYTkhlTiE20wJqFGOZ71n6CS
        ACwkOPhkzG8bF6gTXCy0mqIzxGK+D/4ftFd6E7GzWsRQQhSguWLKqiSNXPHfz/RK
        LXurGH05D1M6bn0U+GHFB8Nj3nlpcdLIje59E5FXb089XUKu6A86qZpo+6jBb8dW
        kBQIxqp6S0OuZBM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40885144642;
        Mon, 18 Jul 2022 13:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0958D14463F;
        Mon, 18 Jul 2022 13:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Subject: Re: jk/diff-files-cleanup-fix + related un-picked-up ab/*
References: <xmqq7d4bt8n4.fsf@gitster.g>
        <220718.86h73eyb31.gmgdl@evledraar.gmail.com>
Date:   Mon, 18 Jul 2022 10:25:54 -0700
In-Reply-To: <220718.86h73eyb31.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 18 Jul 2022 12:15:00 +0200")
Message-ID: <xmqqfsiyqqn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE904176-06BE-11ED-B3DE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jul 17 2022, Junio C Hamano wrote:
>
>> * jk/diff-files-cleanup-fix (2022-07-12) 1 commit
>>   (merged to 'next' on 2022-07-13 at 9db5235d01)
>>  + diff-files: move misplaced cleanup label
>>
>>  An earlier attempt to plug leaks placed a clean-up label to jump to
>>  at a bogus place, which as been corrected.
>>
>>  Will merge to 'master'.
>>  source: <Ys0c0ePxPOqZ/5ck@coredump.intra.peff.net>
>
> (As noted before) that fix looks good, thanks Jeff!
>
> But here's a gentle *poke* about picking up [1], which is a related
> follow-up series (but applies directly on master).

I was excited to see a pointer and hoped that it was to another
"oops, that was stupid and this is an obvious and clean fix".  But
instead it is another "here are six patches, that is a related
follow up to the series that needed that fix on top".

I'll get to it when I have enough concentration to allow me to spot
such stupid bugs before queuing ;-)

Thanks for a ping.
