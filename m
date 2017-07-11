Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763B620357
	for <e@80x24.org>; Tue, 11 Jul 2017 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbdGKIUL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 04:20:11 -0400
Received: from mout.web.de ([217.72.192.78]:57055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754510AbdGKIUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 04:20:09 -0400
Received: from [192.168.88.159] ([194.47.243.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bYJ-1dqWJo2Zcd-00xKq2; Tue, 11
 Jul 2017 10:19:55 +0200
Subject: Re: Weirdness with git change detection
To:     Jeff King <peff@peff.net>,
        Peter Eckersley <peter.eckersley@gmail.com>
Cc:     git@vger.kernel.org
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
 <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
 <CAOYJvnLCwR7CkG32E_r5BcVm5tFt5zsgYe7TUW3hVGBtQBHzGw@mail.gmail.com>
 <20170711073433.ghcz3lku3ux54fib@sigill.intra.peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <decbd316-5194-120d-824e-b5cee1f0822c@web.de>
Date:   Tue, 11 Jul 2017 10:20:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170711073433.ghcz3lku3ux54fib@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2R5Nh0YwilyfDs0xjffZ0W4GXp0uP0CZJ3YZhUNfyNn29hK6dH2
 Uf3s0DmthdeQnJ0mPctL6nAh1fUZG0OY1O9LHU5FbhNA+5s1YQkiTSb0pzHAgOybrErZKod
 5QD/Kr4vchsY9KM5/VDAW05QRVWzN0IU0WZX+z7dtkmpwVHyLNWcXyvUW/8aLsIigWmBQzv
 HdiDfetstuthuFeQLTOWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ORvecdpARjk=:ZPSMdk720O37LX/zTBO0mM
 IRBqUkjepJXDAX0OUQ7QWj0LMzlceS2GlNKOrA9kR6J6ZyohgsfPfHS8DGasgDGgeDe0iu3Lt
 Hw5qbpK+IKsPswf6KCiJBIFiR/xddb6nRm7PdfYlLvrwjTs1lFINvksvFD7+mRsvFGpImCk30
 xZCrwQQbW/eOGA8ZL/1t3B0iCyBuTu7uokaVv5QFmcYqrFPMULasU+cJlh+H+DDgcBfO2Iv4f
 BUM6LA/VlSp71GFOdcwakK/BO9wB5m4uH5vrPR6N323oLjgtFGye4BEl2cs3bYZel/x9g8Lt7
 CXilYEneP+ju+f5kyXS4uoNWSj4WT2deGpzlfYBeezfue3sj3iKVnhREKXiyFTSxZRL9swKC8
 HarSTPv2f4Q+Tg9OXx56ZNMa+H0jRlSjceEA6YSjsd8bA7mXSd14X9zcHyaeSJ1quZ54aTwLV
 NMZzbZqvXfTPstcxjIGNLyAYfVldtWb5EpTauF1HoI4vbmdqpTfvHPUk7AtDWVcjPSooySdNv
 yfQ7+bTi1oMT9gr2TNIXGkV/5ItWo6c8vGqQBaLGApePdg5/Bq7+1sLgdMAdOv7bYnSoFvhg0
 PSqx3HMabWMj7CNZgVplp/x5aibF/u1ht6nSDePgfHxQw1QQGRlp0LBkk+m8/9c62wFWCJH/j
 WAF9AfKERFzOxdEEU0J4ZLkrx7Vb9XyjXKFrASbGUspeyiGjgst3yPoEhc4ZDUUYSI8wLOUGK
 hw+PsEsLuERcMGxF15d8V6KFSc6kESCPkjpldidMdtutHm0kRSdJbA6ee0EduNTTBRIsM/pBD
 rnH9VVK7WbiizoL62JAJIKOSvJtDgZf9XvOS95l0wxbI9IpGfr5Lcv6lsHPHkrcUp0i/mqxVD
 HVzDTH5GBDLhLuxtdKDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/07/17 09:34, Jeff King wrote:
> On Tue, Jul 11, 2017 at 12:31:25AM -0700, Peter Eckersley wrote:
> 
>> I did try to test that hypothesis by editing the filter to be a no-op,
>> but it's possible I go that wrong. My apologies for bugging the list!

Actually I like this kind of feedback, to see how people are using Git,
including the problems they have.

> 
> No problem. I actually think it would be interesting if Git could
> somehow detect and warn about this situation. But the obvious way to do
> that would be to re-run the clean filter directly after checkout. And
> doing that all the time is expensive.

Would it be possible to limit the round-trip-check to "git reset --hard" ?
If yes, possibly many users are willing to pay the price, if Git tells
the "your filters don't round-trip". (Including CRLF conversions)

> 
> Perhaps some kind of "lint" program would be interesting to warn of
> possible misconfigurations. Of course people would have to run it for it
> to be useful. :)

What do you have in mind here ?
Don't we need to run some content through the filter(s)?
