Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B9C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 06:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiGOGbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiGOGai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 02:30:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CD23BC2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 23:30:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDF2F1A50F4;
        Fri, 15 Jul 2022 02:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nd2Rab1SiTd6GvaqywHJBX9Cxri+NfM+gGcIO+
        PgKdk=; b=KH/kIYQDAU2EO2tjPlJJXGJPjWlEYXjdtcvtP3rBLjJJE6ak1lpDDe
        L5fZ4S3QppjFPecUtI2H3zC1qCvyjzYiAQJXzkyGtZd9okMEHLC6yATmb9LBiz5W
        LAAckFGU9reUyRqFG/AFtp9PJVuKsxbOoAPQTNmixZqO/ZoX/ijyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9C521A50F3;
        Fri, 15 Jul 2022 02:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2EA111A50F2;
        Fri, 15 Jul 2022 02:30:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] Remove use of "whitelist"
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 23:30:19 -0700
In-Reply-To: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 15 Jul 2022 02:38:39
        +0000")
Message-ID: <xmqq5yjy3n2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99EC32B6-0407-11ED-AB93-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The word "whitelist" has cultural implications that make its use
> non-inclusive.
>
> A previous version of this series recommended the replacement of
> "allowlist", but that term is still new and not accepted by some common
> dictionaries.
>
> Instead, this version avoids the use of "whitelist" by rewording the
> sentences that use it. In many cases, this improves readability since the
> term is used suddenly without other context (and in some cases, is not
> necessary at all).
>
> There is one case where "whitelist" is replaced with "allow_list" but that
> is because we are operating on a string list parsed from the
> GIT_ALLOW_PROTOCOL environment variable.
>
> Thanks, -Stolee

Maybe I am biased, but for all the changes in these patches, I find
the updated text far easier to understand than a mere replacing of
the words s/white/allow/, even if I pretend that allowlist is
considered by everybody a proper part of English vocabulary.  After
all, I think most of the places did not have to say "whitelist" in
the first place.

Will queue.

Thanks.
