Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBAAC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE1F6198A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhC2VGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:06:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53706 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhC2VFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:05:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 812E7B8671;
        Mon, 29 Mar 2021 17:05:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D2M1ngNXczCtNaSL2kvSUGTnJR4=; b=rG2Ypy
        lvAqaphX06maLDgckzhNVB0g0/vgKT2LqAxjPjyKFyZ3OwT3FM5wCOOEZGaVnyIU
        OZJf2ptqyWNqKQm8BMtGttDI4Kx5ev3hlq2piIWfoY1EQFQAGpYYn9Eu2H4iB1pC
        Uu1gjVrOYYwqJorvya8pqROI+mun1dQvh+ta4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J+TsgvyaGLn3jbv3mscQurAor8aeof54
        6uhGAEjFlQvpz8Xt/S9F/IUGh/B9+b/HIT8bbxsoI1IvHwXAiK+AXBLrpESFPXer
        ANn/XVb6EHzAUWt8modGlVSF0MsczIgjG/CYjpgH776kzR6qTgXOlexaqo7nTOGP
        jjLJnRCA06M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79466B8670;
        Mon, 29 Mar 2021 17:05:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 013D7B866F;
        Mon, 29 Mar 2021 17:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Chinmoy <chinmoy12c@gmail.com>
Subject: Re: [PATCH v4] column, range-diff: downcase option description
References: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
        <pull.920.v4.git.1617029194872.gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 14:05:32 -0700
In-Reply-To: <pull.920.v4.git.1617029194872.gitgitgadget@gmail.com> (Chinmoy
        via GitGitGadget's message of "Mon, 29 Mar 2021 14:46:34 +0000")
Message-ID: <xmqqmtulisbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80044E28-90D2-11EB-A624-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>
> It is customary not to begin the help text for each option given to
> the parse-options API with a capital letter. Various (sub)commands'
> option arrays don't follow the guideline provided by the parse_options
> Documentation regarding the descriptions.
>
> Downcase the first word of some option descriptions for "column"
> and "range-diff".
>
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---

Thanks, Chinmoy, Bagas and Philip.  Will queue.

