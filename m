Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1224C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F4C610A5
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 19:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhHRT6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 15:58:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58840 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhHRT5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7168D77A8;
        Wed, 18 Aug 2021 15:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6nvQc0B8Y8t1aNnGsVKezadPimnBr7cDOeaBgZ
        CJA/c=; b=PQKXTVhJB0t2BXcZeqvxMHkggELi5LaCyEblnu4oVJcZNpZeCU/r31
        92qqrULft3RreJEARqvZaEAGaEsohjOadLs/gtHTxkeAbPQiXu7YHEnyrJwFWUBg
        hF+MnPGGeEEpq/ghTggTobRctrxU7Bu6oakK6xJvAgXSvkbiN+kuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1FB0D77A7;
        Wed, 18 Aug 2021 15:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BDDDD77A4;
        Wed, 18 Aug 2021 15:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mahi Kolla <mkolla2@illinois.edu>
Subject: Re: [PATCH v6] clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
        <xmqqy293ucju.fsf@gitster.g> <YRw/8tThN7djNE+E@google.com>
Date:   Wed, 18 Aug 2021 12:57:15 -0700
In-Reply-To: <YRw/8tThN7djNE+E@google.com> (Emily Shaffer's message of "Tue,
        17 Aug 2021 16:02:10 -0700")
Message-ID: <xmqqk0ki5xwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CD1054C-005E-11EC-A640-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I like the changes you propose here. It also looks to me like you wanted
> to wait for Mahi to send the updates herself, which I appreciate.
>
> Mahi's internship ended last week and I believe she told me she's
> planning to be very busy this week; so if we don't hear from her by this
> time next week, I'll send a reroll with these changes (unless you want
> to just take them yourself without the list churn).

I'd make a "fixup!" out of the message you are responding to, and
then queue it on top of what was posted by Mahi.

Then I'll send the fixup to the list as a reply to this message, so
that later you and Mahi can ack (or further update) it.

After that, I can squash the fixup into the patch and merge it down
(unless there are objections from other places, that is).

Thanks.
