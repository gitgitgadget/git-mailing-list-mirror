Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A0C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiA0UEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:04:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62010 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbiA0UEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:04:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A353F17554C;
        Thu, 27 Jan 2022 15:04:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LDCiHEQk4Z3QXseRQCqBEMdu3oKh7mDPTklZEy
        tdd1A=; b=rRBxTOfCeoRJ3kqNZhNdmZRXJmkoY9YuXIjVvWbir17tc4o3NyQ3gx
        cbmg5oa1OLrC08oAXB7rZy7tlSwQPVRGDZY5ydjpHDOHyLDv0Jf3lmtYLf4Y6LDB
        CUoOpFQymcvh3/SyPWNE9YFtsN0ylUZm6kMvl3zSjcKQnhXs+cewA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B35517554B;
        Thu, 27 Jan 2022 15:04:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1178917554A;
        Thu, 27 Jan 2022 15:04:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/9] Sparse index: integrate with 'clean',
 'checkout-index', 'update-index'
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
        <CABPp-BEVM-nhTX+DRf3NN16G-5Wr2KzObCiETqcy+ZYJLR4EWQ@mail.gmail.com>
        <771fa224-4319-c827-d28d-51e767b0050e@gmail.com>
Date:   Thu, 27 Jan 2022 12:04:08 -0800
In-Reply-To: <771fa224-4319-c827-d28d-51e767b0050e@gmail.com> (Derrick
        Stolee's message of "Thu, 27 Jan 2022 11:36:03 -0500")
Message-ID: <xmqqilu50wuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A64D3C2-7FAC-11EC-B035-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> this version is ready to go.

Thanks, all.  I marked the topic as "Will merge to 'next'" in the
draft of "What's cooking" report.

