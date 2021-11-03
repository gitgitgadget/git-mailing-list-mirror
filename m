Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C8C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C94C6115B
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKCRbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:31:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61385 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhKCRa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:30:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBC92F3C34;
        Wed,  3 Nov 2021 13:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9zn0Y69FYEoq999luggQOmWnB8EhUCmr0232Xf
        hLT/c=; b=R3YVa4O9+q/2mFZ3ugUGvXbU5Ie6+Jge6uy0dkzyTXrOB1NxARxCya
        zxS5uW9EKXF1IHACfvObRfQjOUp+rfg14+HiWMW3k86oV+Bix7zZDDYPB3okrFkx
        7nTXZyjQXTiTFUAcK8Hvdg/qp03PzIATRwyM7p6B6Edz61h5i4a+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3CC1F3C33;
        Wed,  3 Nov 2021 13:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EF45F3C32;
        Wed,  3 Nov 2021 13:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 1/2] prompt.c: split up the password and non-password
 handling
References: <20190524062724.GC25694@sigill.intra.peff.net>
        <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
        <patch-1.2-ce5bea43f03-20211102T155046Z-avarab@gmail.com>
        <YYJ4HYyl1tBs2cZN@coredump.intra.peff.net>
Date:   Wed, 03 Nov 2021 10:28:21 -0700
In-Reply-To: <YYJ4HYyl1tBs2cZN@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 3 Nov 2021 07:53:01 -0400")
Message-ID: <xmqqtugt6te2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71796C3A-3CCB-11EC-AE13-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I dunno. This seems somewhere between churn and making things worse,
> and I don't see what it's buying us at all.

Unfortunately I have to agree with the summary.  Not a material I
want to spend time on this time in the cycle anyway X-<.

Thanks for reading.
