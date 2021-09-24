Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC21C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4C610CB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbhIXT0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:26:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346581AbhIXTZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 15:25:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DAB815350B;
        Fri, 24 Sep 2021 15:24:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DtM5npN/h+dN0Y+82hR/2o+thBrx7HnOtW/ptXZYj6o=; b=PDy+
        pyTTYHVt9/iA/gtGM3HHR9GbEl21g1QnfwCHUlEw76P4grjMiTu7BCw/Ufkx3lpD
        l/uMijmMoxsYDgJnoViuVtPGqwH4loM/KNy71iU7DoBX0jABJwI0SRi1OAciN5mI
        aT3R4kAoD2GbmNhpAV1TNsWyhMmCX/UqEiMZNGI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65C6D15350A;
        Fri, 24 Sep 2021 15:24:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87147153509;
        Fri, 24 Sep 2021 15:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] rebase -i: a couple of small improvements
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
        <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 12:24:12 -0700
Message-ID: <xmqq1r5du68z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 005263EA-1D6D-11EC-AEA5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks for the feedback on V1. I have decided to split this series so I'm
> just posting a re-roll of the first two patches here. The only change is to
> reword the commit message of the first patch as suggested by Eric and Dscho

OK.  Prioritizing the fix and leaving the add-on part that is not
yet solid for later makes perfect sense.

