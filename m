Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDFC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 07:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiAZHDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:03:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58706 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiAZHD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 02:03:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15A6518518D;
        Wed, 26 Jan 2022 02:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BH1YcY+BqQ9uKDR3kHeRDiysTh06s4djVUEAWZ+HpkU=; b=noHP
        OxjpNhIw26MQPFFwH2S8dM2MNozW4gMjtPuxJSIIbNFeyV1aROVdYDN+iB8QS+yP
        dILYbaSmA8xm1fSywxGX21hAhFFACzN7jdngK9sWK7R5Y3tIrPH/f7ywoAdtLeSb
        5LJQTotVrOOqitgoajlATFOLdDb19MwxbVEWN6c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DB0718518C;
        Wed, 26 Jan 2022 02:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6A81518518B;
        Wed, 26 Jan 2022 02:03:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] docs(diff): lose incorrect claim about `diff-files
 --diff-filter=A`
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <704bb2ba18ee3af5857064f6fd61689f98da0480.1643149759.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 23:03:25 -0800
Message-ID: <xmqqczkft1vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EFF873C-7E76-11EC-9194-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Originally, before we had `--intent-to-add`, there was no way that `git
> diff-files` could see added files: if a file did not exist in the index,
> `git diff-files` would not show it because it looks only at worktree
> files when there is an index entry at the same path.

Good find.  Looks good.
