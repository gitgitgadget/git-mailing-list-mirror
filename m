Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840A71F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfIBRfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:35:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfIBRfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:35:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 462B773560;
        Mon,  2 Sep 2019 13:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gRKeKPpv3oZY0Z3X7w+9Qa+cOOc=; b=rJxchS
        BeEovEYlYtHk+/1/OfB6+XzJABPMJwKEuAIjIYULu7pOFlgZgUcMxkzdZsNJBMNQ
        v46F3fVP/uTHVt2d3TqhXEsZja84hWP4U5OIz+Lb/qEPVsudk2Pb2cCjq+suH+W1
        FPWZd/OGIoECkmX8H8wMqNmRaq3LggDHoU9aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DCD5U9Syu4lrYpPqvren26k9C4A6Rypv
        kmW7E/026j1bm1Six7EOXuO43QRL+Fop6JI5HTSeBNeTfkTSxzdHAuQFP+xD5vL4
        cJjzHLevNcaIOEACX/tLRCdxh1+XCauLZegOg+Js0Gp4APZULbFPhaV/azTfgSuL
        sRVm2Tg39Cw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DF127355F;
        Mon,  2 Sep 2019 13:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DE637355C;
        Mon,  2 Sep 2019 13:35:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
        <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
Date:   Mon, 02 Sep 2019 10:35:40 -0700
In-Reply-To: <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
        (Bert Wesarg's message of "Mon, 2 Sep 2019 14:05:55 +0200")
Message-ID: <xmqqa7bmvbwz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 164F3C0C-CDA8-11E9-B523-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> the old reasoning was, that you should not create commit messages
> which are too wide.

True, and that reasoning would justify hiding scrollbar when not
necessary to gain vertical space.  Can we arrange the scrollbar to
appear only when needed?
