Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B92C07E9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6830261CC3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGGUrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 16:47:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGUq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 16:46:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A05261352E6;
        Wed,  7 Jul 2021 16:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PJi7501TsYlNBtFZZ1ubh9CCOWxOrb4JmJZjeV
        BCkxw=; b=Mnfg0K6m2Cm/R/0yF4K3KFwop4otBX7/UxcsJWXmLdaEbPUZb8LUnG
        3fRBfxggJxyQEIlPhxSay8iUXPkQNiqlSmc+eR9Jjz2RuWJCvJQjUXk9CEcg3aDa
        +RmsnN5IOh6zsfIW69dESNJK68J4DtslUym4Z2GwjPZooYGeMJ+D4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 985A31352E5;
        Wed,  7 Jul 2021 16:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C07D1352E1;
        Wed,  7 Jul 2021 16:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 0/6] refs: cleanup errno sideband ref related functions
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 13:44:14 -0700
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 07 Jul 2021 19:07:43
        +0000")
Message-ID: <xmqqa6mxetwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 183CEDE6-DF64-11EB-876C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Han-Wen Nienhuys (6):
>   refs: remove EINVAL errno output from specification of read_raw_ref_fn
>   refs/files-backend: stop setting errno from lock_ref_oid_basic
>   refs: make errno output explicit for read_raw_ref_fn
>   refs: add failure_errno to refs_read_raw_ref() signature
>   refs: explicitly return failure_errno from parse_loose_ref_contents
>   refs: make errno output explicit for refs_resolve_ref_unsafe

Thanks, incremental changes look sensible.
Will requeue.
