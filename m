Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B653C1F462
	for <e@80x24.org>; Tue, 28 May 2019 16:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfE1QhG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:37:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54712 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1QhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:37:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BDAA6BD19;
        Tue, 28 May 2019 12:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bp9JSMNLX/2cQ1zEHKrOis8RZA8=; b=X/v2+N
        y4bZv4W7tbm5b3vnoG4QmvEdAs6hEoOpk84GsB6iXn7UIE3OdVDThIIN9SEXcbj2
        btWCa7jBcyyT5dQOHImY3NgY6mW7ffFvs0cn9JeC9Afi67qARGjCDYd1wkjRO0Vn
        3xO1X7k4+SceHrg231/esSgx3nOviXIgvqgF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KVO2IGTPvZG6V45BAmNsAURNYXgviz+J
        /MVr366Ht3j2S3gRPGEDmQbaFCFiAmHCyXWCeU68ouHzFuSsyLYJh+p0wqpDEIi6
        qYbe4K0WAzER63byGEu7vGorW3OMpTp6kzBqm4G4EJgU4whKyd/CM3kqfowC2ImJ
        XGbzMmNi2Dc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13D836BD18;
        Tue, 28 May 2019 12:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE61E6BD17;
        Tue, 28 May 2019 12:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        avarab@gmail.com, philipoakley@iee.org
Subject: Re: [PATCH v5] userdiff: add Octave
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
        <20190518034623.87702-1-liboxuan@connect.hku.hk>
        <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org>
Date:   Tue, 28 May 2019 09:37:00 -0700
In-Reply-To: <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org> (Johannes Sixt's
        message of "Mon, 20 May 2019 21:26:01 +0200")
Message-ID: <xmqqpno24jtf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D26E628E-8166-11E9-8CAD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Junio will very likely appreciate if you resend with these fixes applied.

Heh, thanks, for spotting, but this round has already been in 'next'
so any updates should be done incrementally X-<.
