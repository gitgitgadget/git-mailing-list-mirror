Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7CC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiB0TPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0TPx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:15:53 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BB56C2A
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:15:16 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55DC8F8445;
        Sun, 27 Feb 2022 14:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5SfKe23YpsnuWYrkWEDIvJC6gR+lGL9sSTchg1
        UxPr0=; b=WjRyCLVA5FWCqTntVp7T+/De5tfRDtMKjERdnmwh2RKi1a+Hb0HxjP
        qqvKtjuFeRmvnbU+nB2mjieJRoPDxoLjYzJkAUFyiA2v9bsJTdEdELQXLztpQgFy
        odfHRRhAQE1JxwAexKVKM0U6cKXjI2G5JMio0ERdUDxGEYKRNcoBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49F62F8442;
        Sun, 27 Feb 2022 14:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2F28F8441;
        Sun, 27 Feb 2022 14:15:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Julia Lawall <julia.lawall@inria.fr>, git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <xmqqa6ee6txq.fsf@gitster.g>
        <20220226065704.7137-1-chakrabortyabhradeep79@gmail.com>
Date:   Sun, 27 Feb 2022 11:15:13 -0800
In-Reply-To: <20220226065704.7137-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Sat, 26 Feb 2022 12:27:04 +0530")
Message-ID: <xmqqtuck3yv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 979A4614-9801-11EC-93DC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Let's instead drop [2/2] for now.  I do not want us to go back to
>> shell script that pretends to know about C language, and I do not
>> want to block [1/2] by waiting for a replacement.  Fixes in [1/2]
>> are pretty much uncontroversial ones that can even be fast-tracked
>> down to 'master'.
>
> Though, as a new contributor, I felt bad about dropping the last
> patch, but if you think the last patch request needs more discussion
> ( which I think is needed) - I also in favour of dropping the last
> commit.
>
> Would you do this on your side or I will re-submit it with the first
> commit?

Nah, I can just discard the second commit and keep the first one.
