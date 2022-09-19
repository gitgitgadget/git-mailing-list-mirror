Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042EC6FA8B
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiISViK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiISVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 17:37:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299440E27
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 14:37:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B87A5142179;
        Mon, 19 Sep 2022 17:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGF/uwnNfkHb5+PvEyHHpinKxyOuJzl+Oq6WfH
        zprGA=; b=ZwJX/jxQjhMZ61fC+kMH9PKt+gzZTf0TVglttYEKfe75D3naeR2mfF
        XLGY49ORZK0NYFA5wT5VVM6AuWddiPp0x6w5qeL9x3e4cgPn0cqGrNDBNJV4tZsf
        jVUmUVnDgf4hVnRIyussUmf2u0/7R9KuuI68fdXrmRlPFqoO+xdfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF6CE142178;
        Mon, 19 Sep 2022 17:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10E6E142177;
        Mon, 19 Sep 2022 17:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, steadmon@google.com,
        chooglen@google.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
        <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 14:37:33 -0700
In-Reply-To: <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Mon, 19 Sep 2022 19:12:46 +0000")
Message-ID: <xmqq4jx39hb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45B7567C-3863-11ED-9CCC-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add a reviewing guidelines document including advice and common terminology
> used in Git mailing list reviews. The document is included in the
> 'TECH_DOCS' list in order to include it in Git's published documentation.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>     Documentation: add ReviewingGuidelines
>     
>     This patch follows up on a discussion a few weeks ago in the Git IRC
>     standup [1], where it was mentioned that it would be nice to have
>     consistent definitions for common review terminology (like 'nit:'). The
>     "ReviewingGuidelines" document created here builds on that idea, as well
>     as past discussions around the idea of advice for reviewers (similar to
>     the guidelines for new contributors in MyFirstContribution [2]).

Thanks.  Will queue.

I think this is ready for 'next' and then to 'master' during this
cycle.  Thanks for writing it, and thanks all for reviewing it.
