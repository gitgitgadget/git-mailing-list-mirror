Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F75C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGAVqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGAVqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:46:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3336F34E
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:46:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B859138456;
        Fri,  1 Jul 2022 17:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nDp9VZ1SHXm2aB3DoOY54f7Cqgza07EP9rLqUg
        HKi9E=; b=f+QLXc4TVEqXqHVVavTDCRETQMGWfUWxj4Yrkt/4+DqGUBSsu9WEC+
        3DmuHCdy1H1cgmrUhjiamlCdY0fi4V6dMX+coYPRca0LIc1gJXucSt4Fk+OCKpAm
        A83bsyNYGTmQE4BK5X+TtVECEffwm8LJPF0eN+DfJ26QL2Dk4TeKE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 024BD138455;
        Fri,  1 Jul 2022 17:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67EC4138453;
        Fri,  1 Jul 2022 17:46:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v5] ls-files: update test style
References: <pull.1269.v4.git.1656568797328.gitgitgadget@gmail.com>
        <pull.1269.v5.git.1656673435357.gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 14:46:31 -0700
In-Reply-To: <pull.1269.v5.git.1656673435357.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Fri, 01 Jul 2022 11:03:55
        +0000")
Message-ID: <xmqqbku87bgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 458D2B4C-F987-11EC-B932-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Li Linchao <lilinchao@oschina.cn>
>
> Update test style in t/t30[*].sh for uniformity, that's to
> keep test title the same line with helper function itself,
> and fix some indentions.
>
> Add a new section "recommended style" in t/README to
> encourage people to use more modern style in test.
>
> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---
>     ls-files: update test style
>     
>     Update test style in t/t30[*].sh for uniformity, that's to keep test
>     title the same line with helper function itself.
>     
>     And update t/README to describe this test style.
>     
>     Signed-off-by: Li Linchao lilinchao@oschina.cn
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1269
>
> Range-diff vs v4:
>
>  1:  d0ee9836f23 ! 1:  6cbb4e5fd49 ls-files: update test style
>      @@ t/README: This test harness library does the following things:
>       +      test_cmp expect actual
>       +  '
>       +
>      ++ - Quote or escape the EOF at the head of a here document when
>      ++   there is no variable interpolation in it:
>      ++
>      ++  cmd <<-"EOF"
>      ++  literal here-doc text
>      ++  EOF
>      ++
>      ++  Or:
>      ++
>      ++  cmd <<-\EOF
>      ++  literal here-doc text
>      ++  EOF
>      ++

I do not htink we need to describe two ways to quote at all.  If we
absolutely need to have two examples, then:

+  cmd <<-\EOF
+  literal here-doc text
+  EOF
+
+  but not:
+
+  cmd <<-EOF
+  literal here-doc text
+  EOF

but I'd say the lines are better spent to explain what we have this
particular style guide item for.

        - Quote or escape the EOF delimiter that begins a here-document if
          there is no parameter and other expansion in it, to signal readers
          that they can skim it more casually:

          cmd <<-\EOF
          literal here-document text without any expansion
          EOF

or something.

Other than that, this looks really good.

Thanks.
