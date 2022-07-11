Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102DC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGKWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGKWqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:46:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E591DA5B
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:46:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2E0C1A0DB8;
        Mon, 11 Jul 2022 18:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0I0yHSexGuQ9ptIW12qRry9Iku8/fpCR49wwX
        mBeKk=; b=TRV30ww0a4YeybNMJ1xQ4MbxnwskaguyhuOLtk8LzjYNwh8vm006Fj
        IZkwEq8+HP2NBJmVdSRQPKcvkyG9vP0ln7AEUr3OtLEZJZ9TP6CeIoKbpS+UZFhr
        BCV90777bJbP3eO0ErIkRW/fh1XP02VkW4aqbzjTL4CqdoZbTH4xY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BD1C1A0DB7;
        Mon, 11 Jul 2022 18:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E2591A0DB6;
        Mon, 11 Jul 2022 18:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
        <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
        <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
        <YsymlrUviwwoKHZX@tapette.crustytoothpaste.net>
Date:   Mon, 11 Jul 2022 15:46:36 -0700
In-Reply-To: <YsymlrUviwwoKHZX@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jul 2022 22:39:18 +0000")
Message-ID: <xmqqh73nl12r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 525D9190-016B-11ED-9473-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Now, we could well pick one that's longer than 80 characters.  132 is a
> common terminal size and it would avoid needing to rewrap all of those
> lines.  But sticking with 80 columns is also fine, and we'll just need
> to send some patches accordingly.

As long as people do not start sending an overly wide code that
consistently are 130 columns wide, I am fine.

Let's not encourage people to use automation as excuses for sending
unreadable mess and (worse yet) push back reviewer comments when
such issues that cannot be corrected with automation are pointed
out.

Thanks.

