Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72679C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB2261057
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhICEkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 00:40:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65324 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhICEkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 00:40:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D01E215B518;
        Fri,  3 Sep 2021 00:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SGYp6JmBZeOK2dHPbd2tOQWBZln1L8aMysGmN8
        0jbxI=; b=vVmzS9JjbU6M7rV9HIFwFnltwHusG6Z1NftLxIoU2nG1ja90bbBIE4
        s48/jCWFFzVpHT2rg249DFLmA7F+Es+aOm0OHiLyHuQ3C8U3D0ZxXJzwCcQo8e2Y
        6hsfpC6r/zN6VE3Q7JRLvjODvU03ZAw4TMWnJ/4fkGXmgVSumY0g8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9B9E15B516;
        Fri,  3 Sep 2021 00:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1EAED15B512;
        Fri,  3 Sep 2021 00:39:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g> <YTGHjGAm1I8GuUy/@nand.local>
Date:   Thu, 02 Sep 2021 21:38:58 -0700
In-Reply-To: <YTGHjGAm1I8GuUy/@nand.local> (Taylor Blau's message of "Thu, 2
        Sep 2021 22:25:16 -0400")
Message-ID: <xmqqfsumgtnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB93C7F4-0C70-11EC-8D63-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Sep 02, 2021 at 03:48:42PM -0700, Junio C Hamano wrote:
>> * tb/multi-pack-bitmaps (2021-09-01) 27 commits
>> [...]
>>
>>  Will merge to 'next'?
>
> I think so. Your integration looks good to me, since you replaced the
> original patch 11 with the replacement that uses find_odb().
>
> Peff gave v5 (with the replacement patch) a positive review in:
>
>     https://lore.kernel.org/git/YTCdHHRW%2Fi3HVN0h@coredump.intra.peff.net/
>
> so I think that this is ready.

Thanks for double-checking.
