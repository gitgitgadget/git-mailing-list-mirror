Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED4C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiCBXuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiCBXuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:50:24 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2524634E
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:49:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48BEF11EBDE;
        Wed,  2 Mar 2022 18:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+hyNOJfmZcZ+uGeZtpdOkj3VbeANFPOx2CYvsh
        V+Rbk=; b=SEbJUrO8Tc0hMzA5Nv/fho4rUn35KRlhPx2kF4k0tc+s7FHW8+PCZy
        TfEcKfCsaq/kRHcgOPJFy+d9+8dlE/Dg6XkNa1c3ArHrJecpjBFpBJcs/UNMT2jw
        Pk0gW3wxSEWBDtStY3uJpwXXykLC/Upp34qi0n2t2ta5rkloZ9Qj8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A3F311EBDD;
        Wed,  2 Mar 2022 18:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EAD811EBDC;
        Wed,  2 Mar 2022 18:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/3] libify reflog
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
        <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 15:34:05 -0800
In-Reply-To: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 02 Mar 2022 22:27:21 +0000")
Message-ID: <xmqqfso0exoy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 411AFB8A-9A81-11EC-B07E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch has three parts:
>
>  * add missing test coverage for git stash delete

This looking better, relative to the previous iteration.

>  * libify reflog's delete functionality and move some of the helpers into a
>    reflog.c library and call reflog_delete from builtin/reflog.c

This part hasn't changed since the implementation in the previous
round I've looked at; looked sane.

>  * call reflog_delete from builtin/stash.c

Likewise.

Thanks.  Will queue.
