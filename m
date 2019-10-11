Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FC21F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 05:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfJKFf6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:35:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55442 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:35:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 027C99A35D;
        Fri, 11 Oct 2019 01:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r0CgYlnpf6szaTN9zezL6w4cAAI=; b=Nj07EC
        ebs7I+9HtQLZaP1Cwf8DJUwwJ0iaU8xEvTWkx0jBAfPhziZibHMg3ocvkK8zjn6k
        W1pdv0OI+ZGmXXJyH6pYlB7eJYglKb+GjyqaVA8MVNjdZmXtJ3m97Z4BMNvWiqrn
        JSOTIS8RlSIx7w+Lr48JOQ1n95ekIaBJ6NAQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QQvgaaeWafyqWRV74ksBcxji9t3BBFKG
        7ZM+pdt/vSwVr9CIqGmZs8EmeJ6VkCswmdxMnKNFM0XwmPdwu/GnhmC8vjUluwth
        bZzWe3lTwjqvOhcxXB8f3FanRw7WIN1QEY7IHOF4zHrJssHv/tReiCAfPykOtzUr
        XKNMhRTdF5g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFF029A35C;
        Fri, 11 Oct 2019 01:35:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 281749A35B;
        Fri, 11 Oct 2019 01:35:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tanay Abhra via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 1/1] t1308-config-set: fix a test that has a typo
References: <pull.387.git.gitgitgadget@gmail.com>
        <7b88e36723e3e6d51118d62211f487b497c532cc.1570710932.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102247570.46@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Oct 2019 14:35:50 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910102247570.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Oct 2019 22:48:52 +0200 (CEST)")
Message-ID: <xmqqv9svhmix.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDA40246-EBE8-11E9-8F26-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I should note that I looked through all of the hits of `git grep -w
> except -- t/` and did not find any other typo.

Thanks.
