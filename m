Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5059F20756
	for <e@80x24.org>; Tue, 10 Jan 2017 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756451AbdAJXFE (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 18:05:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50923 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750872AbdAJXFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 18:05:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28AA65F145;
        Tue, 10 Jan 2017 18:05:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wl+Zp23qEKQ6SJYu7W11/asVrCE=; b=Ti2QTG
        fE7pOXz7ctHWJBOkQTbUf9aCnr8o7on8Bn3DbpjoJjbYCgK9diyRu0SJ0dUEO+wO
        MP7BoeImjnNASDvOsRIzsILBmsZ/mXk2LwK4xj9AAAiIk7JbUi68JGU01Hlpcnl1
        TLgGqmZr9Qm6GbY/V2kX6hAPARVHshyJnEgHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rf84V35FeWPCPlzBxtGS1tIJ2yw5uNRB
        n6Bn8/MFoPNlI+sq8YdGoBq5sP3gWER/Ohmm8+MvBObo5DTkEwX96Oz+SLVHD0x+
        Pjc5GGy9oRU2NPI0vW37VBQmtEUdmv4B9venVL2T3i2+JT8P33vWu7b2AzxMg38i
        JsdelE56LLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB5035F142;
        Tue, 10 Jan 2017 18:05:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEBDF5F141;
        Tue, 10 Jan 2017 18:05:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
        <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
        <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net>
Date:   Tue, 10 Jan 2017 15:04:59 -0800
In-Reply-To: <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 7 Jan 2017 22:27:09 -0500")
Message-ID: <xmqqinpmpld0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36913294-D789-11E6-BC5F-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 07, 2017 at 02:03:30PM -0800, Junio C Hamano wrote:
>
>> Is that a longer way to say that the claim "... is designed as a
>> book" is false?
>> 
>> > So I dunno. I really do think "article" is conceptually the most
>> > appropriate style, but I agree that there are some book-like things
>> > (like appendices).
>> 
>> ... Yeah, I should have read forward first before starting to insert
>> my comments.
>
> To be honest, I'm not sure whether "book" versus "article" was really
> considered in the original writing. I think we can call it whichever
> produces the output we find most pleasing. I was mostly just pointing at
> there are some tradeoffs in the end result in flipping the type.

I understand.  

And I tend to agree that the silliness you observed (like a t-o-c
for a one-section "chapter") is not quite welcome.

For now I queued only 2/2 which looked good.  I won't object if
somebody else rerolls 1/2 to appease AsciiDoctor, but let's take an
obviously good bit first.

Thanks.
