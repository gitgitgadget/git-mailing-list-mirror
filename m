Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3E6202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934075AbdKBBgx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:36:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933083AbdKBBgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:36:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5645BAAAA1;
        Wed,  1 Nov 2017 21:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgC6ogDOM5fqt/7rO5L7Kmehh4c=; b=a0p/np
        YvQFOBKNywMjEUD0HvszXkTBMupv7+FuAUnRSut6mzCn5hgjMDwx4hoXg/dvqIfp
        5mbs0ZVwbQuhiheaEnH5S+pKIF0EoXA5idHasbvdrQlI1XHwaawreQD2RfM39dq0
        eSLZ3aHoa/ptOc5QExiVMF+VPDkSDdfbP8bJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PtN5ERxucdYgHeqK9KMFufJSM0rwK4zW
        twHNHoyYR27N6wUIr2WZza2wNcJKuBe94yscPNPU1oBgjDT2/uVKc1hI+IjN5C+b
        2HYdxE56yoFrOlNeKFhzBk+yoF1f3uQsZQXBd+gh4YsX5Tj6cbKC14vZ8gPL9Nd7
        8zUj+CdWSmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CF1AAAAA0;
        Wed,  1 Nov 2017 21:36:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE4A3AAA9E;
        Wed,  1 Nov 2017 21:36:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 7/7] t6120: fix typo in test name
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-8-sbeller@google.com>
        <xmqqh8ueyet8.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 02 Nov 2017 10:36:49 +0900
In-Reply-To: <xmqqh8ueyet8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Nov 2017 10:21:07 +0900")
Message-ID: <xmqqmv45sbpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C7268DA-BF6E-11E7-942A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t6120-describe.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Good.  I am guessing that you are sending this as the last/optional
> one because this was found _after_ you worked on other parts of the
> series, but I think it is easier to reason about if this were marked
> as a preliminary clean-up and moved to the front of the series.
>
> Thanks.

Having said that, if you already have v2 that keeps it at the end,
that is fine.  

It's just leaving such an "By the way I found this unrelated one and
fixed it while at it" at the end when submitting will give an
impression that the series is not as well proof-read as it could be,
because a good proof-reader would notice something out-of-place like
this fairly quickly and would move it to the front or even in a
separate preliminary clean-up series.

