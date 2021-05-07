Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC0C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B4C613CE
	for <git@archiver.kernel.org>; Fri,  7 May 2021 08:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhEGIoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 04:44:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64907 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhEGIoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 04:44:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AEBC12BDE3;
        Fri,  7 May 2021 04:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vdN6WPtzDqc5
        qUpreL5RzJWvtaNXHj+mgKeDL1sJmXE=; b=m57st2Muwnnyb+btLnIhx564II+5
        nPJcuZH1AuqyzwWm0T9nV/JG7PRfqM1Ra2ntoJkOfMO1sVmb7zqye/cK1cfXhQ2p
        5NLiyIZO9DHs98JMRTFPcnt+gmliDWS80gDViAcuqMpiI69p5ZRj9mnSGhTA9Fym
        ybXpjJdXMjugFiM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9393912BDE1;
        Fri,  7 May 2021 04:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB70212BDDF;
        Fri,  7 May 2021 04:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
        <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
        <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
        <87y2csv0qm.fsf@evledraar.gmail.com> <xmqq7dkcz20u.fsf@gitster.g>
        <87sg30usm9.fsf@evledraar.gmail.com>
Date:   Fri, 07 May 2021 17:42:57 +0900
In-Reply-To: <87sg30usm9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 06 May 2021 11:04:34 +0200")
Message-ID: <xmqqwnsbue7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39C53092-AF10-11EB-ABB2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe the confusion is that I'm using "bug" closer to a meaning of "a
> thing nobody intended to be in the program", not just "a
> behavior-changing issue observable from the outside".

OK, thanks for explaining where my confusion came from.

