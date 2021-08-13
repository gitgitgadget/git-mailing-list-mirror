Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5367C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1E160EFE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbhHMPcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:32:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52000 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbhHMPcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 11:32:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1E83DD8F4;
        Fri, 13 Aug 2021 11:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FABqL66csRY7GBzbuSREwD9Lao+8rUy3T80/0a
        mZPNQ=; b=UMYbVhGCNVZ4Rz9Nqe0yybprsz+7W9odISzqKguZXO/VnNdyuJIP2K
        vNVlZhUmYLfFCKaiyzhFeEXCe2YxuR2mcqIgLRewy4CMIRIl0I494e050ljQflWX
        HA7YikJSm/0WkhkUNuHhugVeQWBaJ4c4Hg/gK8UzAGgdyVh90W62Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9ED1DD8F3;
        Fri, 13 Aug 2021 11:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29138DD8F2;
        Fri, 13 Aug 2021 11:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] rebase --continue: remove .git/MERGE_MSG
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
        <CABPp-BGHmCCeY7j9hVDGZPuLU8gR-ka3iEzUjK0wvkSUSYdNxA@mail.gmail.com>
Date:   Fri, 13 Aug 2021 08:31:46 -0700
In-Reply-To: <CABPp-BGHmCCeY7j9hVDGZPuLU8gR-ka3iEzUjK0wvkSUSYdNxA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 Aug 2021 17:46:22 -0700")
Message-ID: <xmqqim09xswt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9247BF18-FC4B-11EB-A977-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks, this version looks good to me.

Thanks, both.  Elijah, can I take that as your Reviewed-by?
