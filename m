Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2DC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiJYPkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiJYPkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 11:40:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FF8A1EB
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 08:40:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB56F1D0FEF;
        Tue, 25 Oct 2022 11:40:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1EA58dZQB+/35G62aOvoWAvykWaBKFXMjrCIr
        AvfM4=; b=KF886jSykPt6xQpfYaEqjri+NksdqyjNthMX17vl2bPO7AHkWJYfxx
        Q6dIXP8Ys7kUgmJy0lU3HlGPrOLWyt2I+XmWcH91OSDC5NZ5wA90Q/fS3UTa3S9H
        L++7XyXGkV2QfjsSKD5SrdXVNoCZYYf1a+GIyFNpZlbI/2TeZ3WcM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA35A1D0FEE;
        Tue, 25 Oct 2022 11:40:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BB711D0FED;
        Tue, 25 Oct 2022 11:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 1/8] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
        <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666618868.git.gitgitgadget@gmail.com>
        <xmqqeduxrmjs.fsf@gitster.g>
        <a7b0b896-7b2b-a263-dd71-8b7b929707b4@github.com>
Date:   Tue, 25 Oct 2022 08:40:09 -0700
In-Reply-To: <a7b0b896-7b2b-a263-dd71-8b7b929707b4@github.com> (Derrick
        Stolee's message of "Tue, 25 Oct 2022 08:35:10 -0400")
Message-ID: <xmqq1qqvq5d2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F393A56-547B-11ED-8F34-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 10/24/2022 4:31 PM, Junio C Hamano wrote:
>> As I do not see a cover letter for this series, here is the summary
>> of the change since the previous round that has been in 'seen'.
>> 
>> I didn't see anything questionable in these.
>> 
>> Thanks, will queue.
>
> The cover letter appears on my end, but I'm on the CC list.

Yeah, it seems vger was a bit constipated yesterday.  Everything
came through at the end, and I am happy with the series.

> Jeff: be sure to CC Junio by adding him to the CC list on your
> PR description for anything you want to have considered for
> queuing.

Everybody wants their non RFC patches to have considered for
queuing, but vger is not that lossy ;-)

