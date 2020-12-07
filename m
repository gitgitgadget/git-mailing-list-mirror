Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E6C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0269020449
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLGSgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:36:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61561 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGSgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:36:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B61A8A41B;
        Mon,  7 Dec 2020 13:35:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bo1iRhsu6phX2usIir20cgMZUeQ=; b=FCUaBr
        hgUvqMxz7NngqggxTDxSQ0ci7djkUm69EQJt8hSE1CR5o0ETEvUpqv4cMkF5KsMI
        ohAtZqwu1JVdzHYZvUtc3XTJmaRK22vfwtX+tCSfm+JBXgh+uGSsoIv5gbIOMqCy
        pPByTvNQZqV8rvMcFiwhxCo7KXjiHMeJXL+qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tGwBm8kA6cIAb0wdbDD7mLUiQXXBgnI/
        xwbdBHmys9KhsjPZkp1VXrWuIoBA5wJuvhkejClqpvUR44w7DFU1jxE2l93R1T8f
        jBHo9gAvyCbpVOd7OehxAWgAnhdUhp9zm/4rR0zhKe9jEzKXxY3nXTPoCN4ivS9j
        x3Gb0kS5PDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 531038A41A;
        Mon,  7 Dec 2020 13:35:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAC6A8A416;
        Mon,  7 Dec 2020 13:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
Date:   Mon, 07 Dec 2020 10:35:48 -0800
In-Reply-To: <pull.809.git.1607260623935.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sun, 06 Dec 2020 13:17:03
        +0000")
Message-ID: <xmqqim9dbh17.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06C3E88A-38BB-11EB-8C57-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     This one goes on top of tb/pack-bitmap, and requires an update of
>     js/default-branch-name-tests-final-stretch (it no longer needs to
>     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).

As the targetted topic is not in 'next' and marked with "Needs a bit
of reshuffling?", I'd appreciate this patch to be also forwarded so
that I do not have to worry about it myself.

The same goes for <pull.809.git.1607260623935.gitgitgadget@gmail.com>
which currently sits at the tip of tb/pack-bitmap.

Thanks, both.
