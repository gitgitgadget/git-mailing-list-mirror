Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA625C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4BB611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhIJTuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:50:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhIJTuV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 15:50:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA341E76FD;
        Fri, 10 Sep 2021 15:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H6jXvUYcK1FhqtNwCBbnExX3YOB1DtPGTbJr9y
        4SbjI=; b=t7A8pBLVSFvV9Cwx5zDPAywD3u2eKprjBZs3QIr3vR9RZXvo8Gewvq
        1F2BHz87ZXLqmGn4T8L36Ecdso81ELQggE68pAzOD/gSmGttn/vNUCB/4ZQWnxok
        5rrrmXvascZmAkDLa42s41SDn0eLT9kJaaoER0ByVvJXa2iZX2afI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1F67E76FC;
        Fri, 10 Sep 2021 15:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36E97E76FB;
        Fri, 10 Sep 2021 15:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
        <xmqqbl50tkte.fsf@gitster.g> <xmqq7dfotjy3.fsf@gitster.g>
        <20210910190507.k6gxpsdnwtqyog5c@meerkat.local>
Date:   Fri, 10 Sep 2021 12:49:07 -0700
In-Reply-To: <20210910190507.k6gxpsdnwtqyog5c@meerkat.local> (Konstantin
        Ryabitsev's message of "Fri, 10 Sep 2021 15:05:07 -0400")
Message-ID: <xmqqo890rz2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A08C79A-1270-11EC-BE5E-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> The only solution I can offer is doing "b4 mbox" first, then deleting
> everything you don't want, and then doing "b4 am -m that.mbox".

Thanks.  Marking the articles I want in GNUS (I read via
nntp://lore) and downloading works just fine ;-)
