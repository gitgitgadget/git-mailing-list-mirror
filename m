Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB5EB64DD
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHMWJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 18:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjHMWJH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 18:09:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753710C4
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 15:09:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1F7E1B7D11;
        Sun, 13 Aug 2023 18:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4yE1MvFcNMO51Ow5WlI/5x8V523nzSIUoIp3hV
        KliqE=; b=MroB1GvAeSvk+B02/sguJsQHuvgIpj5XSp1kvGR0+xTbX0pL2158sy
        Edn9kZ3ZH8Ree3jwbHWMAHE5crZkbmivtFoSGEkwR9/VHdJHWBiHANcoHKT9UK6F
        gz4BCqmCwNx6j3JseQrDL2F7kHrpvkqg6mi9JzaSjrES20cIlfsCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6AA31B7D10;
        Sun, 13 Aug 2023 18:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B85CB1B7D0E;
        Sun, 13 Aug 2023 18:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Linus Arver <linusa@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com>
        <owly5y5mh81i.fsf@fine.c.googlers.com>
        <07028529-cbe1-55d0-4ab0-9f3ec03a4fd1@gmail.com>
        <ZNclyKWYw4j0C7wM@ugly>
Date:   Sun, 13 Aug 2023 15:09:02 -0700
In-Reply-To: <ZNclyKWYw4j0C7wM@ugly> (Oswald Buddenhagen's message of "Sat, 12
        Aug 2023 08:25:12 +0200")
Message-ID: <xmqqy1iemw75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 038C206E-3A26-11EE-B7DD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Aug 11, 2023 at 04:10:55PM +0100, Phillip Wood wrote:
>>On 10/08/2023 23:00, Linus Arver wrote:
>>> Hmph, "repeatedly reverting the same commit" sounds wrong because
>>> strictly speaking there is only 1 "same commit" (the original commit).
>>
>> While it isn't strictly accurate I think that wording is easy enough
>> to understand.
>>
> yes, but why would that be _better_ than saying "repeatedly reverting
> reversions" like i did?

To me at least, "repeatedly reverting reversions" sounds more like a
riddle, compared to "repeatedly reverting the same commit", whose
intent sounds fairly obvious.  An explicit mention of "commit", which
is a more familiar noun to folks than "reversion", does contribute to
it, I suspect.

That would be how I explain why one is _better_ over the other, but
of course these things are subjective, so I'd rather see us not
asking such questions too often: which is more familiar, "commit" vs
"reversion", especially to new folks who are starting to use "git"
and reading the manual page for "git revert"?

