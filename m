Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA641FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdBLSct (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:32:49 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:30955 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBLScs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:32:48 -0500
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1CIWjvm015410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2017 18:32:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v1CIWi8k011372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 12 Feb 2017 18:32:45 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v1CIWf2P023446;
        Sun, 12 Feb 2017 18:32:43 GMT
Received: from [10.175.207.10] (/10.175.207.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Feb 2017 10:32:41 -0800
Subject: Re: What's cooking in git.git (Feb 2017, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
 <77af28f3-7a8e-fc6a-40ae-c4203d1a3a67@web.de>
 <xmqq8tpdifoa.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <36fdf8c9-f82d-4996-09ef-7d718ab3ac41@oracle.com>
Date:   Sun, 12 Feb 2017 19:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tpdifoa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/02/2017 04:12, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>
>> Am 10.02.2017 um 23:24 schrieb Junio C Hamano:
>>> * vn/xdiff-func-context (2017-01-15) 1 commit
>>>  - xdiff -W: relax end-of-file function detection
>>>
>>>  "git diff -W" has been taught to handle the case where a new
>>>  function is added at the end of the file better.
>>>
>>>  Will hold.
>>>  Discussion on an follow-up change to go back from the line that
>>>  matches the funcline to show comments before the function
>>>  definition has not resulted in an actionable conclusion.
>>
>> This one is a bug fix and can be merged already IMHO.
>
> Absolutely.  I was just waiting if the follow-up discussion would
> easily and quickly lead to another patch, forgot about what exactly
> I was waiting for (i.e. the gravity of not having the follow-up),
> and have left it in "Will hold" status forever.

I said I would resubmit the patches with more config options and more
command-line arguments (to avoid potentially breaking backwards
compatibility), but IIRC the response seemed to be "preceding blank line
heuristic is good enough" and "why bother", so I ended up not not
resubmitting anything.

>
> Let's merge it to 'next' and then decide if we want to also merge it
> to 'master' before the final.  The above step alone is a lot less
> contriversial and tricky bugfix.

Thanks,


Vegard
