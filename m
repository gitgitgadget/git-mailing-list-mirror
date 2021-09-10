Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B73C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553FC61153
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhIJIyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:54:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55034 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhIJIyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 04:54:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B33FF145087;
        Fri, 10 Sep 2021 04:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QCXJe//PlGkLkOFVJHQjtgjYQxV5258LJ3GcNT0lH0g=; b=wZWT
        ItW9aTMMo9kaOkGQWUV0lmtRbuZeLLoaAw+tZqENpTaqDuIbgyLD2KOWAEIwdABm
        zd6QmalTQAcACLLrNdyMegcep4NM2lE0kr00KZzKS7jC/Sj4UC5Gryr48ayw8wFD
        vEhB15GN8Fu6DfZwH39yRdGqSRaDSPC5vpGfnmQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED09145086;
        Fri, 10 Sep 2021 04:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 590F1145085;
        Fri, 10 Sep 2021 04:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Sep 2021, #02;
 Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109091259310.59@tvgsbejvaqbjf.bet>
Date:   Fri, 10 Sep 2021 01:52:50 -0700
Message-ID: <xmqqczpgvml9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B97138E-1214-11EC-8AE8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 8 Sep 2021, Junio C Hamano wrote:
>
>> * js/scalar (2021-09-03) 15 commits
>>  ...
>>
>>  Add pieces from "scalar" to contrib/.
>
> Thank you for picking it up. It seems as if the reviews are starting to
> decrease to a point where I could imagine that we can start talking about
> how to refactor things to start bringing the benefits to Git proper.

For now I've given all what I thought about the patches I looked at,
and I think a handful other folks made comments on them.  I am not
keeping track of which comments have not yet been addressed, but it
seems that we hopefully do not need more than a couple more rounds.
