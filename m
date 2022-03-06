Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30305C433EF
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiCFV6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 16:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiCFV6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 16:58:42 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A930513CE1
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 13:57:49 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD5D5189197;
        Sun,  6 Mar 2022 16:57:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BpCV1w3vz3JDhduxeOSZ5qVhEwU39+npkrbLvL
        wd+o4=; b=L2mdTFgO0rmTH6KklUmv0mckWjYYnCWZOC+9onUZrU/vYdSpa4xKic
        H1+X8qV8676pdUPlmxzq417SyS/Xr1nsVk/YB1Rx6shB7aNwRi/QzSkzOsfAy3Sy
        wBAY9S+GtThrQprxzaqJ1a+KYwEg+woyFykPWZeg90n6DaAKu+6f8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98374189195;
        Sun,  6 Mar 2022 16:57:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4A92189194;
        Sun,  6 Mar 2022 16:57:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v3 0/2] Reduce explicit sleep calls in t7063 untracked
 cache tests
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
        <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
        <CAPMMpogoVzHBh8j4GZG-tRpAxap4wY+hAray5V_QUcaNpf7dEQ@mail.gmail.com>
Date:   Sun, 06 Mar 2022 13:57:43 -0800
In-Reply-To: <CAPMMpogoVzHBh8j4GZG-tRpAxap4wY+hAray5V_QUcaNpf7dEQ@mail.gmail.com>
        (Tao Klerks's message of "Sat, 5 Mar 2022 05:24:01 +0100")
Message-ID: <xmqqv8wqvj54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73FD538A-9D98-11EC-8E71-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> I see that in the latest "what's coming" update, this patch series is
> listed as expecting reroll, but as far as I can see there have been no
> comments since I sent this V3 out.

I see <v2> reference on the source: line for that topic in the
"What's cooking" report you are referring to, so I suspect I have
been too busy and haven't got around to replacing it with <v3>,
perhaps?

