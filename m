Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC2BEB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 23:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGFX2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 19:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGFX2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 19:28:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDBF210A
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 16:28:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D7B196B22;
        Thu,  6 Jul 2023 19:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=oSES5BMdfJKvkqB859MGc/XlIRnYwPDRS6WsLPerNTQ=; b=v2zl
        byEikszjXxthWaVOwTOiG0m/D62BmDACBmIvTBJTO5QhNcsy394buz/cUU5woZUi
        K/IxGhCIGr1Xqz3IyPHe7r7efs9arLY1Kb+SkceGCP+LbtzEGXSbENroCvmOCYhC
        4rf3TNNTqQrj5N7W+XYuSIItac4pEbWUShNnnEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A334196B21;
        Thu,  6 Jul 2023 19:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94C93196B20;
        Thu,  6 Jul 2023 19:28:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #01; Wed, 5)
References: <xmqqedllvohc.fsf@gitster.g>
Date:   Thu, 06 Jul 2023 16:28:19 -0700
Message-ID: <xmqqedlkbox8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB2719B6-1C54-11EE-982B-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Incremental update:

> * jk/imap-send-unused-variable-cleanup (2023-07-05) 3 commits
> * ma/t0091-fixup (2023-07-05) 1 commit
> * ks/ref-filter-signature (2023-06-06) 2 commits

Now in 'next'.

> * jk/cherry-pick-revert-status (2023-06-27) 1 commit
> * gc/config-context (2023-06-28) 11 commits
> * gc/config-partial-submodule-kvi-fix (2023-06-26) 1 commit
> * pw/apply-too-large (2023-06-26) 1 commit
> * jc/doc-hash-object-types (2023-06-28) 1 commit
> * rs/strbuf-expand-step (2023-06-18) 5 commits
> * pb/complete-diff-options (2023-06-26) 24 commits
> * cw/strbuf-cleanup (2023-06-12) 7 commits
> * tl/notes-separator (2023-06-21) 7 commits

Now in 'master'.
