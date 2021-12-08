Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F65C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhLHVQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:16:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63049 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:16:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 702DB173133;
        Wed,  8 Dec 2021 16:13:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TWTFi7cb/3rfiFl5UYLu1oYZChewKvhBMMRkaf
        qZMS0=; b=l4GSJlLM3ffBsq2FV4JGbyYxa5FKKSdWVaL1kmXM058IOdaL1PwHmD
        L91j4g884exW7/MrDsidnn202SiwztJxuGdSYleBDD251q7N4IyjsbYwDgPlaiIE
        JjcwkWVXNH63swI1KIrJTn3iP8OiyY2oGNG7QpgYVB8E3OW964FNI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 687AA173132;
        Wed,  8 Dec 2021 16:13:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69426173131;
        Wed,  8 Dec 2021 16:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ld/sparse-diff-blame, was What's cooking in git.git (Dec 2021,
 #02; Tue, 7)
References: <xmqq8rwv6e0a.fsf@gitster.g>
        <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com>
Date:   Wed, 08 Dec 2021 13:13:06 -0800
In-Reply-To: <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com> (Lessley
        Dennington's message of "Wed, 8 Dec 2021 13:57:59 -0600")
Message-ID: <xmqqtufiztp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4656D68-586B-11EC-A5E0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

>> * ld/sparse-diff-blame (2021-12-06) 8 commits
>>   - blame: enable and test the sparse index
>>   - diff: enable and test the sparse index
>>   - diff: replace --staged with --cached in t1092 tests
>>   - repo-settings: prepare_repo_settings only in git repos
>>   - test-read-cache: set up repo after git directory
>>   - commit-graph: return if there is no git directory
>>   - git: ensure correct git directory setup with -h
>>   - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
>>   (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/sparse-reset.)
>>   Teach diff and blame to work well with sparse index.
>>   Will merge to 'next'?
>>   source: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
>
> This series has been reviewed at different stages by:
> ...
> I believe all comments have been addressed (either in the form of a
> re-roll or a patch or explanation in my reply) and that this branch is
> ready to merge to 'next'. I have cc'd all reviewers, though, in case there
> was something I missed.

I think the patches in this series are in good shape.  The other
topic this series depends on is already in 'next', so we can mark
this for 'next', too.

Note that "explanation in reply" does not count as much as an
improved version would.  If the code or the log message puzzled a
reviewer during the review, future readers of the code and "git log"
will be puzzled the same way.

Thanks.
