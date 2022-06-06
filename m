Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F33C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiFFQej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiFFQei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 12:34:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB756301
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:34:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40BE219E420;
        Mon,  6 Jun 2022 12:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oWcQ16n57zfCW0cGymNekhFXlKcYqTvffvEQp+
        9QMvo=; b=UCHz3kRKJKs5/vXzDVroeyzMXEiZwuOmlq6QKoRvC6a0Ct501L8TrF
        xfIs8lQhS5zjksxsrDAraRh4tBwc7IRgzAeL2qzLXWQSFpxMX1UuM7oePjg/5FXd
        L0+nyE82sZFIKb92W1aZq9WYgtSOM/9ZOFmrn3VIV9kcnaXvlxBGQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3970119E41F;
        Mon,  6 Jun 2022 12:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4E5E19E41D;
        Mon,  6 Jun 2022 12:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5] remote: create fetch.credentialsInUrl config
References: <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com>
        <pull.1237.v5.git.1654526176695.gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 09:34:32 -0700
In-Reply-To: <pull.1237.v5.git.1654526176695.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 06 Jun 2022 14:36:16
        +0000")
Message-ID: <xmqqv8tdagyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C04FF1C-E5B6-11EC-A46C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      * Noticed that the redacted strbuf wasn't reset between loop
>        iterations, which only matters if there are multiple URLs for the
>        remote.

Thanks, I missed that.

Will queue.
