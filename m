Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63520C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201B122CAF
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbhALG2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:28:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733038AbhALG2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 01:28:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10DBC126337;
        Tue, 12 Jan 2021 01:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kS0NtW4V9DPC8afkCEc/GfAMXcE=; b=C4mgR1
        3cGaDmUIaB5VtS8y6l+a5tmHFOmZA7zWc6yr0e0WiYSkxE6k7wwH0ZruMwEW/cxD
        cX5ixlcL3Q2aqqedn2fMPw98W2Bgp2G/vgr9oy5hRAcqfOT9mszulikmiai4VLKW
        G8tjqYkeDUxVs1qa+2fwFKEY9eb2WL801hqSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KjGR7c0NkkJcIwZqCk+mlJ1QsIELiBgo
        bVcsHVRNnn5IBWuSK1PVZ2W2+GC/XekpJf9bpSr0k6iq1lFcx0CvvlYKtZAwI9wQ
        m6lqdXZY2cjzj3qECqiB0f3no4sG3vyho3JcnJKACcwSfNH94d7QO3qfiu0KQo5Q
        3vUvu5ZGYxA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AA5A126336;
        Tue, 12 Jan 2021 01:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85164126333;
        Tue, 12 Jan 2021 01:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v3] fixup! refs: allow @{n} to work with n-sized reflog
References: <X/tkFuESnia/n35e@ruderich.org>
        <d51c9ccca7c58524d5c735c596c142583029a36c.1610432037.git.liu.denton@gmail.com>
        <X/0/Jo3NYlKG3hxE@generichostname>
Date:   Mon, 11 Jan 2021 22:27:59 -0800
In-Reply-To: <X/0/Jo3NYlKG3hxE@generichostname> (Denton Liu's message of "Mon,
        11 Jan 2021 22:18:14 -0800")
Message-ID: <xmqq35z6655c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51E7C926-549F-11EB-A565-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Please disregard, I see that the fixup has already been included.

Being careful never hurts; it may make duplicated work from time to
time, but that is better than fixes falling thru the cracks.

Thanks.
