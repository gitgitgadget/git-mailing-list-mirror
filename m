Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DF6208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdIEQj0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 12:39:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:46386 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbdIEQjV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 12:39:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D7D2D8458F;
        Tue,  5 Sep 2017 12:39:20 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8089E84581;
        Tue,  5 Sep 2017 12:39:20 -0400 (EDT)
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, peff@peff.net
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
 <20170901235030.GD143138@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <06c552de-80a0-9cd0-d016-07a4ab0afaf0@jeffhostetler.com>
Date:   Tue, 5 Sep 2017 12:39:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170901235030.GD143138@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/1/2017 7:50 PM, Jonathan Nieder wrote:
> Hi,
> 
> Johannes Schindelin wrote:
>> On Wed, 30 Aug 2017, Jeff Hostetler wrote:
> 
>>> This is to address concerns raised by ThreadSanitizer on the mailing
>>> list about threaded unprotected R/W access to map.size with my previous
>>> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).
> 
> Nice!
> 
> What does the message from TSan look like?  (The full message doesn't
> need to go in the commit message, but a snippet can help.)  How can I
> reproduce it?

I'll let Martin common on how to run TSan; I'm just going on
what he reported in the "tsan: t3008..." message from the URL
I quoted.  I didn't think to copy that text into the commit
message because it is just stack traces and too long, but I
could include a snippet.

Thanks,
Jeff
