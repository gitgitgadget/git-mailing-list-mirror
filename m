Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7B060FE3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhI1R3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:29:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56342 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbhI1R3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:29:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83D9A15F179;
        Tue, 28 Sep 2021 13:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SmXZgrM7Y1Hw
        DuXHHj+7RttfY9inESu8jynoEYMQ7SQ=; b=Y9gAUsfXF5ykcJ+00jQq823ZZ8Hv
        169IOgO3MTpsd64VMrFAbzx7FPx6yVDKDDsBF3LoPiinN+FTmk1Y2FTlz19Itofu
        bUcy488xY3mgVouOajQ/JW/9/3W3dYveD/7g8nNH9YVNNKYzcg+0MktHnPMarMKP
        ktDoumvxoXrFMN4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C98315F178;
        Tue, 28 Sep 2021 13:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 514D415F177;
        Tue, 28 Sep 2021 13:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <87ilylxg85.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 10:27:50 -0700
In-Reply-To: <87ilylxg85.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 10:07:41 +0200")
Message-ID: <xmqqczoslieh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 683F4B8C-2081-11EC-90BA-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Sep 27 2021, Elijah Newren wrote:
>
> [Aside: I quite liked the method of replying to What's Cooking per-topi=
c
> in Johannes's replies to
> https://lore.kernel.org/git/xmqqsfyf5b74.fsf@gitster.g/; I'm never quit=
e
> sure if I should have one E-Mail with all of my comments on other
> in-flight work, use existing commentary as a springboard etc. Doing the
> latter here]

Yup.  Splitting them out may be more work to produce comments, but
it lets you Cc relevant folks and would be easier for those who
participate in the discussion.
