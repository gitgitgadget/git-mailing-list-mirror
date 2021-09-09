Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70400C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47622610E9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbhIITxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:53:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51850 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIITxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:53:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 783C2155C42;
        Thu,  9 Sep 2021 15:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+JzUwYvOMCXN31t5UiK+9DJkvHoRSGDTv1EPT
        HQiFI=; b=WwIK5FUFwuZSX+rN3pxwjU9sgibLpbzxEN+LCShXatseqfPHc49Wyx
        WftA20s95V+0o+taEQRNYa6IsWE42yCQgHuVz6hBcJwj2mZbrqd74KvcESMv1Uuh
        jgF3sCT4UwxTLsU7dB6wnWrLapYjmq7W7eR9El5+HOHKrH5FzOrqc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70F59155C41;
        Thu,  9 Sep 2021 15:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBBDC155C40;
        Thu,  9 Sep 2021 15:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] packfile: avoid .idx rename races
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <874kauf9wq.fsf@evledraar.gmail.com> <YToc+W7q1F8IXYK+@nand.local>
Date:   Thu, 09 Sep 2021 12:52:30 -0700
In-Reply-To: <YToc+W7q1F8IXYK+@nand.local> (Taylor Blau's message of "Thu, 9
        Sep 2021 10:40:57 -0400")
Message-ID: <xmqqmtoly1a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7857287A-11A7-11EC-9ACC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The duplicate s-o-b's are intentional, but see my response in 2/9 (I'd
> link to it, but vger seems to be a little sluggish for me this morning)

Looks good to me.  Thanks.
