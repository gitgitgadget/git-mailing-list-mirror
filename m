Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970D207B6
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgLCSjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:39:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61340 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLCSjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:39:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69BF2FD689;
        Thu,  3 Dec 2020 13:38:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K9d2g2yThRs4bUzdZoBvu6CEq6Q=; b=FE3qkz
        TccGMlEFh7Xq+JeFGZM8zy3z6Y5NwJQxDge9/Tf1EPjFsFOr9Tg9frMN3rFZODmH
        wu/ZqE1paaZbEapsTqk56loCAYJQ0QiJSwlpJ5w6tv9a9lTHPH6SUXmCVqU9TIWB
        UGhljtiMqTva+q0twFXB/1rQaTEs2Q8jcLnps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OTSutd5lsoRiZWXMDrYARX72IjgQx3lI
        vTkA74eUP8hTLKl7H8IalEaDlZjpq230MLjSGIhE5ZVnfatXUCVVDOu+9uJvvoi2
        aR8TY8tdG4Wh4kIEQfb+cC29OE3BSGwrVeWLHIJnXbeEHwZyzO9QeUJPAS0DCMM4
        23lPwx8GzzU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62E1BFD687;
        Thu,  3 Dec 2020 13:38:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A22DAFD686;
        Thu,  3 Dec 2020 13:38:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] style: indent multiline "if" conditions by 4 spaces
References: <X8ibEpkel8OMS/hV@coredump.intra.peff.net>
        <xmqqv9dihhqs.fsf@gitster.c.googlers.com>
        <X8kvJRnOtSEYziRK@coredump.intra.peff.net>
Date:   Thu, 03 Dec 2020 10:38:30 -0800
In-Reply-To: <X8kvJRnOtSEYziRK@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 3 Dec 2020 13:32:05 -0500")
Message-ID: <xmqqr1o6hh09.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE2B3208-3596-11EB-88CF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, the goal is to align it, but I had trouble thinking of a succinct
> way to say that. Maybe just:
>
>   style: align indent of multiline "if" conditions

I couldn't come up with a good description, and 
just did s/by 4 spaces/to align/, i.e.

    style: indent multiline "if" conditions to align

while queuing.  I dunno.

