Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDAC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4513160F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhHDGMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 02:12:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50082 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhHDGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 02:12:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B114DDDA61;
        Wed,  4 Aug 2021 02:12:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K29orLeflLA0DzGfe35eshua2M/JirUdSQhuH8
        ftlJY=; b=S9RKai8GqNa4gS95DdUXvPIDHuFfzBZKM2hh4hvLI3ZvUsUDq+BiPo
        70yTT4KrhlfpwYPRKHkkI8GgXEIpxBpDqlCdYOPmHBrXGjSSAR4Qcr7jvXkOfchS
        0lDJ69GowNC1CxoStAAqzxBTJRPd3tSHJ76d8vqzYg3vl8tWghp0E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 986D8DDA60;
        Wed,  4 Aug 2021 02:12:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 099F2DDA5F;
        Wed,  4 Aug 2021 02:12:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/10] Documentation updates: merge-strategies
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 23:12:36 -0700
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 04 Aug 2021 05:28:45
        +0000")
Message-ID: <xmqqk0l1rb57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7207B22-F4EA-11EB-8DD8-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * Multiple tweaks suggested by Eric, Dscho, and Junio
>  * Removed patch 7 explaining no-renames since that probably belongs in git
>    diff --no-renames instead, and this series is about merge-strategies.
>  * Inserted a new patch 8 that strikes some misleading or at least
>    no-longer-important text from git-rebase.txt (due changes back in late
>    2006).

Looking good.
Will queue, together with the "switch" patches on top.
Thanks.
