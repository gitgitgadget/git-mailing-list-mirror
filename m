Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D01C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTUzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJTUzw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:55:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344592112BA
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:55:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F9C11509EE;
        Thu, 20 Oct 2022 16:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sw/tL51Cl77TBu8da1F7etC3Zt0zy81wDJjcHo
        1px78=; b=bBaQVovhC5MWyBBfQn5gb9P7ZQAsrEyRVI9Y9hO+s+VLuXArLxqkCW
        Bm+vLS4YwrCmaizN8rq9UyJwMciRE3QA1ZWLG9UihgvUaIspsiXo4VQH4UM351cD
        MvNk33gMkl9sEoeV0VvGD6IyFGuQdgUjwv+fQ9RALelP6kC+xnwyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85D681509ED;
        Thu, 20 Oct 2022 16:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4ED91509EC;
        Thu, 20 Oct 2022 16:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 7/8] trace2: add stopwatch timers
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <8e701109976777ad8fae1e0cd3908bb11a1fcf93.1666290489.git.gitgitgadget@gmail.com>
        <xmqq7d0us0o2.fsf@gitster.g>
        <b7860e10-b174-2fb2-53eb-568686a961c4@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 13:55:39 -0700
In-Reply-To: <b7860e10-b174-2fb2-53eb-568686a961c4@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 20 Oct 2022 16:52:51 -0400")
Message-ID: <xmqqy1taqkok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E934BD0-50B9-11ED-980B-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> um, it never occurred to me to make it a macro with an arg.

Heh, that was what you responded with "good point" 6 hours ago ;-)

https://lore.kernel.org/git/aeb07c4f-f3f2-4965-6b6b-3ba3b10b2103@jeffhostetler.com/

> i'll reroll tomorrow with the typo that AEvar found.

Thanks.  Looking forward to.
