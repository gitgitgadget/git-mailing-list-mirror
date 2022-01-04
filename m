Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4342C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiADUFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:05:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52633 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADUFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:05:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9713F175A09;
        Tue,  4 Jan 2022 15:05:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=glFKdgirHBpVe9VSPK8TqcAS7bzR6EkEAKu3iP
        qBcmg=; b=NbVBTZypkNc90N9brOX7W/H91a5OdHlG/qoFyaA9CckufQfodQiMYG
        4pidaEQ79+b8jeZbzXY8DX6Ym/BQIOoM6ZolZ7gVigl89EonCjYV54UgEOEQYxtt
        vM+NEdD4Jg8BSiXf0Mnvd9RPXFMbSNsWwEkI8tV/FreLMO+uDT3T4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FC97175A08;
        Tue,  4 Jan 2022 15:05:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 149A1175A06;
        Tue,  4 Jan 2022 15:05:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jl/subtree-check-parents-argument-passing-fix, was Re: What's
 cooking in git.git (Jan 2022, #01; Mon, 3)
References: <xmqqsfu4duxl.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201041322090.7076@tvgsbejvaqbjf.bet>
Date:   Tue, 04 Jan 2022 12:05:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201041322090.7076@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 4 Jan 2022 13:23:58 +0100
        (CET)")
Message-ID: <xmqqfsq3cllx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5500AF0-6D99-11EC-A72C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 3 Jan 2022, Junio C Hamano wrote:
>
>> * jl/subtree-check-parents-argument-passing-fix (2021-12-05) 1 commit
>>  - subtree: fix argument handling in check_parents
>>
>>  Fix performance-releated bug in "git subtree" (in contrib/).
>>
>>  Expecting a reroll.
>>  cf. <nycvar.QRO.7.76.6.2112072243310.90@tvgsbejvaqbjf.bet>
>>  source: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>
>
> James sent a v4 already four weeks ago, I just did not find time to look
> at it yet, before today. I offered my thumbs-up in the thread, and now I
> am offering it here, too: this patch is ready for prime time.

Thanks, I just saw your review on the latest one.
