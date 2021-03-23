Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C293C433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1469D619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCWRfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:35:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60262 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCWRe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:34:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89D3CB5C0C;
        Tue, 23 Mar 2021 13:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=om4W2RGzAXctdnZlMHw+QZpf8NE=; b=tk9eRI
        +mjRSH20QW+0rA2t6VSlWqm+myI4wrEEEFXPBWW5CxJIwOB5xD5HLpiXI1uahRtJ
        oMZ1zgzlU6pWjrt8c+3CApqQf0L+E4DLPIf5hiXeK4CLUYSyGX8pYpWP/vGb6kP5
        VAJB8yBUirf2AY6ckHcNa4qNGnc0NJGX8WzqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pfZpJ4c066jpwIHEDn9UfkWcr5ligzyw
        UwkPfnu8BRscyB0AKt22o7CHQV/mtMdCrugXkzIonoTxVbvldrGBrMzCxQXRFQit
        OB6EA6ntCP7wd3ogp4nPi10SaQIMrYsSKxSD14ZlUi3/MxQ86ARXTtRYCIj+CHx3
        gqQRuLebw80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81923B5C0B;
        Tue, 23 Mar 2021 13:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EF18B5C0A;
        Tue, 23 Mar 2021 13:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Parallel Checkout (part 1)
References: <cover.1608128666.git.matheus.bernardino@usp.br>
        <cover.1616508954.git.matheus.bernardino@usp.br>
Date:   Tue, 23 Mar 2021 10:34:55 -0700
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Tue, 23 Mar 2021 11:19:27 -0300")
Message-ID: <xmqqzgyt3ha8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1554FACE-8BFE-11EB-8072-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Preparatory API changes for parallel checkout. This version was rebased
> on top of 'master'. The only change required in this change of base was
> the `entry.h` inclusion on `builtin/stash.c`, at the commit that creates
> this header file.

Thanks.  I think you had part-2 that depended on this one, so if I
have a(n old) copy I'll rebase them on this round myself.

