Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9D120C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbdLHRAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:00:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61590 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753166AbdLHRAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:00:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B690D15E9;
        Fri,  8 Dec 2017 12:00:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VqIxMxi6E2H+f7Qb3dGUd9w9W9A=; b=ci4x+z
        9XGFAnVKgBHHcIqDK8FhQ6U6zGfEbMiTRYqIxO1TBkBvrIiLko9HaagRBwZxUJ4x
        jp/wCKdYDDqA6GbM6gPO6csk9KM4PerXvOVcSoLUZfNazCKx/Q7fm1moo5u8rJ8L
        sSdXToY5g+mkhJI6VvwyJ9K0bnO0Xa2ZORTrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eqSQ84mymq/V+3oY7ZD96CM7pw/u7djF
        6mfG0ZU2c0ifqf2Gx3V/rYfsfO0lrUiyOJGUGf0pj5og+KPnm/evCYNsmOAkGx9a
        Lmw2kKPfu0kLHeE6KxVWE9jfXOIoYxxwwJMHT8Q7+R1lhoe//iHKg7SLDsrYW997
        t18n4WEz18Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22CB4D15E8;
        Fri,  8 Dec 2017 12:00:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 899D7D15E6;
        Fri,  8 Dec 2017 12:00:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
References: <20171208051636.GA24693@sigill.intra.peff.net>
        <CAPig+cTdFSZziq9Mi7HHa+UcG3V9AwvWy1EpFoCLfT_9Fi+eKQ@mail.gmail.com>
        <20171208081356.GA24991@sigill.intra.peff.net>
Date:   Fri, 08 Dec 2017 09:00:29 -0800
In-Reply-To: <20171208081356.GA24991@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 8 Dec 2017 03:13:56 -0500")
Message-ID: <xmqqfu8l9mtu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C1EFE42-DC39-11E7-BDB6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 08, 2017 at 03:10:34AM -0500, Eric Sunshine wrote:
>
>> On Fri, Dec 8, 2017 at 12:16 AM, Jeff King <peff@peff.net> wrote:
>> > Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
>> > with ",", 2017-10-01) switched the syntax of the trailers
>> > placeholder, but forgot to update the documentation in
>> > pretty-formats.txt.
>> >
>> > There's need to mention the old syntax; it was never in a
>> 
>> I suppose you mean: s/need/no need/
>
> Yes, indeed. Thanks.

Ah, I probably should switch to 'read-only' mode until I finish my
inbox.

