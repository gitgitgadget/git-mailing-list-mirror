Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C71C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A4613C2
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFOCox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:44:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63451 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFOCos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:44:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D56D9DEE0C;
        Mon, 14 Jun 2021 21:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AlzW47GtVLEpayEcLCSGDUEpXAns3yTfVXWLm+
        ArT1Y=; b=Exp/XoKK0x/81tkMv+MKdJwUOE9HZ76teskQwunN3DJ3M6/QlQvy9Q
        iXNDykVS4fx+T+H2Jln837Gm4yFclVIO682LdnPF55WBTxclaCa+naJ5dGHE7vB/
        Exc35jW/xX/vfalOI2Js2QBc/Ls4MZ0ozArVrgZHqyIQMhrSdxGnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 834F8DEE0B;
        Mon, 14 Jun 2021 21:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E652DEE0A;
        Mon, 14 Jun 2021 21:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pull: obvious fixes
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
        <CABPp-BFEc2aQV_kTTiDh3WV5oBwr4tOzO6LOGnMAHudZdXVo6Q@mail.gmail.com>
Date:   Tue, 15 Jun 2021 10:25:06 +0900
In-Reply-To: <CABPp-BFEc2aQV_kTTiDh3WV5oBwr4tOzO6LOGnMAHudZdXVo6Q@mail.gmail.com>
        (Elijah Newren's message of "Mon, 14 Jun 2021 07:47:58 -0700")
Message-ID: <xmqqfsxjzzpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84E1BE3E-CD78-11EB-971D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I was really surprised to see the Reviewed-by on patch 1, and did not
> remember what review I had done.  Unfortunately, ...
> from.  I had to go digging to try to find it.  Any chance you could
> tweak your posts in the future to help reviewers follow how things
> have evolved?

Sounds like a sensible request.

Aside from that, I read the three patches and think they are good.
So I'll queue them as-is on 'seen' (unless they crash with something
else, which is always the case without being said, but it is safer
to be explicit) but won't merge it down until the above is resolved.

One way to resolve it is for you to review this round and give a
refreshed Reviewed-by ;-)

Thanks, both.

