Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GB_FAKE_RF_SHORT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49AFC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9371F61038
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhHQVtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:49:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56489 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHQVtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:49:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C67141483EB;
        Tue, 17 Aug 2021 17:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x275d+EX4DhWP7pXRS3z9qKjbxUNWkuZlwa8+A
        9wpxA=; b=q/pCMdmVFex5bSfrvWayWZ+SnyET4HJU+OTK00oU3qC1EfM7eNkwgF
        KwDmGWalye8GjTPyYnMNLbjT5Fy+Vlf6HfcfdftXSiCK9514QPepRAAk2OiFek9w
        rRU5Zu8bOyz6eTm8gDV+gipgViX3Wbj5yQAHPSMbliFMQwcJ88TyM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A41C51483EA;
        Tue, 17 Aug 2021 17:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CABAE1483E7;
        Tue, 17 Aug 2021 17:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
References: <xmqqv945ng61.fsf@gitster.g>
Date:   Tue, 17 Aug 2021 14:48:39 -0700
In-Reply-To: <xmqqv945ng61.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 Aug 2021 16:06:14 -0700")
Message-ID: <xmqqr1er7new.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2B967C4-FFA4-11EB-BA9B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Git 2.33 (final) has been tagged.  As it was a shorter cycle that
> lasted only for 10 weeks, we may see some regression post release,
> so let's see how it goes for a few days before starting the next
> round.

Those with eagle-eyes may have noticed that tinyurl.com/gitCal marks
this week as "2.33 fix-up week".

I'll give priority to reports of regression, and better yet, patches
that fixes them.  I'd appreciate others to do the same.

The next up in the priority order are patches that replace topics
that have been in 'next', but I expect it to be rare.

Thanks.
