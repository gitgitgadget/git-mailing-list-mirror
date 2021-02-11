Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C90C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F106186A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhBKVpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 16:45:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53164 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhBKVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 16:45:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1462FAC83E;
        Thu, 11 Feb 2021 16:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLVNB3+Kbu1y0DJfVEDcix1ahu8=; b=Bk2PaF
        IxL95Lgv3BgoC/5IDc3BYWZbvDvTVHU2mDgMFBgPf7MUqyesHrB0yK8zVxyj7GRh
        K8qrpCZ4V/cLAGrT7hx5BR8/L85dxXbVBmhqTyDt4YZb/+JnTPf0wNh88t4pKWtS
        0hREJTe86t4m+Jc0o98oBxq2ctVkBZo/IuP+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l9+YM2sdCQtaVkhOJX02wmUEwO8ql28M
        cjReKLKMwLqn52UN2UUI10F2C+q5qN+gw4VCDhDqinvBNs/xa8ha8IscHWScQHLM
        phppRRmcRXxdevNp5NNId/jOhE9bUYWjiXhRLpQ/x8X98yuZkzN1/s67ehL/bdbO
        sz20EnMPWaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BDCFAC83D;
        Thu, 11 Feb 2021 16:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8725BAC83C;
        Thu, 11 Feb 2021 16:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/10] Modernizing the t7001 test script
References: <20210211194704.28913-1-shubhunic@gmail.com>
Date:   Thu, 11 Feb 2021 13:44:29 -0800
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com> (Shubham Verma's
        message of "Fri, 12 Feb 2021 01:16:54 +0530")
Message-ID: <xmqqk0rewa82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 524D2FFC-6CB2-11EB-9C5D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shubham Verma <shubhunic@gmail.com> writes:

> In this patch series modernize the t7001 test script by changing the
> style of its tests from an old one to the modern one and by cleaning
> up the test script.
>
> Changes since v2:
>
> - Correct the author name spelling
>
> Thanks everyone for your feedback and suggestions.

I've compared between v2 and v3 and verified the only change is the
name spelling, so I'll port over Eric's reviewed-by's from the
previous round.

Thanks.



