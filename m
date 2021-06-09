Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5130C47082
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AB61352
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhFIAUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:20:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51649 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFIAUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:20:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E72A1D0F41;
        Tue,  8 Jun 2021 20:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gY3TKf/m7mL0RKs3F7mumZ3yXiRhH7dEs+7fSo
        1cbH4=; b=aD6qL+s7tmhBxoe5ZN4LXRAicCqO2Q+5Qk6pRFd3Yr53pDwrU0Qr3G
        oBRxOWPnLex+ZZnmzIr6xEo23Luh1sTNK5H1x7hyMAN1ua15g76AdGHxWyHsXpAB
        dqoHAHR2B2iPd1zkNduVpwjlqFy0eBwsvgku9b6vkuI9i3ESiVUdM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE526D0F3F;
        Tue,  8 Jun 2021 20:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6211AD0F3D;
        Tue,  8 Jun 2021 20:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/4] First steps towards partial clone submodules
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
        <xmqq4ke7ordl.fsf@gitster.g>
        <CABPp-BF97Ej+WrgSrumz9DZpeg_wgKVhvPatiHn4GvSyraymag@mail.gmail.com>
Date:   Wed, 09 Jun 2021 09:18:05 +0900
In-Reply-To: <CABPp-BF97Ej+WrgSrumz9DZpeg_wgKVhvPatiHn4GvSyraymag@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Jun 2021 17:07:10 -0700")
Message-ID: <xmqqlf7jnb5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29B47962-C8B8-11EB-9A1E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> My series is completely independent of the partialclone extension stuff.

OK, that makes it simpler.
