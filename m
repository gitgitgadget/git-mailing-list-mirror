Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192FC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiHHNrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiHHNrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:47:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BAF45
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:47:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99D6C1B480E;
        Mon,  8 Aug 2022 09:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0AP4JT+GXINFcNevylepzrOegaGM498zWEUAHD1AxUc=; b=f5wO
        hQscaWsUrZW4khLsGRJFCQYpn5ytV7xK3YxN94lpJMNdX/mVCgqv1plHsPn+Zdgp
        YE3PYiMd5vRX257rtX//mNDdkuJtXdHsp+uGSn1Gt8EYBQ0XeDRvYndK/UfNVA2A
        NZDfxIiEhzYH9Hoe6qXWWlY2ItkewTOstRxBLjI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92B341B480D;
        Mon,  8 Aug 2022 09:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C76C1B4809;
        Mon,  8 Aug 2022 09:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2022, #02; Fri, 5)
References: <xmqqa68ixcrf.fsf@gitster.g>
        <CAPig+cSz9RKj43_kwQFDQpN2Ggrimrw_DcOFnxGS+nBCPqDK5Q@mail.gmail.com>
Date:   Mon, 08 Aug 2022 06:46:57 -0700
Message-ID: <xmqqa68evodq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 930EB1AE-1720-11ED-952F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 5, 2022 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/doc-creation-factor-fix (2022-07-28) 2 commits
>>  - range-diff: clarify --creation-factor=<factor>
>>  - format-patch: clarify --creation-factor=<factor>
>>
>>  Expecting a reroll.
>>  source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
>
> Per [1] and [2], I think the intention was to drop these patches
> rather than moving forward with them.
>
> [1]: https://lore.kernel.org/git/CAPig+cQ94oC-6wftkP_=RSEsOVPKeuBWuMshDkwV+Xu_FjrKeg@mail.gmail.com/
> [2]: https://lore.kernel.org/git/xmqqa68nlfiz.fsf@gitster.g/

I think we are expecting a submission by Dscho to replace these two
patches.

