Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267932047F
	for <e@80x24.org>; Mon, 18 Sep 2017 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbdIRPni (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 11:43:38 -0400
Received: from mout.web.de ([212.227.15.4]:59015 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752935AbdIRPng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 11:43:36 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPrwQ-1dp2W11uoU-0051bH; Mon, 18
 Sep 2017 17:43:15 +0200
Subject: Re: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
To:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-9-benpeart@microsoft.com>
 <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
 <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <6f55efc4-96b2-7c53-7d54-ff5801697550@web.de>
Date:   Mon, 18 Sep 2017 17:43:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qYYphdmRdm03rjHIvhZkdce29TuwzNP4F8kp3AhCI0x4wmzl8CM
 7wI+pdTxWHo+j+dOjPGnA5VQmRQQyAsd0VPQ3tCckZi9XNLViZmApl9RfIMZdZYH5G5hD3P
 nwZD58D1ysJS9OSBr5PYHZGjFbiu6OyvmiS9nlB3HHS1800kC5ZocLhKCWoIHT+arE3uMpI
 nAPT3JJ1AADDicXdFJ7oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:756gZ+6hh9w=:/bbUr7VFLwxT4qq0UOABoZ
 ABAV+tz9/YRtK8yG5DYFUtMuTuy631dTbT6NJ2MbJJAfqRBsefFfHrBGY+xmT6QDvNSGk269R
 DMzHKKJg8eAHpb3cdsrH3DQ08Cosr/QvZbvQF1BisIcQLq6lnhkxYD+wh5Jkf2HhTdQbt2pGr
 llvyB2VBVKR/B4N9+9T22e8N2m3vVljtWv7Mhpi5pqTTyucQ159aZAinEN8vxQepxYLQj5FD4
 nMJH+a4Ll7UmejpVZvIGvboXycdHrCorZaI7zstI4X2YPVaHHfJQyXOHYOgsG1TGxtXVfTnLt
 Oc/VzPCud6IWTpBe+Uz5TziVke6aLKNk61UvbcXzYLpYYfNzBqWJ3GgKtRNEHM5SoyEGTJ3H7
 HFu2DIURWlb0vh3+ReSogvJluL4kRqpNNzTayO7CwvaUEd4eslsadxY0QRjmB7gXSRBkPN62a
 MO6KMLgORjlVMVoKD9P2wsyHN2eNKqzOeOr9ySI+FpSzuQ8MXblVeufzwGRxivS809TOB1LS2
 uKBLJARCwJnEgfGWvQUZmZyVNAxh7ki8qQvoTjyB8hbs3ZlOaXEozgvxpZhGwivIXxtaUJRzI
 mrosbJw88R2PKYeeOZTBBMy1isWgTuFLWnddqhOdE4W/bpSUyBDgL3s3R8s25PvZyonnUlFo/
 p15XceNW1QOoDTKYXbzuHlLMjjSjmndmX6t6cWHUVQ8bTtt0dZKMdkuzSXKVpHK7gQXDJuaZx
 hti64tW0CYuDil8GSKfeksJ2WuG4N0aD4ChB3bIK7VmxLDyrwl9MvQfNkUFpEnn2jmJFeKX4r
 zR3ATpjkG0jzVarvOERIpwkwInUgctKlgVkutBu2aM1xVQYhFA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-18 15:38, Ben Peart wrote:
> 
> 
> On 9/17/2017 4:02 AM, Junio C Hamano wrote:
>> Ben Peart <benpeart@microsoft.com> writes:
>>
>>> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
>>> new file mode 100644
>>> index 0000000000..482d749bb9
>>> --- /dev/null
>>> +++ b/t/helper/test-dump-fsmonitor.c
>>> @@ -0,0 +1,21 @@
>>> +#include "cache.h"
>>> +
>>> +int cmd_main(int ac, const char **av)
>>> +{
>>> +    struct index_state *istate = &the_index;
>>> +    int i;
>>> +
>>> +    setup_git_directory();
>>> +    if (do_read_index(istate, get_index_file(), 0) < 0)
>>> +        die("unable to read index file");
>>> +    if (!istate->fsmonitor_last_update) {
>>> +        printf("no fsmonitor\n");
>>> +        return 0;
>>> +    }
>>> +    printf("fsmonitor last update %"PRIuMAX"\n",
>>> istate->fsmonitor_last_update);
>>
>> After pushing this out and had Travis complain, I queued a squash on
>> top of this to cast the argument to (uintmax_t), like you did in an
>> earlier step (I think it was [PATCH 04/12]).
>>
> 
> Thanks. I'll update this to cast it as (uint64_t) as that is what get/put_be64
> use.  As far as I can tell they both map to the same thing (unsigned long long)
> so there isn't functional difference.
(Just to double-check): This is the way to print "PRIuMAX" correctly
 (on all platforms):

printf("fsmonitor last update %"PRIuMAX"\n",
 (uintmax_t)istate->fsmonitor_last_update);


