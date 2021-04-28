Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF8C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 02:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15421613B1
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 02:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhD1CTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 22:19:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63613 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhD1CTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 22:19:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C46AC1232E4;
        Tue, 27 Apr 2021 22:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=B6Bd6jHmN7QgggN0N1PldRWMAvdZ0ToqG/zmqhGY29A=; b=Jtq5
        pWsv/Fo0KDiyB2zbd4dSivykmkYyUlDBz9tEFnKDfY90M4H7LTcf/pigICQWsDNt
        VDvytSxjMKSVIDueUdpMdF98o9f90RFWtDJ3wGeBmMU1AJM3GRSe1DXi7KWOMHwY
        GU+fToqV8Pau4V1eCnO4Z2Op2thbO/qdxRQHbXQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC87D1232E3;
        Tue, 27 Apr 2021 22:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3FD41232E2;
        Tue, 27 Apr 2021 22:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/8] rev-list: implement object type filter
References: <cover.1618234575.git.ps@pks.im> <cover.1618832437.git.ps@pks.im>
        <xmqq1rb5985x.fsf@gitster.g>
        <YIKPwRFbgzKJ1EBg@coredump.intra.peff.net>
Date:   Wed, 28 Apr 2021 11:18:44 +0900
Message-ID: <xmqqwnsncfsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F7DE0A8-A7C8-11EB-8725-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Thanks.  Will queue and wait.
>> 
>> I am expecting to go offline for about a week starting 21st or so;
>> hopefully the topyc is ready to merge it to 'next' by the time I
>> come back online.
>
> This iteration looks good to me.

Thanks, both.
