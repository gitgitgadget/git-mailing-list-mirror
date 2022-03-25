Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B8CC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 23:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiCYXK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCYXK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 19:10:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073E40915
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 16:09:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B766B193158;
        Fri, 25 Mar 2022 19:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=89RR5r29ll4LBfY/6NJj5JijvFq2cfv3MGyF5A
        L4wLo=; b=sk1ZYqRms45yduW+vpAlqwwZaJ3u02jf+d2qnFcuiyW80mVl3Z015M
        YsTAx0NKX0Zlxn/O1LMiZb5MJ/GmjopIexn1lOoeGcmzClSwi6fjWUaAWGxajWVx
        U9yuLKXntCxRPn6irW3EkP5074UVkvN1dhwDdBdDNqYEgApfaRLDE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF5D7193157;
        Fri, 25 Mar 2022 19:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2396B193156;
        Fri, 25 Mar 2022 19:09:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 2
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 16:09:17 -0700
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Fri, 25 Mar 2022 18:02:43
        +0000")
Message-ID: <xmqqpmm98w9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98DE4900-AC90-11EC-9FC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is V9 of Part 2 of my builtin FSMonitor series. This version addresses
> bash style issues in t7527 raised on V8. These changes do not require a new
> version of Part 3.

This addresses all the "oops" fix-ups from part 2.5, and good base
to build part 3 on top, right?

Queued.

Thanks.
