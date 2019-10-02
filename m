Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB441F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfJBGGR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:06:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59762 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJBGGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:06:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3BD28299F;
        Wed,  2 Oct 2019 02:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDLox89bLAP4wjC5ePAJkJ3KCw8=; b=PAiLQ4
        b/DEbsPHFgC6i3cRzAfmeQ43dw5OEaDfrBJ6LPfrh4uQOvs0gFBuEQXKnz4MpFil
        CM7xbu+o0kfju3W2pXVu7Jp20wbO+MRTLQp2YyIT7+U5Kx647e2n3u4D8ZoakhhL
        HmGBjgCTe4LeswN3KDEZGOYnvaBWGfIc4JPds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PHB7zdgg+nAIhUUAmUQGjhyALz7pWyaR
        Sf+V8JjgY+vJciMRR1xCIGcLOWwRt00cqmOVLVQhnAbgx2oADFB3dFBlC6DjSRgR
        RqqxFCdla5IMdJED2ekK5duUm7aUEAaiS9vM4JOf1ulAkbaOyKJJlJyhXhbjjzZT
        tVv3coDDoCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB3F58299E;
        Wed,  2 Oct 2019 02:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 250ED8299A;
        Wed,  2 Oct 2019 02:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, cb@hashpling.org,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] wrapper: use a loop instead of repetitive statements
References: <20191001022936.1757141-1-alexhenrie24@gmail.com>
        <20191001022936.1757141-3-alexhenrie24@gmail.com>
Date:   Wed, 02 Oct 2019 15:06:10 +0900
In-Reply-To: <20191001022936.1757141-3-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Mon, 30 Sep 2019 20:29:36 -0600")
Message-ID: <xmqqbluzfzql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD508440-E4DA-11E9-98C5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All three patches looked sensible.

Even though there is no dependency or relationships among them
(beyond that they got written at the same time by the same person),
I'll just queue them on a single ah/cleanups topic and get them
advance together, as I do not expect any one of them to be blocking
the other two.

THanks.
