Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiGUGNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiGUGNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:13:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EE77B1F9
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:12:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A3C1134088;
        Thu, 21 Jul 2022 02:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FGAuwMqahb1qCUngJ838M85xr3zVrpM+OTDUiP
        Vd4wE=; b=awPSSBKIhAywRv02aohO0Wor+9cAoOmdGqg+Kct8RgJIE+RyIBQllf
        +LCieLzdHhVk3bR2ySPqhr162YDsYsUI7iZ1crg6FhEUqFLOuc5O994yun7MiPnF
        LpMjRyBCJ0ztr2oGkR4j24eRRlkA22+BkqKlc2tT1G18tK11ytg2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50E26134086;
        Thu, 21 Jul 2022 02:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3232134085;
        Thu, 21 Jul 2022 02:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
        <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
Date:   Wed, 20 Jul 2022 23:12:41 -0700
In-Reply-To: <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
        (Abhradeep Chakraborty's message of "Thu, 21 Jul 2022 09:37:12 +0530")
Message-ID: <xmqq7d47m1t2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 217A16F4-08BC-11ED-80E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> On Sat, Jul 16, 2022 at 7:20 PM Abhradeep Chakraborty
> <chakrabortyabhradeep79@gmail.com> wrote:
>>
>> Hello,
>>
>> I need the CRoaring[1] library to use roaring bitmaps. But it has
>> Apache license v2 which is not compatible with GPLv2[2].
>
> I have reached out to Daniel and he agreed to make CRoaring
> dual-licensed under MIT and Apachev2[1].
> Now, I can use CRoaring, right?
>
> [1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A
>
> Thanks :)

Nice.
