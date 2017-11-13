Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C33F201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdKMDsB (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:48:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751349AbdKMDr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:47:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E28CCB5B0D;
        Sun, 12 Nov 2017 22:47:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cBHfLtky+4zUPm3TvvuVzDqVJko=; b=SeNCJh
        cmImC8zXa/mgd+MM7qEGOHNZL6WpH29sWo31i/BJuZ2qLkoJHcdvRbZgqGNng4Fi
        Q9e6ZHlgiKAwZtmBWQ5K6kbjUM1Vw4s4k3Y5pYnLjDh1JyQaL+/DP+gF8/lT2Mdj
        EUgSkmqmZcWDJ91Q8d/r1MyyLdc8jSEF0wQPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lJUyNCTXW6YlHbfFrFPp/qnKPDDIq0+t
        rQ5TdJzzU2c80jnKXNpD0msU3G8Tg8Lc68IxU3zqcUluZdv4APAmc8e4E2cZJ3T4
        4S1nqDCK4y0pPSkdtgiEyUv6RxJUZPGiX71NJ7tHZnKnP4fMcmMjildCBsuxVisd
        zMxhYvZcnzc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D85B8B5B0C;
        Sun, 12 Nov 2017 22:47:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55B86B5B0B;
        Sun, 12 Nov 2017 22:47:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
Subject: Re: [PATCH] Make t4201-shortlog.sh test more robust
References: <20171112152523.7186-1-charles@hashpling.org>
        <20171112161132.au26ywjeeipxsor4@sigill.intra.peff.net>
Date:   Mon, 13 Nov 2017 12:47:57 +0900
In-Reply-To: <20171112161132.au26ywjeeipxsor4@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Nov 2017 16:11:32 +0000")
Message-ID: <xmqqr2t2alg2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 706D636A-C825-11E7-9BE1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You're also really doing two things to fix the problem here, either one
> of which would have been sufficient: increasing the abbreviation size
> and using test_tick to get a deterministic run.
> ...
> Doing it once is enough to make the test deterministic, and for this
> particular case we don't actually care at all whether all of the commits
> have the exact same timestamp. So I think it's fine.

;-)
