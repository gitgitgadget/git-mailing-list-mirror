Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA8C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiHEW0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiHEW0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 18:26:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF891CB3F
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 15:26:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22F6A1B7984;
        Fri,  5 Aug 2022 18:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0617llOZRtD2G5TMRCeC+ak6s0liwH9cgb4Lqo
        il+i8=; b=e2omfnB4qZ7RbnFs1AIjGpa5ztAJQ8RZW2JvMZoutQIIsR1lFr+MCI
        qIWSs2thwFcouxHqSVQdPcjRaxcNwJd2AAsoMzAjiO/Us65JvEGopM9SLRyWZ/Vh
        RNQ3TGpMJac9NHSEqqBtLUs+7VlR9PNFnLwfPrDrT5hMCxzOcXGOw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C1D81B7983;
        Fri,  5 Aug 2022 18:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 551381B7982;
        Fri,  5 Aug 2022 18:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
        <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
        <1b90edd0-3d9d-a741-8865-3968826da315@iee.email>
Date:   Fri, 05 Aug 2022 15:26:10 -0700
In-Reply-To: <1b90edd0-3d9d-a741-8865-3968826da315@iee.email> (Philip Oakley's
        message of "Sun, 10 Jul 2022 23:09:02 +0100")
Message-ID: <xmqq5yj6z5rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BF5213C-150D-11ED-AA8D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> How about this:
>>
>> This option implies `-u`. Lone CR characters are untouched. CRCRLF cleans to CRLF.
> That is probably sufficient. It drops the awkward 'idempotent'. And
> indicates this edge case, though doesn't highlight that the resultant
> CRLF still leaves the file only partially renormalised.
>
> I'll reword.

It's been a few weeks since the last activity on this topic.
Anything you guys need unblocked to move forward?

Thanks.

