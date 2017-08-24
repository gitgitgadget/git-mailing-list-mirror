Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8D920285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbdHXT34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:29:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752751AbdHXT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:29:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 956E29CE8B;
        Thu, 24 Aug 2017 15:29:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cAGRu5AKUpF8a4wtlAc4I1VKdjQ=; b=WtZt+V
        wdfhwzKDg3XVrJvqHFAyyBemp1+8+djJ0imJij9hUy9AX3U2NrDPNBQ7th1JwC53
        NS/J7AwjWTXS8z8TWtvI+WiIcr4iv9tTY3EaMgzE7INvYKVBuEB2Bj5gDmhdUaQC
        lBCZe5NnBbs6S+QptbrqESvKiPxt8f7/y+Z8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QQQf1PaE0gxMbXDTmui3+YKgJnFT0Y+n
        LpwbsK/etitz2nViqXA7HnlkN2JJchLGH3CO7cHKymNGDhr7m0rpxwnu+S4iW2Kb
        TfQTh0uncO/Nd+1E1/Y6l6G8A2CpbRzxN0AUHfD6Sjbp3fSu31jlCGsUk+nnbClT
        kn2bLtvBbtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E5319CE8A;
        Thu, 24 Aug 2017 15:29:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E99899CE89;
        Thu, 24 Aug 2017 15:29:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sonny Michaud <michaud.sonny@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
        <cd00912b-5b66-f299-87bf-52aa19d90270@gmail.com>
        <45c23aab-bf20-d234-1e08-e6f0358f1779@gmail.com>
Date:   Thu, 24 Aug 2017 12:29:52 -0700
In-Reply-To: <45c23aab-bf20-d234-1e08-e6f0358f1779@gmail.com> (Sonny Michaud's
        message of "Thu, 24 Aug 2017 11:29:50 -0400")
Message-ID: <xmqq8ti8wyq7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AE514B0-8902-11E7-BDDD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sonny Michaud <michaud.sonny@gmail.com> writes:

> On 08/22/2017 11:25 AM, Sonny Michaud wrote:
>> I am just bumping this thread; I presume there is something amiss
>> with my submissions, so if someone can let me know how to fix any
>> issues, I will gladly re-submit the patch.
>>
>> Thanks!
>>
>> - Sonny
>
> Bumping again for visibility.

It's probably not due to "something amiss" but nobody was interested
in what the patch tries to achieve and had nothing useful to say on
it (hence everybody was quiet).

Some other people may have skipped seeing only [0/1] without [1/1],
as reading only the cover letter without an accompanying patch will
be waste of their time for busy reviewers---by the time [1/1] comes
it is likely they forgot what [0/1] said and they need to go back
and read it again, so they would likely have said "I'll read both
when [1/1] appears on the list", moved on, and then have forgotten
about it.  I am in that camp.

