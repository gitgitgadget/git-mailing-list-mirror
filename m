Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31AC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783B260FEB
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEYAf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 20:35:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58357 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAfz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 20:35:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0C14CB2A3;
        Mon, 24 May 2021 20:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D1LEpzCRmiuw8h/+fc8kr6OhGMpgKA843zdoBa
        EkFT8=; b=TqqKXqA+7p7eZ9klkhpnNcEoHbD5oxl+he2taKpcbiHKrvBVrzm0hG
        Gm9xKQoMRd11LRfGMiyLEmrQcHp1WVV/msSRo5CAOMiudb312FX4JvKz3Xde+0Aa
        N/vKYVsO9hFACaaxE55hIZdCx+4NVCj7OS32r/HpdJyRB4GIRJ+3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99661CB2A1;
        Mon, 24 May 2021 20:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25B14CB2A0;
        Mon, 24 May 2021 20:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, dyroneteng@gmail.com
Subject: Re: packfile-uri.txt: fix blobPackfileUri description
References: <xmqq8s4c6fbg.fsf@gitster.g>
        <20210524154354.268200-1-jonathantanmy@google.com>
Date:   Tue, 25 May 2021 09:34:25 +0900
In-Reply-To: <20210524154354.268200-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 24 May 2021 08:43:54 -0700")
Message-ID: <xmqqsg2birce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F57CB1E6-BCF0-11EB-BF5C-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Teng Long <dyroneteng@gmail.com> writes:
>> >
>> >> Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
>> >> and the correct format also can be seen in t5702.
>> >>
>> >> Signed-off-by: Teng Long <dyroneteng@gmail.com>
>> >> ---
>> >>  Documentation/technical/packfile-uri.txt | 15 ++++++++-------
>> >>  1 file changed, 8 insertions(+), 7 deletions(-)
>> >
>> > Will queue; thanks.
>> >
>> > Jonathan, how does this look?
>> 
>> Ping?
>
> Sorry, I just got back on vacation. This looks good - it's exactly the
> same as the change I approved previously [1].

Thanks.

>
> Teng Long, for future reviews, the review would go faster if you
> mentioned the changes in between versions (e.g. in this case, you
> updated the commit message following my suggestions).
>
> [1] https://lore.kernel.org/git/20210506164728.336409-1-jonathantanmy@google.com/
