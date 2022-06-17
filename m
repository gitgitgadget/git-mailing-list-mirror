Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D945C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiFQVcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiFQVcH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 17:32:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7554C7A5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 14:32:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34A7F1337D4;
        Fri, 17 Jun 2022 17:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6AZHiQ0VYWKelPf++KFy1AsBqjDuYzJTj4yr3G
        7k6WU=; b=ArZRDStGAlMXP7e5YyTS7m3RA6dGQcBR2MrI8ZKV5D0LZpNr9z810t
        gZJ8aiFFxBO46xQ/XIP2xm/raEk/WaFoNOVstWyqzmLC3XOTbUNBzH/7yjPlMwsY
        0pVGtsEnGLlHGmQ6T4cjQ+ZlfjbNKLXZRBkVeeGVBDtZiOtSTEirk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29DA61337D3;
        Fri, 17 Jun 2022 17:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 723D11337D2;
        Fri, 17 Jun 2022 17:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] send-pack.c: add config push.useBitmaps
References: <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com>
        <pull.1263.v4.git.1655492779228.gitgitgadget@gmail.com>
Date:   Fri, 17 Jun 2022 14:32:04 -0700
In-Reply-To: <pull.1263.v4.git.1655492779228.gitgitgadget@gmail.com> (Kyle
        Zhao via GitGitGadget's message of "Fri, 17 Jun 2022 19:06:19 +0000")
Message-ID: <xmqq4k0jnfhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF067830-EE84-11EC-99EA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since v3:
>     
>      * changed the commit message
>      * s/no_use_bitmaps/disable_bitmaps in send-pack.h and send-pack.c
>      * I modified the document about "push.useBitmaps". When it is true, Git
>        will keep the historical behaviour. So I mainly introduced what
>        happens when it set to false.
>      * use test_config and test_unconfig for test.

Looking good.  Will queue.

Thanks.
