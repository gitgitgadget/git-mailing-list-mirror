Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E7EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjF1X67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 19:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjF1X6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 19:58:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57922ED
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 16:58:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B322193585;
        Wed, 28 Jun 2023 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2sZQ+ASbMx/IstYtJlH5bAxPju34eLXDwHjIf
        Q8tvc=; b=T1iUyQmQEKE+kzIapyPq9lDokyASFZYHw7DVei1NrFOch/6z9A4GNw
        WL7fCltl39FSnDCFZcg63D4uQ+IvpgZO12XHwRZhCJq0w1XbTmPWZzr/6+U1aoZ9
        Dy2FZ1X9IHkM/81f81Hi33J+EalOpt2bTIzmVixUVAnnFvZgkxsOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A1BB193584;
        Wed, 28 Jun 2023 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5781193583;
        Wed, 28 Jun 2023 19:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #07; Tue, 27)
References: <xmqqcz1gftdn.fsf@gitster.g>
Date:   Wed, 28 Jun 2023 16:58:41 -0700
In-Reply-To: <xmqqcz1gftdn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jun 2023 15:11:16 -0700")
Message-ID: <xmqqttur9m1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B60ACB36-160F-11EE-A5CC-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Summary of updates from today's integration cycle.

> * gc/config-context (2023-06-26) 12 commits
> ...
>  source: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>

This is now in 'next', hopefully in 'master' in a week.

> * gc/config-partial-submodule-kvi-fix (2023-06-26) 1 commit
> ...
>  source: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com>

This is now in 'next', hopefully in 'master' in a week.

> * pw/apply-too-large (2023-06-26) 1 commit
> ...
>  source: <pull.1552.git.1687772253869.gitgitgadget@gmail.com>

Will merge to 'next'.

> * pw/diff-no-index-from-named-pipes (2023-06-27) 3 commits
> ...
>  source: <cover.1687874975.git.phillip.wood@dunelm.org.uk>

Expecting a reroll.

> * jc/doc-hash-object-types (2023-06-23) 1 commit
> ...
>  source: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>

Expecting a hopefully minor and final reroll.

> * rs/strbuf-expand-step (2023-06-18) 5 commits
> ...
>  source: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>

Now in 'next'.

> * pb/complete-diff-options (2023-06-26) 24 commits
> ...
>  source: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>

Now in 'next'.

> * cw/strbuf-cleanup (2023-06-12) 7 commits
> ...
>  source: <20230606194720.2053551-1-calvinwan@google.com>

Now in 'next'.

> * tl/notes-separator (2023-06-21) 7 commits
> ...
>  source: <cover.1685174011.git.dyroneteng@gmail.com>

Will merge to 'next'.
