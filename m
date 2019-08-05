Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5827D1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfHEREG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 13:04:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60778 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfHEREG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 13:04:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E65011741E7;
        Mon,  5 Aug 2019 13:04:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIGmCbJPHM/JgU7ck+jsButSRVg=; b=QJHDOD
        2ujdZlDvexnbDHCqOVIss2CbtAvI8AsQQX3DkzhwKJqYo5wcyxJ37oXIByw0M0t0
        rKqDdg0p1Wsv6UQiuiqSbXBuDc9PPWG1AIg/As3TsgyLARQspp9Pcck4Tx3xX4K8
        mTAZI9UfvlKR7mvC6mFWOrf4rMRUYcsBmwxIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BtaJ1a4pfWd4fb8uvoxodQFcd+t9Cpcp
        P1HHJSyvnUR4Ghuw1VEN4eG6mb6Gd2AH5fyPQI78eJnAvMHzHUTPjjF+B6RCXRNa
        eUqY4Z1hXgdWWo0oxLWp3JeOzYXTcG9g6ebawB+kWqOHeYqOIwnhhRrqEouveb+7
        q6/hY4e+PTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB3C21741E6;
        Mon,  5 Aug 2019 13:04:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 265BD1741E3;
        Mon,  5 Aug 2019 13:04:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mark Rushakoff <mark.rushakoff@gmail.com>,
        Mark Rushakoff via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix two documentation typos
References: <pull.304.git.gitgitgadget@gmail.com>
        <xmqqsgqii9u3.fsf@gitster-ct.c.googlers.com>
        <20190803235914.GA5353@sigill.intra.peff.net>
Date:   Mon, 05 Aug 2019 10:04:01 -0700
In-Reply-To: <20190803235914.GA5353@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Aug 2019 19:59:14 -0400")
Message-ID: <xmqqlfw7ilxa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06B78878-B7A3-11E9-B1D0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Aug 03, 2019 at 07:48:20AM -0700, Junio C Hamano wrote:
>
>> > Then I noticed a "can not" and updated that and other occurrences in
>> > Documentation to cannot. The glossary sentence with "can not" was
>> > "Consequently, an object can not be changed." To me, that reads like "it is
>> 
>> Hmph, I am not a native speaker, but I have to say that this is the
>> first time I heard that "I can not drive" to mean "I have a choice
>> of not driving (even though I am capable of driving)".
> ...
> That said, I think in many error messages, "unable to" is often better
> (and we already use it quite frequently).
> ...
> ... So it is Git saying "you cannot do this", not "I was unable to
> do this". :)

Thanks.  In any case, none of the s/can not/cannot/ in Mark's patch
is making anything worse (the only case I can think of that a blind
search-and-replace would break would be a phrase like "I can not
only do X but...", but the none of the ones Mark spotted is like
that), so let's take the patch as-is for now.


