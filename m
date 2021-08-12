Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3244C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62A060EE2
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhHLEra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:47:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhHLEra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 00:47:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A7CFE7A09;
        Thu, 12 Aug 2021 00:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fNaNAwLXPuYk
        zVBauevThOZ1p+/rs8p4+vcT0BRcoUo=; b=Nkrif/vM6BaA7HQ/CcrAp3OfqWIw
        +02VL5aUCCk3DGQerDk0OFBrXF0NzWKqOFLrYHzVKgZS2OQLZLF7ggtF7AKcQshQ
        d9A/U1yjIb4e9+lk2nXk13HwInSQ9YXnaETyIWRhe5amASzGpSzaeELKkTuSpixf
        SS4HrmPI35kmmLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FC08E7A08;
        Thu, 12 Aug 2021 00:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8975DE7A07;
        Thu, 12 Aug 2021 00:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/6] config-based hooks restarted
References: <20210812004258.74318-1-emilyshaffer@google.com>
Date:   Wed, 11 Aug 2021 21:47:03 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:52 -0700")
Message-ID: <xmqqa6ln6zi0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 573D8DF4-FB28-11EB-BD02-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This is the config-based hooks topic rebased onto v4 of =C3=86var's
> branch[1].

I have [1] in my tree, but these patches do not seem to apply
cleanly; I see a failure in "git hooks list" step.

Should I perhaps try merging [1] to one of the v2.33-rc and then
queue these on top?
