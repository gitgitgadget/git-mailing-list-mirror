Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A3C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiD0V7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiD0V7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:59:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236E1174
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:56:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D285135E4F;
        Wed, 27 Apr 2022 17:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YDBG6FL/A/ypCPkiOVyZdu35W51MXIbwLtzLtw
        +O9O8=; b=ewKW9h2rffym8si25p4VbIdrd7krkQEbRkO9bcicnbj8VJxYdFsQKI
        aBsGo5GDJULjCcOyLf3Ilh4gN4QQEZbRAVY5bvly420g/YROO0UgXznt4Rr2jEoa
        ew8N/R8J/eQTvKrru+xRPxwMH90XJ+5tvBKirLC0mua0sbLnZS4qQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9422D135E4E;
        Wed, 27 Apr 2022 17:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA098135E4C;
        Wed, 27 Apr 2022 17:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] MyFirstContribution: drop PR description for GGG
 single-patch contributions
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <2f6ecbf260135efc2a7ad09564cf6c64ed6d6f0d.1651086288.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 14:56:21 -0700
In-Reply-To: <2f6ecbf260135efc2a7ad09564cf6c64ed6d6f0d.1651086288.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 27 Apr 2022
        19:04:48 +0000")
Message-ID: <xmqqmtg6jim2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0AFF820-C674-11EC-A8B3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +NOTE: For single-patch contributions, your commit message should already be
> +meaningful and explain at a high level the purpose (what is happening and why)
> +of your patch, so you usually do not need any additional context. In that case,
> +remove the PR description that GitHub automatically generates from your commit
> +message (your PR description should be empty). If you do need to supply even
> +more context, you can do so in that space and it will be appended to the email
> +that GitGitGadget will send, separately from your commit message.

"separately from your commit message" wants to be clarified.  It
sounds as if GGG will send a separate message.

I am _guessing_ that you meant something like "the body of your
proposed log message ends with your sign-off and followed by a line
with three-dashes on it.  After that three-dash line, and before the
diffstat and the patch, is an appropriate place to write additional
information that are meant to help reviewers during review but will
become irrelevant after the review is done.  Your PR description
will appear there for a single patch contribution".

If we do not explain the space after the three-dash line elsewhere,
perhaps we should do so separately, like we talk about cover
letters.

Thanks.
