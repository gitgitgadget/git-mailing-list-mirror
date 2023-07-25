Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F0EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGYU7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYU7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 16:59:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949DE78
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 13:59:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E03BF1892AD;
        Tue, 25 Jul 2023 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z/Ios38kDIx1GoDbotAQu9URZlYGohIg/itr6v
        kMMrk=; b=uLeRvtAg2aoi2JjQUBkZB5SqzF7PDvMkmuqD5MhQN3CYPV5dyDyS1s
        PuTtFGa8KdlvjmCDCv4zEgtlukuFVUXch0vdp39BQUvscAB0NnU/rNiqDafthXh0
        miKt7MfZLxlfHWvTM5CmyLr1AHfWPNG55xUORhn/S1t5S+q5wW2Ao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D76781892AC;
        Tue, 25 Jul 2023 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47ED31892AA;
        Tue, 25 Jul 2023 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
References: <xmqqedkvk8u4.fsf@gitster.g>
Date:   Tue, 25 Jul 2023 13:59:09 -0700
In-Reply-To: <xmqqedkvk8u4.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        25 Jul 2023 13:57:39 -0700")
Message-ID: <xmqqa5vjk8rm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A32FA42-2B2E-11EE-AE01-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a list of one-line summary for topics in flight.

The dates are committer date for topics not in 'next' (i.e.
typically the first time I happened to have "seen" them); for the
topics in 'next', there is a second date that shows when the topic
was last merged to 'next'.  Typically a topic is expected to spend
7 or so calendar days in 'next' before graduating to 'master'.

----------------------------------------------------------------
Expecting a reroll from the original author.
 - jc/doc-submodule-update-settings                             07-13          #1

Expecting a reroll.
 - tk/cherry-pick-sequence-requires-clean-worktree              06-01          #1
 - jt/path-filter-fix                                           07-13          #4
 - sl/sparse-check-attr                                         07-18          #3
 - ja/worktree-orphan-fix                                       07-21          #4

Needs review.
 - mh/credential-libsecret-attrs                                06-16          #1
 - mh/credential-erase-improvements-more                        06-24          #2

Still filling in blanks.
 - js/doc-unit-tests                                            06-30          #1

Undecided
 - cc/git-replay                                                06-03         #15
 - jc/parse-options-short-help                                  07-19          #3
 - am/doc-sha256                                                07-20          #1
 - rs/parse-options-negation-help                               07-24          #5

Will discard.
 - cb/checkout-same-branch-twice                                03-22          #2
 - ed/fsmonitor-windows-named-pipe                              03-24          #1
 - rn/sparse-diff-index                                         04-10          #1
 - es/recurse-submodules-option-is-a-bool                       04-10          #1
 - pw/rebase-i-after-failure                                    04-21          #6
 - ob/revert-of-revert                                          05-05          #1
 - ab/tag-object-type-errors                                    05-10          #4

Will merge to 'master'.
 + la/doc-choose-starting-point                                 07-14/07-19    #5
 + jr/gitignore-doc-example-markup                              07-18/07-19    #1
 + jc/am-parseopt-fix                                           07-18/07-19    #1
 + jc/branch-parseopt-fix                                       07-18/07-19    #1
 + rs/ls-tree-no-full-name-fix                                  07-18/07-19    #1
 + jc/gitignore-doc-pattern-markup                              07-18/07-20    #1
 + jc/transport-parseopt-fix                                    07-18/07-20    #2
 + jc/parse-options-reset                                       07-19/07-20    #1
 + jc/parse-options-show-branch                                 07-19/07-20    #2
 + bb/trace2-comment-fix                                        07-19/07-21    #1
 + rs/describe-parseopt-fix                                     07-21/07-21    #1
 + rs/pack-objects-parseopt-fix                                 07-21/07-21    #2
 + jc/tree-walk-drop-base-offset                                07-07/07-25    #2
 + ah/autoconf-fixes                                            07-19/07-25    #3

Will merge to 'next'.
 - bb/use-trace2-counters-for-fsync-stats                       07-20          #1
 - ah/sequencer-rewrite-todo-fix                                07-24          #1
 - ks/ref-filter-describe                                       07-24          #2
 - jc/retire-get-sha1-hex                                       07-24          #1
 - cc/repack-sift-filtered-objects-to-separate-pack             07-24          #8

Will merge to 'next'?
 - jc/doc-sent-patch-now-what                                   07-19          #1
 - hy/blame-in-bare-with-contents                               07-21          #1
 - jc/branch-in-use-error-message                               07-21          #1
 - tb/commit-graph-tests                                        07-24          #5
