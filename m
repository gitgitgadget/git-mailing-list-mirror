Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB6C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiFMToz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiFMTon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:44:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999B814A4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:15:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A6B0133645;
        Mon, 13 Jun 2022 14:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jh2+F3AsxRcnUqJv8tW2w08l829LwWxcmAubw2
        fbco4=; b=d9tX3skGTdsODNR24hHafLe8PyfUgE4X1CfpDp7liqT4x2WG9fz/Ab
        s2UartXP66AfBNs48tOYU6jV7s/iBKIvnJisYMu54TS/MKom9eD9JY9QjpocQBOt
        r8Cy/lU6VNVcqFgWXSICCXxjWXwu/9vt4k1Yz9e4h8Svdp/ZtfeDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60281133644;
        Mon, 13 Jun 2022 14:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA27813363F;
        Mon, 13 Jun 2022 14:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/3] Fix a few documentation errors around the raw diff
 output
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 11:15:42 -0700
In-Reply-To: <pull.1259.git.1655123383.gitgitgadget@gmail.com> (Philippe Blain
        via GitGitGadget's message of "Mon, 13 Jun 2022 12:29:40 +0000")
Message-ID: <xmqqfsk877ld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E30ED2-EB44-11EC-8130-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here are a few doc fixes for some things that I noticed out while reading
> the man pages for 'git diff-files' and 'git diff-index'. These are quite
> old!

Indeed ;-)

>
> Philippe Blain (3):
>   diff-format.txt: fix ancient copy-paste error
>   diff-format.txt: correct misleading wording
>   diff-index.txt: update raw output format in examples
>
>  Documentation/diff-format.txt    | 6 +++---
>  Documentation/git-diff-index.txt | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
>
> base-commit: 5699ec1b0aec51b9e9ba5a2785f65970c5a95d84
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1259%2Fphil-blain%2Fdiff-files-doc-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1259/phil-blain/diff-files-doc-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1259
