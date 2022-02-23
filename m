Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D3BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiBWXOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiBWXOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:14:03 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF24969F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:13:34 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BE3910412E;
        Wed, 23 Feb 2022 18:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+56lV4/6Z0yEkxhq/b0rVMQKtA5NoSrTb/6jpc
        EoDGM=; b=blc9qSfG29HOtt4jgvZ/HUwTcfzuX6oT2VU+X+mkOiQZEVc91zBA76
        tTcS0w5aZCaIVGCJaTuOsBJ0aBNQbFXe/ufqn57UemhSo5pb11U1CDGaIL1RgLuu
        8aHD1esG6aoJQdiZXwAtcWOuu6SsJdlJ077OxB0ymwkJYpEiRcq5E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2176910412D;
        Wed, 23 Feb 2022 18:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 813EB104128;
        Wed, 23 Feb 2022 18:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v6 00/12] In-core git merge-tree ("Server side merges")
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 15:13:32 -0800
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 23 Feb 2022 07:46:41
        +0000")
Message-ID: <xmqqsfs9p46b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38B32C34-94FE-11EC-9E7A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> == Updates Log ==
>
> Stuff NOT included that reviewers brought up in various rounds (and which
> might still be an open question):

Except for them, the differences since the last round all looked
sensible to me.

Will queue.
