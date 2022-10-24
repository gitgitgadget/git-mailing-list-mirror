Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8196BC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJYAkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJYAkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:40:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75AF72FD3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:08:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 594E81CC067;
        Mon, 24 Oct 2022 19:08:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VHdmmWE90jD9UH6c7xaUQiRUyPQBwma5MDvoy1
        uynpo=; b=k36AGDC063xsPnY6EWsOrYNuE1ecOzkHzv89wKByduFFeS92oTXSB3
        ykK4yt10kyxh3pcUnpjPwFLcotsipcduA8TR3AG4DvsWiIktBkrAJ0JE6tH5JlrY
        +9Px/0U1ueqZZGCuYQlBBhnOpIg2MeLvwthC0asCd7zO83A3C4/DA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5254F1CC066;
        Mon, 24 Oct 2022 19:08:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81DB11CC065;
        Mon, 24 Oct 2022 19:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v4] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
        <pull.1345.v4.git.1666649239302.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 16:08:47 -0700
In-Reply-To: <pull.1345.v4.git.1666649239302.gitgitgadget@gmail.com> (Julia
        Ramer via GitGitGadget's message of "Mon, 24 Oct 2022 22:07:19 +0000")
Message-ID: <xmqqa65krf9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D134A792-53F0-11ED-AC83-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Ramer <gitprplr@gmail.com>
>
> With the recent turnover on the git-security list, questions came up how
> things are usually run. Rather than answering questions individually,
> extend Git's existing documentation about security vulnerabilities to
> describe the git-security mailing list, how things are run on that list,
> and what to expect throughout the process from the time a security bug
> is reported all the way to the time when a fix is released.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Julia Ramer <gitprplr@gmail.com>
> ---
>     embargoed releases: also describe the git-security list and the process
>     
>     Changes since v3:
>     
>      * minor formatting corrections
>      * clarified the language based on v3 feedback

Thanks, this version I am happy with.
