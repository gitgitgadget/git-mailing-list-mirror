Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C4C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiCWJEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCWJEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:04:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD942DE8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:03:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B37411CE40;
        Wed, 23 Mar 2022 05:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mw4KZ2vGwee2yc1qcEbgMe9wQgHwgXX7NENJv9qbAKE=; b=RVD1
        m0BtZk/eEM/egamlFpSkjJjpLXbHbhqbDz9hencolR0Wxi+PAvbyQYk8AuFRehKg
        xk4rlH0pDURvC1+6q1OJtQtrUWNhZ+TTNh4JpLaL8Tqbh+q8x8YT8U98Jr9CTGGb
        EQBerFdXaUPZLcjIu+IjpxNz4Hn1nhJaMXF6dRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29AEC11CE3F;
        Wed, 23 Mar 2022 05:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1640111CE3E;
        Wed, 23 Mar 2022 05:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
        <xmqqv8x5s1w3.fsf@gitster.g>
        <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com>
        <CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com>
Date:   Wed, 23 Mar 2022 02:03:05 -0700
Message-ID: <xmqqy211t512.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EBE95A4-AA88-11EC-9BFF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Feb 24, 2022 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> That sounds good. I've got a couple more patches based on top of these
>> which hopefully fix the remaining problems (notably the macos poll()
>> bug). I'll polish and post them next week. Once those are in I hope
>> we'll be able to enable the builtin "add -p" by default.
>
> As this topic just hit master noticed (I apologize for not doing it
> sooner) the macOS problem (tested in 10.15.7) was gone (suspect fixed
> with 1/4) and therefore enabling the builtin by default as proposed
> originally by dscho could proceed without the additional series.

As long as it is a belated success report, nobody would mind.  A
belated failure report would be a cause of sorrow and grief, but
even then, it is better to have it late than never.

Thanks for testing.

