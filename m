Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CCC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 23:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNXcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNXch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 19:32:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496110EA32
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 16:32:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0E2D1C54A9;
        Fri, 14 Oct 2022 19:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3NJ+IZ1FfnKZ7HZKN9WS9H+nxwAh5fbeyklItP
        fwLrE=; b=Mda54YBgCmnXi0zQ89mb/bmM5DkaFZroedxDYpYjdG4iGhAs9G/fTD
        LNlbGOwTc2t+V7ZtvFuDs9DDsBY23r6C0pYJZvkj/7Y/YkIFVq4bFPf152JYe6Jd
        1XlFWFF+SqPwkXFBsS4Vc1IytFJjAZzkLZX/2n0TcuxoSPz05jHc0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99C4F1C54A7;
        Fri, 14 Oct 2022 19:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE03B1C54A6;
        Fri, 14 Oct 2022 19:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 16:32:31 -0700
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Fri, 14 Oct 2022 21:45:32
        +0000")
Message-ID: <xmqqwn9256cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A07B7B4-4C18-11ED-B6C4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.
>
> This patch set builds upon previous work for done for Windows and Mac OS
> (first 6 patches) to implement a fsmonitor back-end for Linux based on the
> Linux inotify API.

Again, the first six patches are a part of what is queued as
ed/fsmonitor-on-networked-macos that is now in 'next' but lacks a
fix-up commit from Jeff King.

I understand that it might not be easy/possible (e.g. perhaps it is
a limitation of GGG?), but I really prefer not to see them re-posted
as part of this series, as I have to apply them and make sure there
are no changes from the last one before discarding them.

Anyway, thanks for an update.  Will requeue.
