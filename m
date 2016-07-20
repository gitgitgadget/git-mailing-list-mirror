Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9241F744
	for <e@80x24.org>; Wed, 20 Jul 2016 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbcGTRdy (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:33:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:26990 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbcGTRdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:33:53 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 6696B84591;
	Wed, 20 Jul 2016 13:33:52 -0400 (EDT)
Subject: Re: [PATCH v1 2/6] Status and checkout unit tests for
 --porcelain[=<n>]
To:	Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
 <20160720160007.GB24902@sigill.intra.peff.net>
 <20160720160357.GA25076@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578FB578.5070504@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 13:31:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160720160357.GA25076@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 12:03 PM, Jeff King wrote:
> On Wed, Jul 20, 2016 at 10:00:07AM -0600, Jeff King wrote:
>
>> On Tue, Jul 19, 2016 at 06:10:54PM -0400, Jeff Hostetler wrote:
>>
>>> +test_expect_failure '--porcelain=bogus with stuff to commit returns ok' '
>>> +	echo bongo bongo bongo >>file &&
>>> +	git commit -m next -a --porcelain=bogus
>>> +'
>>
>> Hrm. That seems unexpected to me. Shouldn't it complain about
>> --porcelain=bogus?
>
> Pondering more, did you mean:
>
>    test_expect_success '--porcelain=bogus complains about format' '
> 	echo bongo bongo bongo >>file &&
> 	test_must_fail git commit -m next -a --porcelain=bogus
>    '
>
> ?

Yes.  That is what I meant.  And yes, some of the names are confusing.
Thanks.

Jeff
