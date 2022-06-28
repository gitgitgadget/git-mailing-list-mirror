Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC80C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiF1VTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiF1VTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:19:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125A2ED5E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:19:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E54B1985BC;
        Tue, 28 Jun 2022 17:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ayzF+BIQWXSzGc2yyTap6v7fyWZu7Mf24GgXDD
        aI9nI=; b=NqDnnUaC2WA+dnETdsyKJgqt2i9XpC/+JZaFumppuiOyS+A8D/BrmN
        6PEpY+TRwYdLmlVHEsZAAFlhSqV1vuGvzPww7BBAyGLZhDeGZkbAmJYGYOSvWgcP
        eTUnGHsDEbmr2+H73dx4dIyzHDmjWH645ZUXU7YZb18m23Z8EXOI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 833EE1985BB;
        Tue, 28 Jun 2022 17:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23A0F1985B7;
        Tue, 28 Jun 2022 17:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/8] rebase: update branches in multi-part topic
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:19:16 -0700
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 28 Jun 2022 13:25:51
        +0000")
Message-ID: <xmqq35foiizv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F79C348E-F727-11EC-83B2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds a new --update-refs option to 'git rebase' (along with a
> rebase.updateRefs config option) that adds 'update-ref' commands into the
> TODO list. This is powered by the commit decoration machinery.

I read through the patches and they made sense to me.  Hopefully I
can push out the integration result including this topic by the end
of the day (today is actually my usual "every other Tuesday gitster
goes offline" day, but I'll go offline tomorrow instead, so I want
to injest as many reasonably-done topics as possible today).

Thanks.
