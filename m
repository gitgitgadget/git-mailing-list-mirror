Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47451F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 04:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKUPUX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:20:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53964 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUPUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:20:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C998B10E584;
        Tue, 20 Nov 2018 23:47:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cB4KDFldHlLoAZ4UKvslwb9h+08=; b=Imh8KU
        9OTWG45pkc75mJe9S1sLybvrTzs6E+WS9Dzt0sjSJzZ6UfWmH+vSRlN7MOtfZEh3
        O2828bres7EfpgUVJlBATL8j+ERTzSrknRxeSi8QCI6kSn7L62w9Cgki48MqIdgz
        Uoj8+dtLtDIc3bD9UaeWUbSxs0VNuScRC7sXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J4sKB1EJ6l6WqUJqf79UqDHYoT2wJZj1
        bIB+6bnhwm4mWapfUomjtF0AGlJ2xT+BOF0u6yD+7ilkErnLwP8TJl2GXB27Z/cr
        5nAkXSrHeGUYdeIEP48UmNwl2NkFjncGxg/+rbzgRsnZZeTiKDx4oHM/woQu9TLC
        7UfrEm3zYsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C03F210E583;
        Tue, 20 Nov 2018 23:47:33 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40A0310E582;
        Tue, 20 Nov 2018 23:47:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] rebase: warn about the correct tree's OID
References: <pull.85.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Nov 2018 13:47:32 +0900
In-Reply-To: <pull.85.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 20 Nov 2018 01:44:32 -0800 (PST)")
Message-ID: <xmqqefbf82aj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F524810-ED48-11E8-981F-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> A quick fix for a recent topic. Not overly critical, but I would deem this
> v2.20.0-rc1 material.
>
> Johannes Schindelin (1):
>   rebase: warn about the correct tree's OID
>

Yup, it is kind of embarrasing that nobody caught it, but at the
same time, this typo is at so tiny level that I would not be
surprised if it survived for many years.

Will apply.


>  builtin/rebase.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
>
> base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-85%2Fdscho%2Freset_head-typo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-85/dscho/reset_head-typo-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/85
