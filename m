Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE951F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 04:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKOEfz (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 23:35:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60995 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOEfz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 23:35:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EFED8F1F5;
        Thu, 14 Nov 2019 23:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uXC7VDDkff7+wVzvP0fHg2/Ai0o=; b=rVwfvx
        mnVXEOCcMB0cWBSeSMNVizdjhCEe4+WoBs6XHXqwSJAB49qimW4HZCCPrIWhep1j
        LywOYio1+A5BZ2lm9JYYe/1lfZZDJmpHGgzxqd1cBZbdGIuaZtrMRnZCFOvaV0cc
        LnjW3g1mTExhqk/YtTNsrgw8DHUkZnIkw+2eo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=luUBvNNV3L3u+QfijUkFAc0M1BQ7iW41
        t/v4vbDCF98WyaWUnApxLSstPoIS5+uxKnQ2DewzxaZvjH6GBwjY+MyXfgmvGVRe
        ArILQV/PvPL5XRe8EFWFQ9WE+jwZEhyU8vebzzuTQJ5+jmmpYwITkeSk3y3hkgfn
        bVIl8PpluoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A4578F1F4;
        Thu, 14 Nov 2019 23:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 786E38F1F3;
        Thu, 14 Nov 2019 23:35:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <5d9962d4344fa182b37cd8d969da01bc603414be.1573648866.git.gitgitgadget@gmail.com>
        <xmqqimnn9p9p.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911141602350.46@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Nov 2019 13:35:48 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911141602350.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 14 Nov 2019 16:07:28 +0100 (CET)")
Message-ID: <xmqqpnht92or.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66BC72AC-0761-11EA-91C3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I plan on waiting for the PR build to finish, and maybe wait until
> tomorrow just in case any further suggestion rolls in, then submit the
> hopefully final iteration.

Thanks.
