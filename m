Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7AC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0826100A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 21:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCaVPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:15:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCaVOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 17:14:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD7ACB8E7E;
        Wed, 31 Mar 2021 17:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsIM2ph6ELKzqDuEwO1/Ywn2GSQ=; b=rGp0fR
        HyLtyey1MIKTJkIpydIP18osEK/JKtOMjUbR5Z47uBCuAnKGLKHCPy7J69bp3e58
        Ps3WCFmWiGo7Fm5Yp4W6RsFz+WFAhto5oRH/jmvoZ7N1srQCTOSW5BNlAZUKYHDZ
        wvOqz1/rR5XfarQpRmgd8/Eig4HWvwUo/10Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s55tBqdNd9wfBLrTKpKt0ezektQzHWT1
        3sLiJ27li7D2WkcQb0byBaM5nHYQa/VpdZV5tbX2dNvBCCQZViicOwbKeQLaUlbk
        0rjYtEyWaoUujezP0WkcSMCXyikba3cct3Amg34xTZNowiQntr0ccs0ZwNVeJFRV
        e85g9Xw62l4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3FF9B8E7D;
        Wed, 31 Mar 2021 17:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D0B2B8E7C;
        Wed, 31 Mar 2021 17:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v6] gitweb: redacted e-mail addresses feature.
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
        <xmqq5z19k9wu.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 14:14:51 -0700
In-Reply-To: <xmqq5z19k9wu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Mar 2021 13:00:17 -0700")
Message-ID: <xmqqa6qj6n5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22377442-9266-11EB-89BA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Will queue as-is.  Input from those who are more adept at Perl
> and/or interested in helping polish gitweb are still welcome, but at
> my level of interest on the topic, this version looks as good as it
> gets ;-)

Oh by the way, as nobody commented on the title, I'd have to X-<.

I'll retitle it to

	gitweb: add "e-mail privacy" feature to redact e-mail addresses

while queuing.

Thanks.
