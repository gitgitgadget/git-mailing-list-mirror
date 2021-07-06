Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84459C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5969561076
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhGFUiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:38:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:38:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B53D81355A5;
        Tue,  6 Jul 2021 16:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RFUXRhaWtcD3
        y9ZumTZXqpREXk/Jm011fkWU7wQz9Rw=; b=oz+0vjb2kDBQkIM0mGkESGcIpuDw
        vBkK9XD697+DgKjPUlyg1xux3dPeibP3Z0yZy3eBcptH/CccP7pHEv9IBJiFmhT6
        ZZvvhMnl4eEFckbzqFfsvlgopMnVOg8eE74UIAKHz10ex07j728sHBqvCfy5X5cT
        uSIshIXTrmx7SIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE4161355A4;
        Tue,  6 Jul 2021 16:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D8371355A2;
        Tue,  6 Jul 2021 16:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
References: <xmqq4kdft122.fsf@gitster.g>
        <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
        <d04c71fe-acfb-abe0-b00f-cfa01651dd57@gmail.com>
        <87k0m35jfi.fsf@evledraar.gmail.com>
Date:   Tue, 06 Jul 2021 13:36:02 -0700
In-Reply-To: <87k0m35jfi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 06 Jul 2021 21:29:38 +0200")
Message-ID: <xmqqbl7fi3il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C89C9A4A-DE99-11EB-97ED-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> FWIW I put it on my own mental list of "waiting for re-roll" per [1].
>
> (Not that you need to take my suggestion there, just that you seemed to
> agree, so I thought I'd take a look when that happened in a v2).
>
> 1. https://lore.kernel.org/git/094f5e5f-d447-8867-a9a7-be5c8827bba6@gma=
il.com/

Thanks for a reminder.  I should have noticed the message myself.
