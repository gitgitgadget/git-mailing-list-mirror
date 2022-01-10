Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ABAC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiAJSll (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:41:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51808 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiAJSlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:41:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE52E185C48;
        Mon, 10 Jan 2022 13:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x0uazPmEE1QQb7r1pKXSFUz1UfbrIbvyY9GM7D
        eiGfI=; b=uDbTf3byzxMZQD5IbdYmAbwHPLlXuw1jdL3Zx7jDDbcM/4P+mU3Pul
        mHPhwlNbKeSR73sNuMCJPhnv4QCPlmp3YHPJuK/hQzFXM5nI2UeUcxYEz7qzbs8e
        deQv1vY7VgkBgJXtJg5MjdGWDgoNDmhfjOQHEirCytfuxnlK7F/jU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5DF3185C47;
        Mon, 10 Jan 2022 13:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1987F185C46;
        Mon, 10 Jan 2022 13:41:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2021, #06; Mon, 27)
References: <xmqq7dbpvb0q.fsf@gitster.g>
        <CABPp-BFR29S-Pwq9LZEOjaCxozTV9mkUBpd2SLGwh7jNW+On4w@mail.gmail.com>
        <kl6ltuej6t3s.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 10 Jan 2022 10:41:37 -0800
In-Reply-To: <kl6ltuej6t3s.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 04 Jan 2022 14:20:23 -0800")
Message-ID: <xmqqsftvzb4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1C4BCD8-7244-11EC-B81E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>>> * gc/branch-recurse-submodules (2021-12-25) 7 commits
>>>  - fixup! branch: add --recurse-submodules option for branch creation
>>>  - branch: add --recurse-submodules option for branch creation
>>>  - builtin/branch: clean up action-picking logic in cmd_branch()
>>>  - branch: add a dry_run parameter to create_branch()
>>>  - branch: make create_branch() always create a branch
>>>  - branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>>>  - Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules
>>>  (this branch uses js/branch-track-inherit.)
>>>
>>>  "git branch" learned the "--recurse-submodules" option.
>>>
>>>  Will merge to 'next'?
>>>  source: <20211220233459.45739-1-chooglen@google.com>
>
> Is there anything in particular blocking this series? e.g. does it need more review?

An ack or two from those who gave their feedbacks on previous
rounds, which hasn't happened since v3, I think.

>> Can we squash the "fixup!" commit before merging?
>
> Makes sense, I can squash it :)
