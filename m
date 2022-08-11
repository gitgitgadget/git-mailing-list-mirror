Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D7C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 20:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiHKUt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKUtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 16:49:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA498A78
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 13:49:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F71D156256;
        Thu, 11 Aug 2022 16:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7e2uyhNLK4zMXCeq5NAdpn5fK2eF65GgaxjMMl
        tk54g=; b=C38BsSbCThX5C76O3zuXcSBFRlGFNF3YLOdkNxwnQC31eUAIXf6Sa/
        YLuJvBsYkmHEJsG97Qcr6Kw+yKJO7VC7X5p/+WffB3JwdP4wHpZ6sJaEWAffejnW
        AYouPc4MzwqWHUb/lfXuJmqtuCoZzfblO9BYmNIiMS1jaxE9WM4eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 175FD156255;
        Thu, 11 Aug 2022 16:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DE96156254;
        Thu, 11 Aug 2022 16:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v5] rev-list: support human-readable output for
 `--disk-usage`
References: <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
        <pull.1313.v5.git.1660193274336.gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 13:49:52 -0700
In-Reply-To: <pull.1313.v5.git.1660193274336.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Thu, 11 Aug 2022 04:47:54
        +0000")
Message-ID: <xmqqczd6ec9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26945D00-19B7-11ED-8456-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Li Linchao <lilinchao@oschina.cn>
>
> The '--disk-usage' option for git-rev-list was introduced in 16950f8384
> (rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
> This is very useful for people inspect their git repo's objects usage
> infomation, but the resulting number is quit hard for a human to read.
>
> Teach git rev-list to output a human readable result when using
> '--disk-usage'.
>
> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---

Thanks, queued.
