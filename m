Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6ACC4332F
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbiCNUky (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbiCNUkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1783B3CA
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:39:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F40B127F85;
        Mon, 14 Mar 2022 16:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SNgysa8wUS98ag9Oxvusa63f0EZ+xW8GD15e2
        zJO3g=; b=V3MXkwM14Amm0CjxRMOuzbC/hcNP2v/YzhgIWm2kX8WhmE2jcABjWt
        cQW7IhwzQjuYZP8xqPxqQnvgvDq6DEgDjiDh+kWUFz3nNCgTXA2h7cJshLsLJXYS
        l42PF1l9BNGIE2WG3Uyj/BVNpHv4B/wCfse9+C7rLPEAVFIgJWuhY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76C57127F84;
        Mon, 14 Mar 2022 16:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E114A127F83;
        Mon, 14 Mar 2022 16:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/9] git-sparse-checkout.txt: wording updates for the
 cone mode default
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <8eab21996c7984a31cb954dd787ee54ce77dfa69.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:39:21 +0000
In-Reply-To: <8eab21996c7984a31cb954dd787ee54ce77dfa69.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:15 +0000")
Message-ID: <xmqq4k40qneu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4C1A56A-A3D6-11EC-9065-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Now that cone mode is the default, we'd like to focus on the arguments
> to set/add being directories rather than patterns, and it probably makes
> sense to provide an earlier heads up that files from leading directories
> get included as well.

Looking good.
