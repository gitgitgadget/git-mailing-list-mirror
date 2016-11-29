Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216D21FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 21:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbcK2VvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:51:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751591AbcK2Vuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:50:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF7125234B;
        Tue, 29 Nov 2016 16:50:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ODq5R/9BVxwvIUi0noFAvTqvuYw=; b=iuBZf3
        F7j/7xJ7J37eYAx62nNfGLNfSA6t3zsbHRt9dsEGbSekDuBz9xkJYsWh00UMRTYa
        upm6QX9kXb4q4GCiXA/RTKzXsdsugWrLD4zxMBYBW4B4RvZDQhg67WKuJ4cExL9Z
        LwMgQEYpgScczeRMHeHjKRfBvsqA3HrQWHDwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TQnpcs0c/sgDXsoEGySxOPhbL5oi5upb
        7I/x/sqmkR4yJqOnPhVAdZsG/PWqgZUkt9zNGHiTdPp8my0Ty7kgZTg7RcCdjpS/
        wsEdtGT4/ZoXDqM+hapa9Vi4pxY9iOSLqLSyL0yvCqRVryvJ1vqubrRKTJ9AVRyg
        jkSX7uX5B10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E72E65234A;
        Tue, 29 Nov 2016 16:50:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6353A52348;
        Tue, 29 Nov 2016 16:50:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: gitconfig includes
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
        <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
        <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
        <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net>
Date:   Tue, 29 Nov 2016 13:50:51 -0800
In-Reply-To: <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 29 Nov 2016 16:46:04 -0500")
Message-ID: <xmqqeg1udkg4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E669EFBC-B67D-11E6-8EF5-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it's arguable whether "--global" should behave the same.

I know you know this and I am writing this message for others.

I admit that I wondered if "a single file" ought to cover these
short-hand notations like --global and --local while re-reading the
log message of 9b25a0b52 (config: add include directive,
2012-02-06).  In other words, I agree that it used to be arguable
before we released v1.7.10.

It no longer is arguable simply due to backward compatibilty.  The
ship has long sailed.


