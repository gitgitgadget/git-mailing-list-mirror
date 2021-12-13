Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFDCC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhLMS2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:28:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhLMS2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 13:28:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C00A015CBEE;
        Mon, 13 Dec 2021 13:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=a5gx1qOg8fb4X5wVHnG/ZLEA9vo6M5gbL6PIay0a4Rg=; b=l4T2
        lb4TttZjDyZJWl6DgQN7+NJC/gZcaiJHBwOLNExWt2qtdbrN14G/Dj509ncul+o6
        0/UYkYd4yhg7r3Boe7kFMLmF22y8qeUtajv1MBJ96f/6vqklPAip4hw7so38i3Ud
        FQkYSx6ZDXJh2v8ITGleZKf19Y+HayivzCLcIIY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F0B515CBED;
        Mon, 13 Dec 2021 13:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5AC2715CBEC;
        Mon, 13 Dec 2021 13:28:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
References: <xmqqilvvluoa.fsf@gitster.g>
        <CABPp-BEpcmxyRVzC4afRTCdV1W=RQxfzUPESbR_pFGmvTXqTtg@mail.gmail.com>
Date:   Mon, 13 Dec 2021 10:28:36 -0800
Message-ID: <xmqqtufccqaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CD94226-5C42-11EC-A949-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/sparse-checkout-set (2021-12-08) 10 commits
> ...
>>  Need to check the reroll.
>>  cf. <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
>>  source: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
>
> I'm confused by the status here; en/sparse-checkout-set already
> represents v3, not v2, so you've already picked up the reroll.  (v3 is
> the one containing both Stolee & Victoria's Reviewed-by.)  I think
> that also means your cf. should be labeled as the source, yes?

And the old one needs to be dropped.  I meant to do so after
checking the v3 myself but haven't got around to it when the report
was sent.

>> * es/test-chain-lint (2021-12-09) 19 commits
> ...
>>
>>  Broken &&-chains in the test scripts have been corrected.
>>
>>  Will merge to 'next'?
>
> Eric sent a reroll of just patch 2 with some working clarifications.
> It's a small thing, but I think it'd be great if that re-rolled patch
> could be picked up and inserted into the series.  Other than that,
> yeah the series is good to merge down.  (Peff and Fabian seemed to
> think so too.)

Pointers?

I know Eric said in
<CAPig+cR0eKhz+ncWb4v9dSY0A03P+K0+WT90J2cBKvLqT8DXrA@mail.gmail.com>
"I am a bit hesitant about spamming the list", but I do not know
what came after it.

... starts a browser and looks ...

OK.  I found it at
https://lore.kernel.org/git/20211211095837.26387-1-sunshine@sunshineco.com/

Will take a look.  Thanks.
