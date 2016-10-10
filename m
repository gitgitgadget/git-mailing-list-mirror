Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA0920989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbcJJSYF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:24:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54430 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751691AbcJJSYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:24:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E40BC43DD3;
        Mon, 10 Oct 2016 14:24:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h7gtGbNZKsCPOcDnRvs331s55MA=; b=Jtl1u/
        ZnjQJbm0+83nFS950+rL84QGApGWNPG2oLVdr5T20ZhqqJYDZgyYFMpFTbV8BnVS
        gsK66H3eoR3jnyVTmEroE2Ct7v6fxOosQf3ZpZODRnciymOM+Yod5UYDqcUfoZ+D
        hSyfdjGRx7TV3zJFjuRq6sipdz4Gojqs0J+i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BU+9XP/eiuOU+5IsJD3Cj8OoXmzLLTCF
        KbgVSDlxgxpaOh/Gwa/ed4yPcbCu4FnZzsZ749ZgqXnKtWki2fsvX/rWz5QjQlb2
        BoNSfRivYKSf0CN5lRL4ggfnhn8MRkW6ri8uu1IZ+8RpughgJwxiidH3Pb95Mzub
        0R3e7hv3uIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC80A43DD2;
        Mon, 10 Oct 2016 14:24:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DA2B43DD1;
        Mon, 10 Oct 2016 14:24:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
References: <20161007095638.GA55445@book.hvoigt.net>
        <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 11:24:01 -0700
In-Reply-To: <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 7 Oct 2016 10:32:01 -0400")
Message-ID: <xmqqh98kf4fy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8CE3786-8F16-11E6-9363-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 07, 2016 at 11:56:38AM +0200, Heiko Voigt wrote:
>
>> The description for referencing commits looks as if it is contradicting
>> the example, since it is itself enclosed in double quotes. Lets use
>> single quotes around the description and include the double quotes in
>> the description so it matches the example.
>> ---
>> Sorry for opening this up again but I just looked up the format and was
>> like: "Umm, which one is now the correct one..."
>> 
>> For this makes more sense. What do others think?
>
> Looking over the threads, I wasn't sure there was consensus[1,2]. So it would
> be equally correct to drop the quotes from the example.
>
> I dunno. I am in favor of no-quotes, myself, so maybe I am just
> manufacturing dissent in my mind. :)

I no longer have preference either way myself, even though I was in
favor of no-quotes simply because I had an alias to produce that
format and was used to it.

