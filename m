Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C84C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 01:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384026AbhLDBlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:41:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55609 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384029AbhLDBk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 20:40:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7530316AE65;
        Fri,  3 Dec 2021 20:37:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        MQ2dakBRIkQtaIbvPOxdL1Grgu/vWG7QCRLZ/l03hs=; b=kfRyKQhnLwME9molS
        kZjrjTVPoSTg+fsePewevIwsv73D2E+RAZmwlHR4vU/tZh2uyg1Iix8FNaKS6ZOv
        VeK1GpIgy/rGDypOBvMWxXi5mik+NS3brrIeI+b7HhG7YU0HD4W6yjQG06jPHaUP
        NYz61rU0/R03czlPU1PbH6jhPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DD8916AE61;
        Fri,  3 Dec 2021 20:37:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78CE216AE5F;
        Fri,  3 Dec 2021 20:37:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
Date:   Fri, 03 Dec 2021 17:37:29 -0800
Message-ID: <xmqqbl1xqheu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEDAAF86-54A2-11EC-B99F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FYI, here is how the topics listed in the report are categorized
(output from the 'cook -w' script I mentioned in the main report).

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----

Expecting a reroll.
 - cf/fetch-set-upstream-while-detached                         07-06          #1
 - jh/builtin-fsmonitor-part2                                   10-21         #29
 - jc/doc-submitting-patches-choice-of-base                     10-25          #2
 - ns/remerge-diff                                              10-27          #9
 - ns/tmp-objdir                                                10-27          #4
 - ns/batched-fsync                                             10-27          #9
 - js/branch-track-inherit                                      11-18          #1
 - es/superproject-aware-submodules                             11-18          #5
 - tl/ls-tree-oid-only                                          11-22          #1
 - tb/cruft-packs                                               11-29         #17
 - cb/save-term-across-editor-invocation                        12-01          #3
 - jl/subtree-check-parents-argument-passing-fix                12-01          #1
 - xw/am-empty                                                  12-01          #3

Expecting a reroll?
 - ar/submodule-update                                          10-13          #9
 - ds/fetch-pull-with-sparse-index                              11-29          #3

Need to pick up a reroll.
 - ab/grep-patterntype                                          11-29          #7
 - jt/conditional-config-on-remote-url                          11-29          #2
 - ld/sparse-diff-blame                                         11-29          #3

Need to pick up the reroll before merging to 'next'.
 - pw/diff-color-moved-fix                                      10-27         #15
 - js/scalar                                                    12-01         #17

Needs review.
 - ab/only-single-progress-at-once                              11-03          #8
 - ab/make-dependency                                           11-18         #24
 - ab/config-based-hooks-2                                      11-24         #18
 - ab/ambiguous-object-name                                     11-26          #6
 - ab/cat-file                                                  11-29         #10
 - en/keep-cwd                                                  12-01         #11

On hold.
 - js/use-builtin-add-i                                         12-01          #2

Will discard.
 - ms/customizable-ident-expansion                              09-01          #1
 - pw/fix-some-issues-in-reset-head                             10-01         #12

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
 + pw/xdiff-classify-record-in-histogram                        11-18/12-02    #3
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

Will merge to 'next'.
 - es/pretty-describe-more                                      11-01          #3
 - rj/receive-pack-avoid-sigpipe-during-status-reporting        11-10          #1
 - ab/ci-updates                                                11-23          #5
 - ab/run-command                                               11-25          #9
 - ds/trace2-regions-in-tests                                   11-29          #2
 - hn/t1404-df-limitation-is-ref-files-only                     11-29          #1
 - jc/grep-patterntype-default-doc                              11-29          #1
 - fs/test-prereq                                               12-01          #3
 - en/zdiff3                                                    12-01          #2
 - hn/allow-bogus-oid-in-ref-tests                              12-02          #8
 - hn/reflog-tests                                              12-02          #5

Will merge to 'next'?
 - re/color-default-reset                                       10-28          #3
 - ew/test-wo-fsync                                             10-29          #1
 - ab/parse-options-cleanup                                     11-10          #1
 - fs/ssh-signing-other-keytypes                                11-19          #2
 - jc/reflog-iterator-callback-doc                              11-28          #1
 - jk/log-decorate-opts-with-implicit-decorate                  12-01          #2
 - ak/protect-any-current-branch                                12-01          #8
 - fs/ssh-signing-key-lifetime                                  12-01          #7
