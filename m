Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC0C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129726127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFHFQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:16:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFHFQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:16:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 800F5DD9ED;
        Tue,  8 Jun 2021 01:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=4YmNiZOeUdHZMiurjSCkqt0MR
        rz/qWzm+mz+JSewJa8=; b=DL/McXL+3kISrEIvKVbKHdKZaHE2iVRB9agFz5s04
        TypNRX/0yP2EwSQn1heY751xgyySo1LlVVT396dk9m+JpeLv3JwtHgEHWcXRmsTr
        p/0NnAiFw+t2MAP98s7Mm5NhwwvAbH4TWRovB11RrJ19Q1LaeChjaFt7GNqGDqj4
        hU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AF1FDD9EC;
        Tue,  8 Jun 2021 01:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD96ADD9EB;
        Tue,  8 Jun 2021 01:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 try2 3/4] completion: bash: fix for multiple dash
 commands
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
        <20210606184726.1018460-4-felipe.contreras@gmail.com>
        <20210607190046.GB6312@szeder.dev>
        <60be6f7fa4435_db80d208f2@natae.notmuch>
Date:   Tue, 08 Jun 2021 14:15:05 +0900
Message-ID: <xmqq35ttq6na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7C84BAA8-C818-11EB-917F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> SZEDER G=C3=A1bor wrote:
>> On Sun, Jun 06, 2021 at 01:47:25PM -0500, Felipe Contreras wrote:
>> > Otherwise commands like 'for-each-ref' are not completed.
>>=20
>> I think you meant that options of commands like 'for-each-ref' are not
>> completed.
>> ...

> Yes, I meant commands like 'for-each-ref' are not completed correctly..=
.
> by __gitcomp_builtin. Which in practical tearms means what you just
> described above.

I couldn't exactly tell if that's a roundabout way to say "yes,
yours is better and I'll use it in an update, thanks".  I'll assume
that is the case and will mark the topic as expecting the final
update (as it seemed that all the other patches in the series were
received favourably).

Or was it meant as "no, the version you commented on was already
correct (if you squint your eyes)"?

Thanks.
