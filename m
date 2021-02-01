Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC5C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8145864ECB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBAWVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:21:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62421 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBAWU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:20:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F29511F7FD;
        Mon,  1 Feb 2021 17:20:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+NfYj0qy/IkyJmfTsHFyQ+Q/T8=; b=Ul3Tcr
        uFr321ocMFAt9fcoZw3urN4kTii4+8S87+c0oZ2MvYOkxnrxQsguAn9NtfuZfOS/
        S4U8+ABOYDR1s4JBxynwWf10CSbH7pA1vIP2wyenjpIGgsDQOVcggtaH8CWBNb7d
        Kpldu+cTeekCEd54hbwBje4V2Onik/AxK0L0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XfRm1Gd3hMdvNzpcOifHGsjWph7627lp
        LwoYi/0Yz2Tgw9IV8r5Y9VRfTRRr692L1e+KXze5NsvdWBSZYTeA8wlA6+uVk15G
        fb3WuwuCjyfg3NYvCFasLHL4Qqy7rwPFIvhirWlbDZhOfZBCvcSBp6dhXaNJQ2Bg
        ZpYTxGoFHWA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55B1E11F7FC;
        Mon,  1 Feb 2021 17:20:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E3B911F7FB;
        Mon,  1 Feb 2021 17:20:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/14] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 14:20:11 -0800
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Mon, 01 Feb 2021 19:45:33
        +0000")
Message-ID: <xmqq5z3bjuqs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A78DF430-64DB-11EB-871E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is version 2 of my "Simple IPC" series and addresses the following
> review comments:
> ...
> Junio C Hamano (1):
>   ci/install-depends: attempt to fix "brew cask" stuff

Huh?
