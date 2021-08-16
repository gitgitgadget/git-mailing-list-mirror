Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4085EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAC460F36
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhHPUtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:49:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61467 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhHPUtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:49:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF21FF53DF;
        Mon, 16 Aug 2021 16:48:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lVHhqqu8s5BeUosjzl0AhTn4dOoOvokcmX+MGK
        z1i20=; b=hCga3YkwoKkadbkMu36c4ilAIfu485tlMkrbbt03oKRMBTaKdzQBZ3
        bzLvtVluJc7XIenj7xPd3KzLnux6wOuPTwgY+2ZVcYnzfmLFWpRHJ6ZXT72+AjIP
        CRqph9J9M+08r0kZOD3sn+XOwPNFj8uMBrnDpFzHLhPJ86OWu2XZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E79CBF53DE;
        Mon, 16 Aug 2021 16:48:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72FF3F53DD;
        Mon, 16 Aug 2021 16:48:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/25] Support reftable ref backend for Git
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 13:48:58 -0700
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 16 Aug 2021 20:16:51
        +0000")
Message-ID: <xmqqr1etqfnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61A7E01A-FED3-11EB-9436-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This continues the work in https://github.com/git/git/pull/847, which the
> gitgitgadget erroneously closed.

> Changes relative to last series (version 20 Jul 2021, tip: 4a5891f )
>
>  * fix HTTP serving
>  * fix t1501 (use absolute paths.)
>  * fix git-new-workdir
>  * fixes for FreeBSD (thanks, carenas@gmail.com!)

Thanks, will take a look later after the release is done; nice to
see these fix-up changes already applied in the series.
