Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49215C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGSPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJGSPm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:15:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18A39110
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:15:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 546A91A5572;
        Fri,  7 Oct 2022 14:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=heOEbaQzJuba
        7MEDkKY6Y5EVOXg45xaOmGDcxsTyb+8=; b=t/ted2CwcynE4nJwWEQIXsZKoZ4U
        izd9ptkt5MbQhL8lzOZ243CibOda9+m+a8l4HzSDDc+CA5x+zW+LTSSi+d1q2o4e
        38WOGER2CJjezEzQAfT/LVKXpo3B7Pjq1bUJBH4fJITIdxDDT83jDDdc1xzyZKEZ
        FmzeA5frhygkA+c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D1261A5571;
        Fri,  7 Oct 2022 14:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A90F1A5570;
        Fri,  7 Oct 2022 14:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] CodingGuidelines: various C99 updates
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <xmqqk05bfrk7.fsf@gitster.g>
Date:   Fri, 07 Oct 2022 11:15:35 -0700
In-Reply-To: <xmqqk05bfrk7.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        07 Oct 2022 10:54:00 -0700")
Message-ID: <xmqqwn9bebzs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A657236-466C-11ED-8428-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This series:
>>
>>  * Rephrases CodingGuidelines so that we note we're on C99, and then
>>    lists exceptions and features we use. The previous prose assumed
>>    C89 by default.
>>
>>    We still explicitly avoid opening the "feel free to use an C99
>>    feature" floodgates.
>
> The above contradicts with each other.  A sensible position to
> support the "we do not open the floodgate" is that when in doubt
> stick to C89 but use C99 features that are explicitly allowed.

Ah, I think I misread the intention, which 1/5 clarified.  I think
"even though we require your CC claim to support C99, you are
expected to stick to C89 plus those features that are explicitly
allowed" is a very sensible thing to day.
