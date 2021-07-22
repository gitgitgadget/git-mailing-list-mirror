Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81EC432BE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AA860EBC
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGVVnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:43:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59837 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGVVnm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:43:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1E4414F5C7;
        Thu, 22 Jul 2021 18:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PO5GB9fbPdHiiMSbxZOFab864nLOfd31r4kTsM
        DSsLA=; b=qn1XgzqredPZTS/UoS9vFYgAtCmWYXfTXMmpC9yZEZxUKgc+oQF6bb
        TuTXddN3okLB4+Ir3RBpb8htngxeEBUR3zNS0iUoRRdTjabvq4AoTtHyQtMlCUzr
        TvmrVRGAgcKVwvisYwgVPGYGeN9vvqtn2XT1gnOX6aodIJnaNINk0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A9BC14F5C6;
        Thu, 22 Jul 2021 18:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6B6914F5C3;
        Thu, 22 Jul 2021 18:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/6] Fix direct filesystem access in various test files.
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 15:24:11 -0700
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 19 Jul 2021 18:07:24
        +0000")
Message-ID: <xmqqk0li7zsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B60CD82-EB3B-11EB-948E-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This fixes a few test failures in the reftable series.
>
> Han-Wen Nienhuys (6):
>   t6050: use git-update-ref rather than filesystem access
>   t1503: mark symlink test as REFFILES
>   t6120: use git-update-ref rather than filesystem access
>   t7509: use git-update-ref rather than filesystem access
>   t3320: use git-symbolic-ref rather than filesystem access
>   t2402: use ref-store test helper to create broken symlink

Modulo for the duplicated one, the other 5 looked all sensible and
are now part of 'next'.

Thanks.
