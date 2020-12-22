Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A999C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5363E22AAF
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgLVVrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:47:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgLVVrf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 16:47:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C9FDA2822;
        Tue, 22 Dec 2020 16:46:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6QcjCwN7cfoNxIgmwS7uSDHv7Wc=; b=q+PfYM
        Cu0YwygZoyl6hWHQwfzY9bN2oCJhHEAF/7Yak5ieEa0KGu4H1d/XqgTYZJM3kc0Q
        QPcwRguuQhOW1TsOSL3h+rXx3CPWLyyKglWMN8fy2C/RyU8Xs9PV7xbac1oyEVrV
        EQcCpDhW4Yra4WPvF/F2vkWsuLY0plVaDt0G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Aso7XfYsTrIDuFBgqE0tG4gNc+9LAfx3
        jlwh22ta7MWRVWlH7NafcIVl+AqF9mn92DVXyL6yrTq+8ZhggJPWSeDM1PPZ35My
        WFAdCkildGg6WA2i5RW4xq91ckz+D5jy4D63+UdTGMpLm9x72X/JmkhiWaLzWAwl
        z/2AT3eGqeg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11587A2821;
        Tue, 22 Dec 2020 16:46:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93A79A281F;
        Tue, 22 Dec 2020 16:46:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #04; Tue, 22)
References: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
        <CAPig+cT7q76NMubK3N2R-OmRUnH6HVWOt7eKRNCVjtv_qWK97g@mail.gmail.com>
Date:   Tue, 22 Dec 2020 13:46:52 -0800
In-Reply-To: <CAPig+cT7q76NMubK3N2R-OmRUnH6HVWOt7eKRNCVjtv_qWK97g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 22 Dec 2020 15:25:35 -0500")
Message-ID: <xmqq1rfhh5tf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 347FF008-449F-11EB-B515-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> By the way, an unrelated patch[1] I sent a day before sending the
> es/worktree-repair-both-moved topic doesn't seem to have made it into
> 'seen', so I'm wondering if it was overlooked (or perhaps it just
> hasn't been processed yet).
>
> [1]: https://lore.kernel.org/git/20201220212740.44273-1-sunshine@sunshineco.com/

It was not material suitable for -rc period, so I simply ignored it
while skimming the list ;-)

Will pick it up.

Thanks.
