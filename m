Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B45FC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A6364DD3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhBWSQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:16:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhBWSQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:16:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D630947B8;
        Tue, 23 Feb 2021 13:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCRHhnc7bau6rn7TJJNkbUU8jDU=; b=aAGX0c
        A8/nHmCdTIfoDc4Sn9CI013XWMWQvBNg27FRdXW227aBfeClz3GcH3KWjC1DSuSH
        NeOL80CNWMU325r04UnYIUFOJhU7ZkNQ/Rcz8Wc4myGSpLfd2tBiQEUQIcpc5Xxm
        M82//ukszN3xYqBBmbPudXFbWqoRCWBGvtwIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hYHkUHSDh2o8Wrj2zuOu64SXKHrHTo8D
        W0KohLfJv8iLThYQ+1/5G/uccmwPc2rYpYyuYSmqmHXUAiSTiMnlS+LHgZk72Wq5
        x5xPkdgEy6twmRXojnYbZFuJ9Ry19XTHPJiSQ5w4I9kBMzmJyXKevjMufn/zEXFZ
        xSCDV6Kpjq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 145A9947B7;
        Tue, 23 Feb 2021 13:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88B27947B6;
        Tue, 23 Feb 2021 13:15:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH 0/3] add: minor --chmod fixes
References: <cover.1614037664.git.matheus.bernardino@usp.br>
        <YDU2lzxPqsOwjv9N@nand.local>
Date:   Tue, 23 Feb 2021 10:15:16 -0800
In-Reply-To: <YDU2lzxPqsOwjv9N@nand.local> (Taylor Blau's message of "Tue, 23
        Feb 2021 12:08:39 -0500")
Message-ID: <xmqq35xm4pmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1517334E-7603-11EB-8559-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Matheus,
>
> On Mon, Feb 22, 2021 at 10:10:32PM -0300, Matheus Tavares wrote:
>> The first patch was broken out from [1], to avoid holding it off while
>> there is still work to do on that series. The other two are minor
>> related changes.
>>
>> [1]: https://lore.kernel.org/git/cover.1613593946.git.matheus.bernardino@usp.br/
>
> All look quite reasonable to me, thanks.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Yeah, thanks, both.
