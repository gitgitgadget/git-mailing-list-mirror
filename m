Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C270C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjH1QWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjH1QWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 12:22:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9B136
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 09:22:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF76C1B7C8A;
        Mon, 28 Aug 2023 12:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZGoCXJIoP6Qr/vW0LbvzBy5rtMXR7HkUq2XTz9
        FUbXk=; b=MG85JD17A11oiV3j8w4QRSD4Yx3fRSQEE5GCgIQCc4FovNT6gz1T/3
        SzEXAnsFqmRSvMUU2dv+u6j+JGiYsRnYHvu2kDmXt7LDmd/kYu7vkqM34SSBsaya
        tlvDUPt69l4s57sWCcQLTv9mCtZdlFtKjcrpMY133E6/SrMMJzofY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B68861B7C89;
        Mon, 28 Aug 2023 12:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 200BA1B7C88;
        Mon, 28 Aug 2023 12:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] scalar: two downstream improvements
References: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
Date:   Mon, 28 Aug 2023 09:22:11 -0700
In-Reply-To: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 28 Aug 2023 13:52:23
        +0000")
Message-ID: <xmqq5y4zi1cc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B0C5F1C-45BF-11EE-A7C5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While updating git-for-windows/git and microsoft/git for the 2.42.0 release
> window, a few patches that we've been running in those forks for a while
> came to light as something that would be beneficial to the core Git project.
> Here are some that are focused on the 'scalar' command.
>
>  * Patch 1 adds a --no-src option to scalar clone to appease users who want
>    to use scalar but object to the creation of the src directory.
>  * Patches 2 and 3 help when scalar reconfigure -a fails. Patch 2 is a
>    possibly helpful change on its own for other uses in the future.
>
>
> Updates in V3
> =============
>
>  * Several commit message edits.
>  * An important case that was dropped in v2's patch 2 is reintroduced (even
>    though it is modified in patch 3).
>  * An error message is added for corrupt Git repositories.

Thanks.  The updated series look good.  Especially the updates to
the commit message all looked excellent.

Will queue.  Let's merge it down to 'next'.

