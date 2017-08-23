Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0292220899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbdHWSGS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:06:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:53747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932536AbdHWSGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:06:18 -0400
Received: from [192.168.178.43] ([188.108.200.6]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQvDO-1e8CXh2pmI-00UHfX; Wed, 23
 Aug 2017 20:06:15 +0200
Subject: Re: [BUG] rebase -i with only empty commits
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
 <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
 <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
 <ece1018b-98b1-e9b7-546a-d7c68dacfbb7@gmx.net>
 <CAGZ79ka-SS8ZyZkp6d=0iNtTtQgh2cAhzJSt4m22F88vb1rbhw@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <565221dd-b66f-8b88-1bdd-8d0d55c4dc96@gmx.net>
Date:   Wed, 23 Aug 2017 20:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka-SS8ZyZkp6d=0iNtTtQgh2cAhzJSt4m22F88vb1rbhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pJDwIJssTQYnJMMRmvaMDPFq87lRAQ/0CW6E+d8VjgUV3ePPQVE
 dZ04LK0OV2gf9ImYnD53G3GtOeSk5U5TRJZjTCm8mIdnE3AvDdAeNVFclI1NMRuTXgwc/Ia
 MyKOU/8OmnaytVo5+9IOat1paNa4ycALcMJjSbpe8bOxjc8Wxu1N/6G8TedoWFo46S6MsKt
 S9WDt7ZHxlM9aoKcDtJ6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q5/J/RNdtRY=:/u0ZeRwCk29HsUnA39m76O
 4b7LYnvyZ4ssYUVktI9eNylb8TiUZ5TJf4zCPqaqfFdcoVeT9JzhKi7/3S18Ql1aqR2guaLhi
 hA1frdPLBcoCg7n4mMUdBWaL94mYI6/kDibdpI34p+V1Z3e1J6lpO6do454NVMN0ny815dSss
 xm5l9J4SPRJSlloxFK/BUOBqN4YSRY+Mug8ziPtGqsCcKI3C72fIm867AwvzufEhubpeWPpXY
 v0Cdm2UkVvMdZ9k8miI/hsmkx/T2V5V+tvaXogek60v3AUXunCm5rrL+wZ0VjnTeirsq9AQDX
 fZmcrbcVIHDd611VpC3l8ce4kBq1xWWt7VpCUVuiyJawEacmXnO8bH1yTDUFetw2/VRQBz+ra
 ekclsS0x+D4T5b3TF96JtMIEiQEcFogLV1CniKAALkIxJqakrTVFqGAvf9VmdM1vsi+AlZmLb
 5cZ8okjE64Uf2M0U92h8zrWfGUhGzc29BcIdn9wiC9kA/pR1U7DDw/ktIO0Axn00ntEP7bKoG
 Jz8u4UWjS8hcHw9qndnqY5uSXQg3bGTCoudbUyKI72gXXRX+TufMAkXXT7tjyllBFQSy0AdHd
 02ueqL1nF4Cg753rMrpF+4UFLatR3j7IugPu+AHSvOFawpyS+imRuev6G1VH/kikGpgjF1AQs
 6ocuKgnHvSuF+UiGgBWsL4+i6EkhGXoW3Rp2vNtWIRHiRmM7UcMMFDbvyJx9VZWjXS78M1UJw
 O2UCHayH0RfrheaqKRF/SAxEGcxmbm6KVK7nMNmmfuGyFym1Us5TbAwYwdTfJhT6WSCtV5i+A
 lmgmTJZhjju7cXr1rXQREcQwjoFCeajaATUCIqBcs99Cn14t2w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 07:29 PM, Stefan Beller wrote:
> On Wed, Aug 23, 2017 at 8:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> On 08/23/2017 04:40 PM, Johannes Schindelin wrote:
>>> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
>>> you want to do that, too?
>>
>> That's a very valuable hint, thank you very much!
> 
> While -k side steps the original problem, it seems like it would
> have helped me, too.
> 
> Is there any value in discussing turning it on by default?

I also wondered why empty commits are "discriminated" in such a way.
I first thought that if you rebase branch A onto B but branch A and B
contain commits with the same changes, then these commits would become
new empty commits instead of simply being ignored. But I just checked
this theory and it is now falsified :)

It seems empty commits occur *only* if the user wants them to occur
(--allow-empty). If they occur unintentionally (for example, by
importing some SVN), one can eliminate them using filter-branch or
rebase (by commenting out these picks).
So it is still unclear to me, why empty commits are handled in such a
special way.

Best
Stephan

PS: Although -k helps, the original behavior of rebase -i is still a bug.
