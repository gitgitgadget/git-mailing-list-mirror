Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACEC433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbhLOSrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:47:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53840 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343960AbhLOSri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:47:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26C2B170AA5;
        Wed, 15 Dec 2021 13:47:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d3hsw4P4OKmFzWH7IAo7EP7keyHxx4r+oopO5y
        spsEo=; b=Mr5aTDTgrVeFDemj9/3peuK5+AuU3ShqlR897ziMtbnZreoW5krYIL
        VXeZ7Krb6dBwGi8hXqkJ08vpZSGajBTmIfV83iw1KNddLs/gREviawmFB2rOPa/d
        zb3/mCTtitSPMO4wJrY+WKweN5WyGc9IYrCudH1HpQyVwBwekbYIw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DF8E170AA4;
        Wed, 15 Dec 2021 13:47:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F524170AA3;
        Wed, 15 Dec 2021 13:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
References: <xmqqilvvluoa.fsf@gitster.g>
        <CABPp-BEpcmxyRVzC4afRTCdV1W=RQxfzUPESbR_pFGmvTXqTtg@mail.gmail.com>
Date:   Wed, 15 Dec 2021 10:47:31 -0800
In-Reply-To: <CABPp-BEpcmxyRVzC4afRTCdV1W=RQxfzUPESbR_pFGmvTXqTtg@mail.gmail.com>
        (Elijah Newren's message of "Sat, 11 Dec 2021 02:49:31 -0800")
Message-ID: <xmqqr1ad7lj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 763CD9FA-5DD7-11EC-8269-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * ds/fetch-pull-with-sparse-index (2021-12-08) 6 commits
> ...
>>  Ejected from 'seen', as it seems to fail its self-test.
>>  source: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
>
> I _think_ Stolee addressed this in his v3 cover letter with his
> comment that he also needed to merge with master[1].  

The topic is built on a merge of "ld/sparse-diff-blame" into "master",
so "also needed to merge with master" should be satisified already.

>> * pw/diff-color-moved-fix (2021-12-09) 15 commits
> ...
>>  Will merge to 'next'?
>>  source: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
>
> Dscho seemed to suggest that course of action[2].  (I also looked at
> the series, though much more lightly -- I couldn't spot any problems.)
>
> [2] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112081329030.90@tvgsbejvaqbjf.bet/.

Yup, after giving it another look, I agree that this is ready.

Thanks.
