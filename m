Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19496CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIVW36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 18:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVW34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 18:29:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF31AB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 15:29:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 298C41BC75B;
        Fri, 22 Sep 2023 18:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=E9CtWP/UsPkoM2y4LekH6UdCWA0S3a12WBkoYp
        6Wf1s=; b=EMCI9HyDBdLfDPCy8NF0S3/f64m9Q9mqUmgiSpZu+G83tt9p39Ib8D
        mNGeein6+Sgb5iGAR5TIjxfU9D+Nh4rBnJap0QFiDm8m4+yrc9ev3+9Te7gcN5wC
        HNvpkWOt6aKg185Frg8kLee5cAjJp1aFaSOr7VyvjAeksNBfEvNNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 203731BC75A;
        Fri, 22 Sep 2023 18:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85EFC1BC759;
        Fri, 22 Sep 2023 18:29:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH] Documentation/git-status: add missing line breaks
In-Reply-To: <pull.1590.git.1695392082207.gitgitgadget@gmail.com> (Josh Soref
        via GitGitGadget's message of "Fri, 22 Sep 2023 14:14:42 +0000")
References: <pull.1590.git.1695392082207.gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 15:29:45 -0700
Message-ID: <xmqqmsxdyh7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88D51A2E-5997-11EE-9A3F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
> @@ -245,10 +245,12 @@ U           U    unmerged, both modified
>  ....
>  
>  Submodules have more state and instead report
> +
>  		M    the submodule has a different HEAD than
>  		     recorded in the index
>  		m    the submodule has modified content
>  		?    the submodule has untracked files
> +
>  since modified content or untracked files in a submodule cannot be added
>  via `git add` in the superproject to prepare a commit.

Ah, good find.

Thanks, will queue.
