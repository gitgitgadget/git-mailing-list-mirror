Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE25C4743F
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE5561184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhFHXXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:23:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62574 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhFHXXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:23:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65B61B972A;
        Tue,  8 Jun 2021 19:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vJop0FYDgCsOiLwJXH29nf0N7o/Hb5zdoF16w6
        ZTdkQ=; b=fphdAmqva+FilZXUT0B46vi3Sw8iM5QXsGVYFvXPj9iNNMkUcZfTmm
        Ui73dOsww3f2uF2GfJC1L3JIGCeeI317Vql8VCQgKz/bauODfUjSXRb0ejaqVEdZ
        NzVOGEqO4I9RTNPUkCywqP3Z3jyeRhM1acUrj4hVtA24d2x3rSbEE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D31CB9729;
        Tue,  8 Jun 2021 19:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD363B9727;
        Tue,  8 Jun 2021 19:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
        <xmqqh7i9rw5o.fsf@gitster.g>
        <AS8PR02MB73029EDC4458F233543106D99C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
Date:   Wed, 09 Jun 2021 08:21:10 +0900
In-Reply-To: <AS8PR02MB73029EDC4458F233543106D99C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Tue, 8 Jun 2021 08:51:51 +0000")
Message-ID: <xmqqczswndsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35E993FA-C8B0-11EB-8381-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

> Or:
>
>     `Reviewed-by:`, unlike the other tags, can only be offered by
>     a reviewer when they are completely satisfied with
>     the patch.  It is offered only after reviews by
>     reviewers who are known to be experts in the affected area by
>     the community members.
>
> Sentence one uses singular they to refer to one of a pool of reviewers.  
> In the second all items are plural.

Yeah, it reads well, I'd think.
