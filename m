Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73045C25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiHHQV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHHQVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:21:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D227BF59
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:21:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 528B913C943;
        Mon,  8 Aug 2022 12:21:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G5ssDma1SDrKQMUATk1zdUZoe0WU58GoxWjzcM
        0Thos=; b=X/5YbKPkbbJvBq9aXsbO1DcKtGCtZy2wlpLv9K/FLejcefmdd/dzXB
        zbEE1zHO9znivt9h8O7ewzOWl4TOZ5wwnrRmJtyOs44Cj79YEpZGfp8YCPUfeSfW
        R0eb8Bo3K65DtwxpecQoARoSB3/AqGnZxmNjmRbprcmMFbzQ7bq+M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49F5B13C942;
        Mon,  8 Aug 2022 12:21:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77F2213C941;
        Mon,  8 Aug 2022 12:21:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
        <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
        <1b90edd0-3d9d-a741-8865-3968826da315@iee.email>
        <xmqq5yj6z5rx.fsf@gitster.g>
        <e454bf85-046d-6205-57e7-4c00b9faa589@iee.email>
Date:   Mon, 08 Aug 2022 09:21:48 -0700
In-Reply-To: <e454bf85-046d-6205-57e7-4c00b9faa589@iee.email> (Philip Oakley's
        message of "Mon, 8 Aug 2022 15:32:35 +0100")
Message-ID: <xmqq5yj2u2n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34840EE8-1736-11ED-AED4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I've unfortunately had some family issue which prevented me doing any work.

I hope everything will be well on your side.

> If I haven't managed anything by the end of the week. I'd be happy if
> others took it forward.

Thanks for letting us know.
