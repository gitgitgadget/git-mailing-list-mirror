Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1496CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbjJLRqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344213AbjJLRqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:46:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86BBB
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:46:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F42C1BF111;
        Thu, 12 Oct 2023 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=SAGLMCvXskYYLe2CGaHAPANm00EtJ2pMArCDUv
        vhB/8=; b=W2ow0sbiSC/fNlHVtpasV68yIjAcKtZ96jvQoDJeIPCVbnB0sHi7Y7
        /DgT7Zw9SPcxmEsm3jP8uh18GRZsqwNca4X+xxmVMKE4YO6zZ8HrWGBwHliuh9fP
        6mdOzSYSurhvgn+fQKqa9ySrozJWkiEtmwnE925uw8p9gsfCq+ijA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 972631BF110;
        Thu, 12 Oct 2023 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC0AD1BF10F;
        Thu, 12 Oct 2023 13:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] mailmap: change primary address for Derrick Stolee
In-Reply-To: <pull.1592.git.1697131834003.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 12 Oct 2023 17:30:33
        +0000")
References: <pull.1592.git.1697131834003.gitgitgadget@gmail.com>
Date:   Thu, 12 Oct 2023 10:46:43 -0700
Message-ID: <xmqqy1g7n37g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F3F04D8-6927-11EE-8979-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: removed @github.com address from CC]

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
> -Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
> -Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>
> +Derrick Stolee <stolee@gmail.com> <derrickstolee@github.com>
> +Derrick Stolee <stolee@gmail.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
> +Derrick Stolee <stolee@gmail.com> <dstolee@microsoft.com>

It has been irritating to see @github.com address bouncing.  Will
apply.

Thanks.
