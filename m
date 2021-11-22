Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57172C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhKVRLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:11:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59262 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhKVRLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:11:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F69D1532D2;
        Mon, 22 Nov 2021 12:08:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uYd/tc1mosV1
        R5tzuQIa73hL1KsV4uvyiHGn/O0lKHQ=; b=rfj+47Nm6xuAnW0xXdAAQa6FtBht
        4zXBFy8YwuZcZRaqMi6iQiIQHcKM0Rsfy+YH8BKLfHVzjz6hX+c/qNYfeC4VDLaH
        H8lfncDCuuF+U4xdabaIIxCsh7AG8l3KXqvRfDtIDGh0/JaVsmrChUOXDetlyNnX
        ErqaTCWxym0FnnI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 075821532D1;
        Mon, 22 Nov 2021 12:08:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 678FD1532CF;
        Mon, 22 Nov 2021 12:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
        <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 09:08:04 -0800
In-Reply-To: <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 22 Nov 2021 17:22:34 +0100")
Message-ID: <xmqq8rxgi0ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C21C5630-4BB6-11EC-958F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think an alternate direction of simply getting rid of "argv" is bette=
r
> in this case, and I've just submitted a topic to do that:
> https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avar=
ab@gmail.com/

I see you just submitted, but I am more curious on when you started
working on it.

Thanks.
