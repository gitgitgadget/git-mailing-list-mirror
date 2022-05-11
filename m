Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC2FC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 10:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiEKKCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiEKKBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 06:01:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387F369E6
        for <git@vger.kernel.org>; Wed, 11 May 2022 03:01:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B54E10ADA8;
        Wed, 11 May 2022 06:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qoQ8PEEZxDqw+nsfkZMz1heKGHj6sAhrq38GQve0zm0=; b=fUrN
        ODngNbM4qByfI7OT59XxW89EJl3Mld8ectGtl8PFocU3orPzBEPJWezIiIpM/sMQ
        bqx2D6vaUQxEmVmi/t56J21iqU9/z46EX7Oech9ZaU8YGtp9mUZQfnNPvhKNrmdv
        PZfzHMe+YbTsWH1d4StCnkDuOgp9dLpi+wwtD5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9329110ADA6;
        Wed, 11 May 2022 06:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00AD410ADA4;
        Wed, 11 May 2022 06:01:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/5] MyFirstContribution: add standalone section on
 cover letter
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <9552d80a80d9574c8f256696fad06f48b39b51c9.1652233654.git.gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 03:01:24 -0700
Message-ID: <xmqqa6boo0az.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51E545E4-D111-11EC-AF9D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +The body of the cover letter is used to give additional context to reviewers.
> +Be sure to explain anything your patches don't make clear on their own, but
> +remember that since the cover letter is not recorded in the commit history,
> +anything that might be useful to future readers of the repository's history
> +should be in your commit messages, not in your cover letter.

I agree with only a half of the last sentence.

Things that are useful for "git log" readers should be in the commit
message (but that goes without saying---by definition "git log"
readers are reading commit messages).  If that material helps to
understand the overall topic structure by the reviewers, it is not
wrong to have that _also_ in your cover letter.  IOW, I sense that
"not in your cover letter" is a bit too strong.

Other than that, I found that 1/5 and 2/5 are very nicely written.

Thanks.

