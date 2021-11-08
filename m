Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D4C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3531610CB
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhKHTRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:17:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65203 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKHTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:17:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4866E16B6F9;
        Mon,  8 Nov 2021 14:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hTdR4z680ipqODeUbzergtgKiBiOAVZpdtqxAe
        D33Bk=; b=sM5rrN/E0qcbuRKyb0zDTZpdRaSs5DmWC7axgmFxesavQvL01dz7Qo
        ubz7kzzYM7ROQ/8zpcrm3vzTVNNPYCJRZPih2LmmpWVradxS5c4qphSGv24ntrx9
        s2hSKmMrkLwHil1IBpMVBT9oqrM7qVvGjIzqacV3M6BVLOU7yOFg4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40AA816B6F8;
        Mon,  8 Nov 2021 14:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A537A16B6F6;
        Mon,  8 Nov 2021 14:14:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <20211105193106.3195-1-adam@dinwoodie.org>
        <xmqqk0hmwc0c.fsf@gitster.g>
        <AS8PR02MB730266C2B87493F2AF712D989C919@AS8PR02MB7302.eurprd02.prod.outlook.com>
Date:   Mon, 08 Nov 2021 11:14:41 -0800
In-Reply-To: <AS8PR02MB730266C2B87493F2AF712D989C919@AS8PR02MB7302.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Mon, 8 Nov 2021 16:40:29 +0000")
Message-ID: <xmqqbl2uv4ri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20A463F4-40C8-11EC-927F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

>> 
>> > To avoid this happening, before creating the keys, clear any default
>> > ACL
>> 
>> "happening" -> "from happening"
>> 
>
> No, original is correct.
>
> To avoid this happening.
> To keep this from happening.
> To prevent this happening. 
> To prevent this from happening. 
>
> Would I think all be correct.
> "to avoid from" is not right.

But I meant to say "to avoid this from happening", not "to avoid
from", which I gree is not right.
