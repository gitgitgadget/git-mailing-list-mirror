Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C9C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AD961364
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFAI4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:56:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64699 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAI4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 04:56:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8473413A6FF;
        Tue,  1 Jun 2021 04:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Vm+CKYDpEZKwWQEysisBO6fseEtQ8/bRthoQwz3o9ZI=; b=q8G4
        Cni7fj24OXMY1gdAINRuLcSwKgmtEKL/7Y4MKpF0bLmLSWXG3eI1FDhHGYRtJ3OG
        pvGot3lD83o2Iyrty1ZGL6XXPAHYB0GjpOgXAw2m6dAEIJ8JxYlkcRS/hI2+VoCE
        5rrPmM0IM3xsqmUOz8VJ9HAXOpy4u9b1D9XgnUY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CE6D13A6FE;
        Tue,  1 Jun 2021 04:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C425F13A6FD;
        Tue,  1 Jun 2021 04:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
        <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
        <xmqqtumjy2e4.fsf@gitster.g>
        <CAOLTT8QFW4UrwZ+OboYqkoT-oKo1Sz3JJ-Fp8b2RWugMOy5Cug@mail.gmail.com>
Date:   Tue, 01 Jun 2021 17:54:51 +0900
Message-ID: <xmqqlf7ut15w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08D90BD8-C2B7-11EB-B48B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> Doesn't this conflict with your own zh/ref-filter-atom-type topic?
>> Shouldn't one build on top of the other?
>>
>> Or did we find something fundamentally broken about the other topic
>> to make us retract it that I do not remember?
>>
>> Thanks.
>
> I am waiting for zh/ref-filter-atom-type to be merged into master. But it

As you sent this that conflicts with it, clearly you are doing
something else that conflicts with it _without waiting_ ;-).

> hasn't happened yet. But if I want to base the current topic on
> zh/ref-filter-atom-type, GGG will send past patches (zh/ref-filter-atom-type)
> repeatedly.

I thought GGG lets you say "this is based on that other branch, not
on the 'master' branch" to solve that exact issue?
