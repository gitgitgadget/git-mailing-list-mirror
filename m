Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6191C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiDMVrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiDMVr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:47:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6738D99
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:45:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E703A19C7A7;
        Wed, 13 Apr 2022 17:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QCHqDp6nw/yFOeciEfbaL3uHCOOA5xEzD0xUOt
        mo+dM=; b=K/19Ku1Q2hMgpjKtjAofX6PjLTAeXWrq8nHfzUebtzukKfezvXmmTp
        wMmXubM+a/NMZlEoaRoEfB4Yy3fY6ZLI0OiFwdL9jBe858Zk6GFwn/MEEv2mLk5f
        fviKm40KA7pxOARafFK0vZ+jXRHI3VeHXIzg/pH3Ofy/+vj9hMopI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF12C19C7A6;
        Wed, 13 Apr 2022 17:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F71519C7A4;
        Wed, 13 Apr 2022 17:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <xmqq35iharig.fsf@gitster.g>
        <e8383303-e82c-dc23-9f28-6ff566021e82@github.com>
        <xmqqee219bly.fsf@gitster.g> <xmqqmtgo7mqu.fsf@gitster.g>
        <Ylc/4Spmtw/f5Nwr@nand.local>
Date:   Wed, 13 Apr 2022 14:45:01 -0700
In-Reply-To: <Ylc/4Spmtw/f5Nwr@nand.local> (Taylor Blau's message of "Wed, 13
        Apr 2022 17:25:53 -0400")
Message-ID: <xmqqwnfs64ki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F92239DE-BB72-11EC-BE76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Apr 13, 2022 at 01:27:05PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Derrick Stolee <derrickstolee@github.com> writes:
>> >
>> >> I tried to do my due diligence here, but I will admit to some amount
>> >> of haste being applied due to the many distinct sources that have
>> >> motivated the change.
>> >
>> > OK.  Thanks for a fast response to a brown-paper-bag bug or two.
>>
>> Here is a draft release notes to 2.30.4.txt; I may tag this later
>> tonight (i.e. in 4 hours or so) or perhaps tomorrow morning, together
>> with the result of merging the fixes into newer maintenance releases.
>>
>> Thanks, everybody, for working on the issue.
>
> Thanks; this all looks good to me. I took a careful look at Stolee's new
> patches as well as the (elided) release notes from you below, and both
> look good to me.
>
> Don't worry about applying my Reviewed-by, but I did want to acknowledge
> having looked at these.

Thanks for giving an extra set of eyes.

