Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B3C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbiCITkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiCITkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:40:19 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D15FB5
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:39:19 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDDC710C2B1;
        Wed,  9 Mar 2022 14:39:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Cq//wYVL7t9RDXZ64Xed+ToL6Qe3yG5GS+XjV
        wi+mE=; b=OKqq8kNBx2YGuUpxkclBOTQxvWwFd2GALL5joA9tI8LJ6374fxYlXu
        sucPg4paH46TiaurjUWOYhptu5RwRFze2LRU4nkGyxo4N8R8tDaQTtmXCSMkDXw+
        al7sdMOmeXlLFuJw0rGvuB0nkZdU8lrYNnbc3pXf5l9KFy+ty/O4Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3B8C10C2AF;
        Wed,  9 Mar 2022 14:39:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52A3710C2AE;
        Wed,  9 Mar 2022 14:39:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
        <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2203091404470.357@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Mar 2022 11:39:17 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203091404470.357@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 9 Mar 2022 14:20:23 +0100 (CET)")
Message-ID: <xmqq35jqlxui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C30F4CA-9FE0-11EC-A733-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not have hard data, either, except for one: apart from you and Junio,
> I have yet to talk to any contributor who said "oh yeah, I found the logs
> right away" rather than things like "when I finally figured out that the
> logs were in `print-test-failures`, I had a chance to make sense of the
> failures" or even "zOMG _that_ is where the logs are?". And let me tell
> you that I heard this from a lot of people. Way more than a mere two.
> Far, far more.

Stop counting me there.  I didn't find the logs right away, and I
already said that it is a good idea to eliminate the need to open
the thing other than the one that opens by default.
