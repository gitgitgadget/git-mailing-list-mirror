Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B06C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 04:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiFHEGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiFHEE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 00:04:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F1927F475
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 18:20:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 883AA127DC1;
        Tue,  7 Jun 2022 21:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=taR0CQVZj9hYA4oMEE9qf7POWReSEVc+sZt2iP
        A9LOM=; b=eJ2tW6ZEXd40aaQiTGMyKtX6DzoU+ZfPe2fAujKXh1lSA3bknGVMFp
        Lnd/1aOwoTig6xZnO9q1yZ3EPDMBJrHNQjN+MiXMPpZ8fixsQqejrOeRuKp+7eHy
        xxhHxWrLTF+nkuHbGAVau3t5ex97vhnekh04t56ZA9TMRv8lbVL0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8072B127DC0;
        Tue,  7 Jun 2022 21:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA26C127DBD;
        Tue,  7 Jun 2022 21:14:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] config: document and test the 'worktree' scope
References: <pull.1274.git.git.1654637044966.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 18:14:06 -0700
In-Reply-To: <pull.1274.git.git.1654637044966.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Tue, 07 Jun 2022 21:24:04 +0000")
Message-ID: <xmqqsfogrm75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BA2E296-E6C8-11EC-91A0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Test that "git config --show-scope" shows the "worktree" scope, and add
> it to the list of scopes in Documentation/git-config.txt.
>
> "git config --help" does not need to be updated because it already
> mentions "worktree".
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     config: document and test the 'worktree' scope
>     
>     While I was digging through the docs on config scopes for
>     discovery.bare, I noticed that Documentation/git-config.txt doesn't
>     mention the 'worktree' scope, but the usage string does.

Excellent.

Thanks, will queue.
