Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22003C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EB360E52
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhIHA12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:27:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56120 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhIHA11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:27:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2327DE1059;
        Tue,  7 Sep 2021 20:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K6FA5tD1u6LSP2JNNsSShflPLrL6Te8gLtof2t
        5ZBNg=; b=xH9NjBhMekUbpsQGaWXj7+UaxIB8fFdX2MLdWIeP2fKOuGPQx3SlXv
        +8SpTPbk/BMrZBzu4Ft8YwszcO8fz4VcgJ2IVQX19eCxJdT/4Yu5Oh530MVCqxdv
        badCetJ1lYLVvJ9JAUE/wZRdmsW8Ldh/N+LNlXGxzRHV7lCcFCH6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B72AE1058;
        Tue,  7 Sep 2021 20:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90B18E1057;
        Tue,  7 Sep 2021 20:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br
Subject: Re: [PATCH v3 0/8] In grep, no adding submodule ODB as alternates
References: <cover.1628618950.git.jonathantanmy@google.com>
        <cover.1629148153.git.jonathantanmy@google.com>
Date:   Tue, 07 Sep 2021 17:26:18 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 16 Aug 2021 14:09:50 -0700")
Message-ID: <xmqq8s079al1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63437BCC-103B-11EC-9D00-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks for reviewing, everyone. Here are the requested changes.
>
> Jonathan Tan (8):
>   submodule: lazily add submodule ODBs as alternates
>   grep: use submodule-ODB-as-alternate lazy-addition
>   grep: typesafe versions of grep_source_init
>   grep: read submodule entry with explicit repo
>   grep: allocate subrepos on heap
>   grep: add repository to OID grep sources
>   submodule-config: pass repo upon blob config read
>   t7814: show lack of alternate ODB-adding

I didn't see anybody comment on this round (and do not think I saw
anything glaringly wrong).

Is everybody happy with this version?  I am about to mark it for
'next' in the next issue of "What's cooking" report, so please
holler if I should wait.

Thanks.
