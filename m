Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB5C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 21:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiJVVA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 17:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJVVAy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 17:00:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB3BDF63
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 14:00:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 559B91BBE81;
        Sat, 22 Oct 2022 17:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SI6kbDPu5e+85F/PXz9rFsWqmM8gX5tGMSO3fY
        cl7uM=; b=PZpdTcidTqtdXFSTLjEBhaRfr//3S4gw9m5/JoENZ6hVUKcWkuEu/2
        QoZl0fqeYhMLRkgGygTL3nM2b9CVJPhpCyiagduC6AxBq50memhULztpkV9M8N4r
        Lr5knYhwN4s6MY9QQtYOeZql6uU1itUAnFRN+pi9skS/FlQv++wWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D10B1BBE80;
        Sat, 22 Oct 2022 17:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B2251BBE7F;
        Sat, 22 Oct 2022 17:00:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
        <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
        <xmqqilkbhhlw.fsf@gitster.g>
        <Y1RRrK4/2vr/YPfz@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 14:00:47 -0700
In-Reply-To: <Y1RRrK4/2vr/YPfz@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 22 Oct 2022 16:25:16 -0400")
Message-ID: <xmqq7d0rh8u8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AB9AB22-524C-11ED-A875-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I admit I don't care much either way, though.

Me neither.  If the patch were to make --default=m mean "one mega unit"
instead of "zero mega unit", then I may care a bit more, though.
