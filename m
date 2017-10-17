Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B241FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934976AbdJQU6H (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 16:58:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934957AbdJQU6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 16:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95B12A0A5F;
        Tue, 17 Oct 2017 16:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z40X1NUYFvv8wGOjCdodjiWHEzU=; b=iRXYhs
        lkbVZ7URpQryCAyz+wRBQMjeVxz2rG7FOspS/WLjD7D3b2PRtVXCxBsS1oP9H0oS
        ETkKhPN/N7gir/8X53SPLm4xe0ahit6lUuT5d4k6dBbpZcyCGv27H3g0GQMdNEdC
        1KE7FuLhKPEzSygSVONs49Sk9WyisoekBIvWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DeWKOW91e4TmwhWEhX6lsuhaLhvo1MF+
        IZZZ88kQoPFbB/d3Tk+kWB3Yqh9EnzuNDk8AnxYvsd9Glh3y6MIB/L63ADjadhRa
        vMr7qmRHZXMbVlQNShvS8wSycmNcjBm9cQyyUMxfF8spyUx4fhkcOXpJvJ3k+mX2
        knSaQ+yfUMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DCE4A0A5E;
        Tue, 17 Oct 2017 16:58:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08494A0A5D;
        Tue, 17 Oct 2017 16:58:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
        <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
        <87zi8psli3.fsf@linux-m68k.org>
Date:   Wed, 18 Oct 2017 05:58:02 +0900
In-Reply-To: <87zi8psli3.fsf@linux-m68k.org> (Andreas Schwab's message of
        "Tue, 17 Oct 2017 20:00:04 +0200")
Message-ID: <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE551CF4-B37D-11E7-A76E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Okt 16 2017, Jeff King <peff@peff.net> wrote:
>
>> We do have some hacks/workarounds for broken versions of the toolchain.
>> You can try tweaking various knobs you find in Documentation/Makefile).
>> DOCBOOK_SUPPRESS_SP sounds promising, but I think it actually does the
>> opposite (removes extra spaces).
>
> An easy workaround would be to add a comma between `-f` and 'git
> branch'.

That sounds like a good idea, regardless of the mark-up issue.
