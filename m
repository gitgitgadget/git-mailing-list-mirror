Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F0C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbiC1RkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiC1RkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 13:40:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CCC193EA
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:38:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E27C5190DA7;
        Mon, 28 Mar 2022 13:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eK1vkC306IuR9rbzZmlZ9d4UiomuQdLacSvdha
        1C18U=; b=emYYiS7DM73lcDVDsVy9PZXPgOm5qiIBRl41AOVH29ICu8coN8aIqL
        Xbmgj+JUZLjGBbZ3V+hadg/hRtTy8t3bxS8DwFEccBN3Mrx+XVv2xh+8oqSfNaGl
        jl9hbtPKCiupD0w2QsQ1BZguecyDa+1/6Qx39uWkwx74CQ/rvNeJ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA89E190DA6;
        Mon, 28 Mar 2022 13:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4AA39190DA3;
        Mon, 28 Mar 2022 13:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 7/7] docs: mention --refetch fetch option
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
        <da1e6de7a9f87c4d5a1970fba17380c3ea7b76ca.1648476132.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 10:38:21 -0700
In-Reply-To: <da1e6de7a9f87c4d5a1970fba17380c3ea7b76ca.1648476132.git.gitgitgadget@gmail.com>
        (Robert Coup via GitGitGadget's message of "Mon, 28 Mar 2022 14:02:11
        +0000")
Message-ID: <xmqqee2m2d0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD1AC93E-AEBD-11EC-87E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  remote.<name>.partialclonefilter::
> -	The filter that will be applied when fetching from this
> -	promisor remote.
> +	The filter that will be applied when fetching from this	promisor remote.
> +	Changing or clearing this value will only affect fetches for new commits.
> +	To fetch associated objects for commits already present in the local object
> +	database, use the `--refetch` option of linkgit:git-fetch[1].

Good advice to add.

Will replace.  I think we've seen this topic enough times and it
looked reasonably well done.  Let's mark it for 'next' unless we
hear objections soonish.
