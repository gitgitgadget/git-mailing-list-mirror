Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F84E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWTds (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:33:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:35727 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbeCWTds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:33:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3AB93F400E;
        Fri, 23 Mar 2018 15:33:47 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 818F13F400D;
        Fri, 23 Mar 2018 15:33:47 -0400 (EDT)
Subject: Re: [PATCH v3] json_writer: new routines to create data in JSON
 format
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        avarab@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20180323162952.81443-1-git@jeffhostetler.com>
 <20180323162952.81443-2-git@jeffhostetler.com>
 <20180323171828.GD179915@aiede.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6b27b09b-727d-1c3f-c311-5cf6c9bafb4f@jeffhostetler.com>
Date:   Fri, 23 Mar 2018 15:33:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180323171828.GD179915@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2018 1:18 PM, Jonathan Nieder wrote:
> git@jeffhostetler.com wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add basic routines to generate data in JSON format.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> 
> If I understand the cover letter correctly, this is a JSON-like
> format, not actual JSON.  Am I understanding correctly?
> 
> What are the requirements for consuming this output?  Will a typical
> JSON library be able to handle it without trouble?  If not, is there
> some subset of cases where a typical JSON library is able to handle it
> without trouble?

I'll add text to the commit message and the .h file explaining
the Unicode limitation in the next reroll.

> 
> Can you say a little about the motivation here?  (I know you already
> put some of that in the cover letter, but since that doesn't become
> part of permanent history, it doesn't help the audience that matters.)

I'll add a note about that to the commit message.
Thanks.

> 
> This would also be easier to review if there were an application of it
> in the same series.  It's fine to send an RFC like this without such
> an application, but I think we should hold off on merging it until we
> have one.  Having an application makes review much easier since we can
> see how the API works in practice, how well the approach fits what
> users need, etc.

That's fine.  I'm planning to push up another patch series next week
that builds upon this, so hopefully that will help.

> 
> Thanks and hope that helps,
> Jonathan

Thanks,
Jeff

