Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72FC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B1C2166E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gaW1t5Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQVVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:21:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64140 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 17:21:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B162C2EFC;
        Wed, 17 Jun 2020 17:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WNl5jmrRxGcpt6WRivuwQzVooIs=; b=gaW1t5
        QiwU6y2bcNe/ui6OcCV81HPvOs/WgBBY/3cpE41TYo09sqSsPAWP1cjnW29aSLQV
        cK2xhdJu6v4P7Nlj9sDOgn5a6iuFenxpFvzGJKcRPpR2H7FdtKL2ZS+J6RDv0N8K
        yMIbSKCDkOmOAUBu5B4nBaujUxw8yRGJsxjT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FQb2ZckjkGt208FyD19opae+S6ig2gMt
        Nf8w+DSoImXL4TIzlyGTLyRWfJMrpL9GwFDCphD8lZua8RhWPBTYChOyUxzsv3fQ
        yOMRanesmhD7TV2U6+aOS5ydMsaYVk58GdjKj5vZWAN3rVkI4+hfiGWRj6VHl3l6
        Zcrfsqy2cY0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02B8DC2EFA;
        Wed, 17 Jun 2020 17:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4290AC2EF9;
        Wed, 17 Jun 2020 17:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/8] More commit-graph/Bloom filter improvements
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 14:21:18 -0700
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Mon, 15 Jun 2020 20:14:45 +0000")
Message-ID: <xmqqimfps81d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CE6D986-B0E0-11EA-ABDD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This builds on sg/commit-graph-cleanups,...

How ready is that topic, do you think?  I'd rather not to see too
many patches piled on top of what is not even in 'next', but I do
not remember it reviewed seriously (I did take a look or two at it
myself before queuing the series, but that does not quite count).

Will queue to extend the topic for now.

Thanks.
