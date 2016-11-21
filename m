Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6B41FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 17:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbcKURbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 12:31:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753535AbcKURbP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 12:31:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3C9F4F936;
        Mon, 21 Nov 2016 12:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MUn80EFBAlqhWs2vstCCtygJV4=; b=sx0EF0
        Uj/TE90E2wqAVwIw+PN+YsNi3JXKr7npdk2Ivd2XMfkHfvDELDE1r7ukKhtqSgjy
        Mk6e5kVZ/4VJEZhUpekkS3zBGxImx6Z+4JJ7rWdfhy4EGVqOdyaaJmw0mTYwh4zK
        T9z5JqKQxobJdBUo66Bqzp57opQIagQgYuY9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v0fcqIz4MOhBqZvJb0lLe2rO9LJSIKMy
        s/2LUFiu6MwOKQkQk1fUv0nUGnZVSUtdwgeuUGDDuAeRL++3ulNfu+JMfpNQBMSy
        5KcHrF45eqZDhURTgt7x0ifVJ93piV7vIxPfWaUZccfN4paEujQNcV8ImdBJZphO
        UmNpZlyAlC4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB68C4F934;
        Mon, 21 Nov 2016 12:31:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37A594F932;
        Mon, 21 Nov 2016 12:31:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: Fixed unmatched single quote in error message
References: <721cdca4d000627fa163da15c515a50fd9529a62.1479644251.git.worldhello.net@gmail.com>
        <alpine.DEB.2.20.1611211522280.3746@virtualbox>
Date:   Mon, 21 Nov 2016 09:31:12 -0800
In-Reply-To: <alpine.DEB.2.20.1611211522280.3746@virtualbox> (Johannes
        Schindelin's message of "Mon, 21 Nov 2016 15:22:40 +0100 (CET)")
Message-ID: <xmqqshqkkae7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D318D50-B010-11E6-83AD-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 20 Nov 2016, Jiang Xin wrote:
>
>> Fixed unmatched single quote introduced by commit:
>> 
>>  * f56fffef9a sequencer: teach write_message() to append an optional LF
>> 
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> ACK!
>
> Thank you,
> Dscho

Thanks, both.
