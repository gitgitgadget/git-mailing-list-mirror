Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C1C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350182AbiHSSJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350132AbiHSSIp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:08:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305BEC4F3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:57:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 124811397BE;
        Fri, 19 Aug 2022 13:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NuKUg0w5YRTkEVX2mCv6FfMy5mYx3evf0Ps+bT
        LssTc=; b=CoYMnXfwGs9FClHEMvMDul1UCGK5KiHi7sH8dqBy0ISr0jZWi7gI7S
        fpDdCDncXaykGQhKdH3m91f2iTJ1UrNqM9EffptA+vxqPgIUuYLQeblmzbtjOVfa
        Q+rR0D0xUvtIoT3d0jqM7E+s/Qg70A6CD2ruK30sgJ2A4QxOqxOic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0712A1397BC;
        Fri, 19 Aug 2022 13:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68DC31397B9;
        Fri, 19 Aug 2022 13:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v3] git-prompt: show presence of unresolved conflicts at
 command prompt
References: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
        <pull.1302.v3.git.1660695492382.gitgitgadget@gmail.com>
        <ps2p6366-7r7o-944q-o7s7-4rqp846721o9@tzk.qr>
Date:   Fri, 19 Aug 2022 10:57:27 -0700
In-Reply-To: <ps2p6366-7r7o-944q-o7s7-4rqp846721o9@tzk.qr> (Johannes
        Schindelin's message of "Fri, 19 Aug 2022 13:29:02 +0200 (CEST)")
Message-ID: <xmqq35dsm7zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63BBDAAA-1FE8-11ED-B1F9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Justin,
>
> On Wed, 17 Aug 2022, Justin Donnelly via GitGitGadget wrote:
> ...
>>     Changes since v2:
>>
>>      * There is now a single new test focused explicitly on this feature
>>        instead of making copies of existing tests and modifying them.
>>
>>     Changes since v1:
>>
>>      * This feature is now disabled by default.
>>      * Created new tests for conflict state (instead of modifying existing
>>        tests).
>
> This iteration looks good to me.

Thanks, both.  Will queue.
