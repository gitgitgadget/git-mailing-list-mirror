Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28CC43381
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55AD64E41
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhBBT7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:59:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60127 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhBBT6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 14:58:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1851B9D6D1;
        Tue,  2 Feb 2021 14:57:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H4DgUdZ7BeuMxE6tGmp7FmzARBY=; b=mNurkB
        yjPbLxD0lRRGo9ffSzDGXwBOov8BpQ/RjvE3qJyh+zduMpVi43XqxP+7bqlTqE5U
        XHtRV0ecZPvmMX904x3fd9UdwIftDtQng4WebGj/wlTj3bqQzC3hTj4kKiHcqbpC
        G7Rx2E5DDP9/oOBkJsEVGOXX43CYJkIc2q+k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N+0Amd83cOebZi5kFXuaeVqn/01tWG2T
        uRj1L1CbcaGQb5BlbGokGo+xc7Nuq5bqZ3PnUX4mOofKgl61KENeBc4gZXUnZI4p
        etXsE3iB4EH6i2+1HGXlu9Et/kHCZQDNce7yGLQsikGgVJvEp4E9hmiic5pUWJPU
        fxRpcfyMqEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC4E9D6D0;
        Tue,  2 Feb 2021 14:57:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AB149D6CF;
        Tue,  2 Feb 2021 14:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2 0/6] doc: improvements for hash-function-transition
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 11:57:57 -0800
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com> (Thomas
        Ackermann via GitGitGadget's message of "Tue, 02 Feb 2021 16:19:03
        +0000")
Message-ID: <xmqq7dnqgs3e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2A9D672-6590-11EB-8681-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Some asciidoc formatting errors and some minor formatting inconsistencies in
> hash-function-transition.txt were fixed.
>
> Content-wise the rationale for choosing SHA-256 was shortened and moved to
> the beginning of the document and an incomplete sentence was corrected.

The series was more-or-less a pleasant read, except for a minor nit
about sha1 => SHA-1 sha256 => SHA-256 changes in 1/6 that should
have been in 2/6, and some changes in 5/6 that I found questionable.

Thanks.
