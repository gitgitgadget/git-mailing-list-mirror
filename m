Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA242034E
	for <e@80x24.org>; Wed, 20 Jul 2016 15:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbcGTPx1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:53:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:35871 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbcGTPx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:53:26 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id A8D498461A;
	Wed, 20 Jul 2016 11:53:25 -0400 (EDT)
Subject: Re: [PATCH v1 2/6] Status and checkout unit tests for
 --porcelain[=<n>]
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
 <alpine.DEB.2.20.1607201710240.14111@virtualbox>
Cc:	git@vger.kernel.org, peff@peff.net, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578F9DED.6010309@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 11:51:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607201710240.14111@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:19 AM, Johannes Schindelin wrote:
> Hi Jeff,
>
> On Tue, 19 Jul 2016, Jeff Hostetler wrote:
>
>> Simple unit tests to validate the argument parsing.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>
> They are simple alright, but do we really need so many of them? I would
> like to keep the ones in t7060, but I do not think that we necessarily
> have to add the t7501 ones.
>
> I know I am a bit at odds here with Junio, who frequently prefers more
> tests. It's just that I have to run the complete test suite so often and
> it does take 30-45 minutes to run here (due to the fact that the test
> suite exercises quite a lot of the POSIX emulation layer via shell
> scripting).
>
> So do not take my suggestions as the sole basis for deciding how to go
> from here.

I'm open to suggestion here.  I mainly wanted to be able to
prove that adding "=1" didn't affect the output and that an invalid
parameter throws.  We could eliminate several of the "more trivial"
ones if that would help.

Jeff

