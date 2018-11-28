Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4651F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeK1PHh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:07:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56457 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1PHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:07:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B68CD31C28;
        Tue, 27 Nov 2018 23:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vDcDWIw4/KryML3tAAhg/jkIoy4=; b=loBJdZ
        1iOBAHH6aP8Oju3LBjfTr4qZfYj4xUvFdDf3IQqlpwE8aLOTKJRW4//OxOuadUOm
        gSJKGwxjAv7eO7ckgexF4KOqv2XyEjsjQUbtmNa+hbV8UyDtG8kw9Ae6yiENze9n
        Jay+II6esxHkwa1W7VOZvW+oS7oKX1gpqv9bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fpw4EeFaZGHODdDvYIBa9OYXVlRRZuwT
        gsuPUJG4hNa3RXrYZS9+MWeVIE1QfvqZK1xmHwWC5Rl1bxQJJtV/PuyUjsMliVvG
        FiJcG8OeIqqYZvEyyH9vZRYPr5pfJV3qpQBrRgJhKNwu9rWyWeqUvQXgw4lshu67
        tb5zXclqnEA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFAD931C27;
        Tue, 27 Nov 2018 23:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7A6231C25;
        Tue, 27 Nov 2018 23:07:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811262347360.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1811270008580.41@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Nov 2018 13:07:20 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811270008580.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 27 Nov 2018 00:47:24 +0100 (STD)")
Message-ID: <xmqq5zwhu9on.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B79C4EC-F2C3-11E8-AB31-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> In short, even a thorough study of the code (keeping in mind the few
> tidbits of information provided by you) leaves me really wondering which
> code you run, because it sure does not look like current `master` to me.
>
> And if it is not `master`, then I have to ask why you keep suggesting to
> turn off the built-in rebase by default in `master`.
>
> Ciao,
> Johannes
>
> P.S.: Maybe you have a hook you forgot to mention?

Any response?  Or can I retract jc/postpone-rebase-in-c that was
prepared as a reaction to this?
