Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287BC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGAVsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiGAVsv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:48:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA14D174
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:48:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D800213DFE4;
        Fri,  1 Jul 2022 17:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EBNjf62SsbiWKHgrPkCb5fukif3VxPjhtwWXhs
        ZjF30=; b=Whfd34StW6MxJAlx1sqvHXrNI0yyAiW4yrlHMfgrBMfbqwx3cPjMZ1
        3u9BZW1yHxCgZzPzhekElmhRU86q+KJAKTROEpmcmiYyVbttDGOsICevn+fylUkk
        R7lEgYkd0HrruuY/8ErnI+2mRKGBuTBw3wYdwgvW+VhR4zl1vZr1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEE6413DFE3;
        Fri,  1 Jul 2022 17:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CC7E13DFE1;
        Fri,  1 Jul 2022 17:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: support building on RHEL6
References: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
        <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net>
        <xmqqpmio7c3m.fsf@gitster.g>
Date:   Fri, 01 Jul 2022 14:48:47 -0700
In-Reply-To: <xmqqpmio7c3m.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        01 Jul 2022 14:32:45 -0700")
Message-ID: <xmqq7d4w7bcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 968BF582-F987-11EC-A709-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But I do not think the patch text, what the patch does, is that bad.
> We advertise in INSTALL that you need 7.19.4 to build without NO_CURL;

> IOW, you should be able to build Git with 7.21.3 or later.

That conclusion is nonsense.  "with a version before 7.21.3 as long
as it is newer than 7.19.4" is what I should have said.

