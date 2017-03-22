Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFD32095B
	for <e@80x24.org>; Wed, 22 Mar 2017 01:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933086AbdCVB7c (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 21:59:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757092AbdCVB7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 21:59:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A02FF6DFAD;
        Tue, 21 Mar 2017 21:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4wpnzpTrG2mvjjID1Ca7IxxojvQ=; b=AX1N/W
        k3Imtib8NhBdHitSu11eGDduVjM0pgWojH47Jphc3Rrw4v9LmXjacj0yUFTT8tDz
        vqUegzxj6ExY8YckUq+niwjGMMaRaG7D4ZrJ6qcj0q3Ej9RPGa5qA1bkr+Q13bkk
        uZJTZPXSunMq4sqTRmhvT+E6u7+2br/taTJZs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 988A96DFAC;
        Tue, 21 Mar 2017 21:58:54 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18A966DFAB;
        Tue, 21 Mar 2017 21:58:54 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] t1400: modernize style
In-Reply-To: <xmqq8tnysekm.fsf@gitster.mtv.corp.google.com>
References: <20170321005616.31324-1-kyle@kyleam.com> <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net> <xmqq8tnysekm.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Mar 2017 21:58:53 -0400
Message-ID: <87bmsukr6q.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A431D22-0EA3-11E7-B4C8-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=4wpnzpTrG2mvjjID1Ca7IxxojvQ=; b=DMT9200VimJPydCCQvAl4K3h6OCMO0TuHB9oo+aeBUg0vKwut76lzrD0EuSX8h/lJHfBAhz6LNZZ/TLrnf7NKp4cqdwHW8IoGu1zXuCZcHhQQtHjg6/FnzTEdnAq6poIPMXAT9oHcfmygcvDwALNlcH+JLrQg9G/6ekwNqGeEI8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Mon, Mar 20, 2017 at 08:56:11PM -0400, Kyle Meyer wrote:

[...]

>>> I also considered
>>> 
>>>   * making the quoting/spacing/breaks around the test descriptions and
>>>     bodies more consistent, but I think this leads to too much code
>>>     churn.
>>
>> I wouldn't mind the churn if you wanted to do it on top, but it's
>> definitely not necessary. There's nothing in 'pu' right now that touches
>> the file.
>
> Yes.  But I do not mind (actually I do prefer) if that "on top" came
> as a separate follow-up after dust from these 5 settles ;-)

OK, I follow-up with that later.  Thanks.

-- 
Kyle
