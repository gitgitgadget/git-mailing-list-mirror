Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C16C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356150AbiALSN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:13:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55581 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356119AbiALSNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:13:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F01D2FD70A;
        Wed, 12 Jan 2022 13:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kp//QRH6akQQNF979b/ftNZIQmHXrLGvFKl6Fb
        3n1dE=; b=k6zE+n/dulvw2K/p1S1RHGizIcMJ0qEDHLPg79HB978Jyq0qhQjrUc
        x09dKLNcf0tMk1OOcC9W4g5xb5YZEccLYB/ncxffX5xtB/6teSfKwW3qBw0+bopA
        30IvPjLHpT0fTKqm1p3Sp40RoC9MqqGHNCggOUG9k2uBOFLLYLmcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1543FD709;
        Wed, 12 Jan 2022 13:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DFFBFD708;
        Wed, 12 Jan 2022 13:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, reiter.christoph@gmail.com,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH] lazyload: use correct calling conventions
References: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com>
        <xmqqh7abxmxs.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201111412300.1081@tvgsbejvaqbjf.bet>
Date:   Wed, 12 Jan 2022 10:13:25 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201111412300.1081@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 11 Jan 2022 14:17:39 +0100
        (CET)")
Message-ID: <xmqqbl0gx1oa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 562D5F88-73D3-11EC-9350-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 10 Jan 2022, Junio C Hamano wrote:
>
>> Dscho, how does this look?  My choices are
>>
>>  - Waiting for review.
>>  - Will merge to 'next'.
>>  - Will merge to 'next' and then to 'master'.
>
> My preference is the last option, merge it down quickly.

Good.  Will do.  Thanks.
