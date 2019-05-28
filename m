Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A06A1F462
	for <e@80x24.org>; Tue, 28 May 2019 13:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfE1N3w (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 09:29:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:30497 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfE1N3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 09:29:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6BE143F40F0;
        Tue, 28 May 2019 09:29:51 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:98c8:dc56:b85b:909] (unknown [IPv6:2001:4898:a800:1012:49fc:dc56:b85b:909])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D267A3F40CB;
        Tue, 28 May 2019 09:29:50 -0400 (EDT)
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
 <87ef4of3g6.fsf@evledraar.gmail.com>
 <CAP8UFD2HJ2D9Sndud5Wu7Vyz9Jj-mVkpE4oowd3VaXoV3nugcw@mail.gmail.com>
 <83f6b1f6-2aba-f81c-03d2-69815e8e6cfb@jeffhostetler.com>
 <20190528061317.GD7946@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <59f8a7c4-1df9-2b44-2456-485fbce750ba@jeffhostetler.com>
Date:   Tue, 28 May 2019 09:29:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528061317.GD7946@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 2:13 AM, Jeff King wrote:
> On Fri, May 24, 2019 at 02:46:06PM -0400, Jeff Hostetler wrote:
> 
>> My original thoughts were that we could limit the sparse:path to
>> local use and disallow it over the wire to the server, but that
>> distinction is probably not worth the bother.  Removing it completely
>> is fine.
> 
> Yeah, it had been my plan to limit it only via upload-pack, under the
> assumption that somebody probably wanted it on the local side. If you,
> who added it, are OK with removing it completely, that gives me more
> confidence that nobody is using it (coupled with the general
> experimental nature of partial clones at this point). But I'm still a
> little worried somebody may have found a use for it in the meantime.
> 
> -Peff
> 

yeah, let's simplify things and remove it completely for now.

Jeff
