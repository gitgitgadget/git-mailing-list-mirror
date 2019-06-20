Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573331F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFTOmh (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:42:37 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:2374 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:42:36 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id dyGoh3XQogI7idyGphUyk5; Thu, 20 Jun 2019 15:42:35 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=7KCNmlHTX-vYfafnlXoA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: Delivery Status Notification (Failure) ... connection lost
To:     Xeno Amess <xenoamess@gmail.com>, git@vger.kernel.org
References: <CAFF4x5LfJ7qY73JE-=mah5vx9PdeNhc0i0X6kQohPpvDTCd3Sw@mail.gmail.com>
 <5cff8197.1c69fb81.4940.6de6.GMR@mx.google.com>
 <CAFF4x5LFYQqHnUSzqd1R9NJ=ZVKs3yFqZA=RdrihVx74BtKWMg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <299a4753-6d93-7114-f00b-4c2a31814e0e@iee.org>
Date:   Thu, 20 Jun 2019 15:42:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFF4x5LFYQqHnUSzqd1R9NJ=ZVKs3yFqZA=RdrihVx74BtKWMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDczIos0tXXzfH8PXtuF2reDQV9MHuLuljJl1daalDuyXFTq3FhYfm141+5YJzv97iQLgg87383jYTNbk+oz/uvPR4izMKyjAwuzZFQisYKlxPpdJGtc
 X7jXDa4fUCgqsW/45mnS9Vw8mRibY/MRtNNcCF018bWXcby5MZu5u/uW9MNrcwogZIO8gpATaJCftNHp3O0CMCA9i8fUy6UlEX8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/2019 11:29, Xeno Amess wrote:
> Not all people can afford stable network connection...
> I'm now suffered from connection lost and have to restart the clone/push fully.
> It's OK when dealing with a project of several MB size, but when I try
> to clone a 2GB sized repo I never succeed.
> So I wonder, if there should be some way to resume from break-point for git?
> For example what if we support something like Content-Range in http,
> and make the download be split into smaller files, then make some way
> to auto-resume if some file block failed hash-check?
Is this on a Windows machine using Git for Windows, or a Linux machine, 
or even 'Windows Subsystem for Linux (WSL)" on windows?

If it is Windows then you may have hit the "sizeof(long)=32bit" limit.

If it is Linux then maybe adjust your refspec to limit the size of each 
fetch or push. There has also been a recent change discussed on list 
that added a config variable for some sort of rate limit limit but 
haven't looked back at the mail archive to try to remember details - try 
searching the https://public-inbox.org/git/

Philip

