Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE92C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF14E22DD3
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394283AbhARVHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:07:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53744 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389309AbhARVHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:07:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA2AAA29E5;
        Mon, 18 Jan 2021 16:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G+q/qsmEtdcpD7rFqL6OleYj4mI=; b=YKZkSz
        bbALholJ0mDQmC7jRPprfRxLWnc2N4Nn37cSPZZckyNg/sCMR7TblgRofDwtrIVS
        DNnRAtDn3/tFQKFUfh7NiX9dZxHO6rS4CeQd1rYZelMrOcaskKy+A20kjNd1KanC
        x4qPJcDtqjWedpwmn4rMF+6l4W0mWmdbg4QIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yTkSP9JRsCxqRNSoZwdiNKE8bmgKauHK
        nposkGF9Y1iDoIO5j5oSS7Eh+HinaGP/0hvSW89zyPFYj0wPQL1loVwEj15gVtu6
        WPIf/qQhw+nMXi6l/DkKYw5SWZWvuerTbOeHEm284OirpWGIANEK13Jto2AglZWr
        DnJ3r9i17FA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D21BCA29E3;
        Mon, 18 Jan 2021 16:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 536BBA29E2;
        Mon, 18 Jan 2021 16:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
        <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
        <YAHC9faa4ykNOWj6@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2101181525370.52@tvgsbejvaqbjf.bet>
Date:   Mon, 18 Jan 2021 13:06:30 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101181525370.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 18 Jan 2021 15:26:42 +0100 (CET)")
Message-ID: <xmqqim7uj6p5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09DF4D66-59D1-11EB-B6F5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> That's what I was getting at. The audience is really Git developers,
>> just like it would be for a BUG(). We don't expect either of those
>> things to happen.
>
> While a SHA-1 collision might not be anything we expect to happen, I am
> fairly certain it won't be a bug in Git causing it. Nor will it be
> anything that core Git developers have to react on. For those reasons, I
> disagree that core Git developers are the target audience of this message.

I do not know if this is what Peff meant by "the audience is really
Git developers", but when any end-user encounters this message, we
want to learn about it a lot more urgently than all the ordinary
"there is no such command line option", so in that sense, even it
is not "a bug in git", it is more special than ordinary errors.

