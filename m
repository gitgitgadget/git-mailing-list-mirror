Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82746C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A5E610CF
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhHSTj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:39:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHSTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 15:39:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56AC9DFCFB;
        Thu, 19 Aug 2021 15:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rWRlq9q7m5WwLtpJq6XVLjUtZP5SNfmV0JoRFm
        XPioA=; b=dQ6ZIIqW0w7zK3fSR334jdRoWKX1H+2hzjNk0uWEXUtMpiLG6NKgce
        rEyZ0wo1bp/nyna+exggGgoP0Ho2gLRO9gUFvML1gxnRrA5XSuA0i+NN9BJ3Zbs2
        Yino5qC8yz26sTGHh1++ckuAV3aXpeucMbg2FaNEiYEtB3H1Th1Fk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EBBBDFCFA;
        Thu, 19 Aug 2021 15:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C917CDFCF9;
        Thu, 19 Aug 2021 15:38:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
References: <xmqqv945ng61.fsf@gitster.g>
        <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>
Date:   Thu, 19 Aug 2021 12:38:48 -0700
In-Reply-To: <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com> (Phillip Wood's
        message of "Thu, 19 Aug 2021 19:55:55 +0100")
Message-ID: <xmqq7dgh1ayf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13271100-0125-11EC-A850-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * pw/diff-color-moved-fix (2021-08-05) 13 commits
>> ...
>
> I found a couple of regressions in diff
> --color-moved=allow-indention-change with this series today. One of
> them is a simple fix, but I think I will need a bit of time to
> understand the other (there's a change to the way it handles lines
> consisting of '\f\n'). Would it be possible to kick this out of next
> when you rewind it please.

Will do.  Thanks for a heads-up.

