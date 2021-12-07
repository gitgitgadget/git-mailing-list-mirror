Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF3C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378921AbhLGBMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:12:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbhLGBMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 20:12:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C97B10B216;
        Mon,  6 Dec 2021 20:08:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pVyBI6MEi+JUdXC9NqSxV+d7PlaSwhrs91R9/i
        lm5TI=; b=ib9xMGjezVyzgUvRb8OcjvM0cvLGsUuZWggdu2RYD3gs12RP/2yEZF
        A6Ssttt1u1XcBq7oK2SxmSUM1vCdzULtQGOp2/k434uiOhIy93pFmVqbetQT1N0w
        hPlAJfXrXPCDOjqc96p6GEldQhF6hbgqxWxWfDInHX078+Yu4Awe4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 349F810B215;
        Mon,  6 Dec 2021 20:08:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DD5B10B214;
        Mon,  6 Dec 2021 20:08:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
References: <xmqqbl1xqheu.fsf@gitster.g>
Date:   Mon, 06 Dec 2021 17:08:33 -0800
In-Reply-To: <xmqqbl1xqheu.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        03 Dec 2021 17:37:29 -0800")
Message-ID: <xmqqilw1b4ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33410EA2-56FA-11EC-989D-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FYI, here is how the topics listed in the report are categorized
> (output from the 'cook -w' script I mentioned in the main report).

The output from the same command to summarize the current draft of
the next issue of the "What's cooking" report looks like this.  As
promised, unless a problem is found in it, a topic in 'next' will
graduate almost automatically to 'master' after spending a week
there, so by the end of this week we'll have ~40 topics graduating
to 'master'.

Please pay extra attention to the list of topics slated for 'next'
(with and without the '?') to stop topics that are not quite ready
to go in to 'next' by mistake.

Thanks.


Expecting a reroll.
 - cf/fetch-set-upstream-while-detached                         07-06          #1
 - pw/fix-some-issues-in-reset-head                             10-01         #12
 - jh/builtin-fsmonitor-part2                                   10-21         #29
 - jc/doc-submitting-patches-choice-of-base                     10-25          #2
 - pw/diff-color-moved-fix                                      10-27         #15
 - js/branch-track-inherit                                      11-18          #1
 - es/superproject-aware-submodules                             11-18          #5
 - tl/ls-tree-oid-only                                          11-22          #1
 - tb/cruft-packs                                               11-29         #17
 - cb/save-term-across-editor-invocation                        12-01          #3
 - je/http-better-error-output                                  12-03          #1
 - ds/fetch-pull-with-sparse-index                              12-06          #3
 - ns/remerge-diff                                              12-06          #8
 - ns/batched-fsync                                             12-06          #8

Expecting a reroll?
 - ar/submodule-update                                          10-13          #9

Needs an Ack or Reviewed-by.
 - ns/tmp-objdir                                                12-06          #2

Needs review.
 - ab/only-single-progress-at-once                              11-03          #8
 - ab/make-dependency                                           11-18         #24
 - ab/config-based-hooks-2                                      11-24         #18
 - ab/ambiguous-object-name                                     11-26          #6
 - ab/cat-file                                                  11-29         #10
 - en/keep-cwd                                                  12-01         #11
 - ab/grep-patterntype                                          12-04          #7
 - jt/conditional-config-on-remote-url                          12-04          #2
 - ja/i18n-similar-messages                                     12-05         #10
 - ab/usage-die-message                                         12-06          #4
 - xw/am-empty                                                  12-06          #3

On hold.
 - js/use-builtin-add-i                                         12-01          #2

Undecided
 - js/compat-util-msvc-flex-array                               12-06          #1

Will discard.
 - ms/customizable-ident-expansion                              09-01          #1

Will merge to 'master'.
 + jc/fix-first-object-walk                                     10-29/12-02    #2
 + tw/var-default-branch                                        11-03/12-02    #1
 + jk/strbuf-addftime-seconds-since-epoch                       11-04/12-02    #1
 + js/ci-no-directional-formatting                              11-04/12-02    #1
 + jk/test-bitmap-fix                                           11-05/12-02    #1
 + ab/generate-command-list                                     11-05/12-02   #10
 + jk/jump-merge-with-pathspec                                  11-09/12-02    #1
 + ja/doc-cleanup                                               11-09/12-02   #10
 + cw/protocol-v2-doc-fix                                       11-11/12-02    #1
 + jt/pack-header-lshift-overflow                               11-11/12-02    #1
 + if/redact-packfile-uri                                       11-11/12-02    #2
 + ab/checkout-branch-info-leakfix                              11-18/12-02    #1
 + jk/t5319-midx-corruption-test-deflake                        11-18/12-02    #1
 + js/trace2-avoid-recursive-errors                             11-18/12-02    #1
 + rs/mergesort                                                 11-18/12-02    #1
 + tl/midx-docfix                                               11-18/12-02    #1
 + gc/remote-with-fewer-static-global-variables                 11-18/12-02    #5
 + ah/advice-pull-has-no-preference-between-rebase-and-merge    11-19/12-02    #1
 + hk/ci-checkwhitespace-commentfix                             11-19/12-02    #1
 + jk/fetch-pack-avoid-sigpipe-to-index-pack                    11-19/12-02    #1
 + jk/refs-g11-workaround                                       11-19/12-02    #1
 + hn/create-reflog-simplify                                    11-22/12-02    #1
 + jt/midx-doc-fix                                              11-22/12-02    #1
 + jk/t7006-sigpipe-tests-fix                                   11-22/12-02    #3
 + vd/sparse-sparsity-fix-on-read                               11-24/12-02    #4
 + vd/sparse-reset                                              11-29/12-02    #8
 + po/size-t-for-vs                                             12-01/12-02    #3
 + bc/require-c99                                               12-01/12-02    #1
 + hn/reftable                                                  10-08/12-03   #19
 + ab/mark-leak-free-tests-even-more                            11-01/12-03   #15
 + mp/absorb-submodule-git-dir-upon-deinit                      11-19/12-03    #1
 + em/missing-pager                                             11-24/12-03    #1
 + yn/complete-date-format-options                              11-25/12-03    #1
 + cb/mingw-gmtime-r                                            11-27/12-03    #1
 + cb/add-p-single-key-fix                                      11-28/12-03    #1
 + en/rebase-x-fix                                              11-29/12-03    #1
 + jc/c99-var-decl-in-for-loop                                  12-03/12-03    #1

Will merge to 'next' and then to 'master'.
 - pw/xdiff-classify-record-in-histogram                        12-04          #6

Will merge to 'next'.
 - es/pretty-describe-more                                      11-01          #3
 - rj/receive-pack-avoid-sigpipe-during-status-reporting        11-10          #1
 - ab/ci-updates                                                11-23          #5
 - ab/run-command                                               11-25          #9
 - ds/trace2-regions-in-tests                                   11-29          #2
 - hn/t1404-df-limitation-is-ref-files-only                     11-29          #1
 - fs/test-prereq                                               12-01          #3
 - en/zdiff3                                                    12-01          #2
 - hn/allow-bogus-oid-in-ref-tests                              12-02          #8
 - hn/reflog-tests                                              12-02          #5
 - es/doc-stdout-vs-stderr                                      12-04          #1
 - tb/pack-revindex-on-disk-cleanup                             12-04          #1
 - en/rebase-x-wo-git-dir-env                                   12-04          #1
 - es/worktree-chatty-to-stderr                                 12-04          #2
 - js/test-initial-branch-override-cleanup                      12-05          #1
 - ds/sparse-deep-pattern-checkout-fix                          12-06          #2
 - ab/die-with-bug                                              12-06          #2

Will merge to 'next'?
 - re/color-default-reset                                       10-28          #3
 - ew/test-wo-fsync                                             10-29          #1
 - ab/parse-options-cleanup                                     11-10          #1
 - fs/ssh-signing-other-keytypes                                11-19          #2
 - jc/reflog-iterator-callback-doc                              11-28          #1
 - jk/log-decorate-opts-with-implicit-decorate                  12-01          #2
 - ak/protect-any-current-branch                                12-01          #8
 - fs/ssh-signing-key-lifetime                                  12-01          #7
 - en/name-rev-shorter-output                                   12-04          #1
 - js/scalar                                                    12-04         #15
 - jl/subtree-check-parents-argument-passing-fix                12-05          #1
 - jc/grep-patterntype-default-doc                              12-05          #1
 - ld/sparse-diff-blame                                         12-06          #8
