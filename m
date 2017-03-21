Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13D22095D
	for <e@80x24.org>; Tue, 21 Mar 2017 17:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbdCURv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:51:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52361 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933288AbdCURv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:51:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E19164A01;
        Tue, 21 Mar 2017 13:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6I6vXcmn7M4uTldDOdbsOsGsG8k=; b=PRUjsH
        WAffRPfx3btgh8p9+YN+c7yt4R62av5Ff6tinLwijz7dm7CDuekK2FbNpLfV+yCS
        +VF/pKE9d4JU2p9vTy+AEFn2vLXqszLWW61w8IrQ1YDqwz+EqrJyScLa3TZpbpPB
        o9GFB0LAFi8w/zpKPK6WWZU/uHrbAgyRzWljk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R0u7sg1O5xfdiTQ9xh9JZYuw23QeQJmX
        4ghmPIJ95k/tDhI7s14x3Mnt8K1CXtEoa8iQW4YDPgDDKkNYxA0WcjisrSwr0lWB
        3vU6bcCWvJayyfZu5LFZQbPC77qoAVLjjzwGCxi580mDaosST+eZq+5PEl1S4txH
        K3buEq/zJIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 459A7649FF;
        Tue, 21 Mar 2017 13:51:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AED63649FE;
        Tue, 21 Mar 2017 13:51:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] t1400: modernize style
References: <20170321005616.31324-1-kyle@kyleam.com>
        <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net>
Date:   Tue, 21 Mar 2017 10:51:53 -0700
In-Reply-To: <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 22:01:55 -0400")
Message-ID: <xmqq8tnysekm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12268744-0E5F-11E7-ADE4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 20, 2017 at 08:56:11PM -0400, Kyle Meyer wrote:
>
>> These patches follow up on Peff's suggestion to modernize the style in
>> t1400-update-ref.sh.
>> 
>>     20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net
>> 
>> The first two commits aren't concerned with "modernizing" the tests,
>> but instead address issues that I noticed while looking more closely
>> at t1400.
>
> Looks good overall to me. Thanks for following up.

Thanks for a review.

>> I also considered
>> 
>>   * making the quoting/spacing/breaks around the test descriptions and
>>     bodies more consistent, but I think this leads to too much code
>>     churn.
>
> I wouldn't mind the churn if you wanted to do it on top, but it's
> definitely not necessary. There's nothing in 'pu' right now that touches
> the file.

Yes.  But I do not mind (actually I do prefer) if that "on top" came
as a separate follow-up after dust from these 5 settles ;-)

Thanks.
