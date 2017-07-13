Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE9420357
	for <e@80x24.org>; Thu, 13 Jul 2017 08:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdGMIl4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 04:41:56 -0400
Received: from mout.web.de ([217.72.192.78]:49747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbdGMIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 04:41:55 -0400
Received: from [192.168.88.103] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhNZ-1dCftX2mEn-00J3ud; Thu, 13
 Jul 2017 10:41:38 +0200
Subject: Re: Git on macOS shows committed files as untracked
To:     Jeff King <peff@peff.net>, roeder.git@mailnull.com
Cc:     git@vger.kernel.org
References: <20170712222128.A2F7A246E3@outside.256stuff.com>
 <20170712231557.lu7ppj3bric2fahi@sigill.intra.peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <130b338b-2e77-65d6-a3fa-f272ac43b81c@web.de>
Date:   Thu, 13 Jul 2017 10:42:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170712231557.lu7ppj3bric2fahi@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OH0o63lgnVc5giviOEVykI56h3IO0hAYpsCIHqESR02oR5ykaOL
 JjcqdqC0st+mh3MusyYb0YWdrOLGaaLsHO8UzMtdxRYfXbiKJAOw2raQqZr9lztAEVURJmF
 pvyNzMPrhCIz6EC6IQXtQp7fULxZ5zPBSXp9fXfQl/YbX6FEeGOMRMkLsYJ9O1dv55kOiEJ
 nB6O9WArX2kIn75lyhEpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sg8cctfzRlc=:MDJuzfTNSuhCUpLLJj9zMX
 lJ8UNCA22TSLdB/IUrhKEAIqfrdhZb2NKMrxZ07UbQjHqGf/96GuvPFD+MCwTad0+1FspvKYP
 Hpl8bmUqlUw/9CW2bxhA5Xw1h/Az6oKtFvHnnjn6EZEWpiuMM0kuz58ERuUNj1JzwX+NDvvfC
 JR3sFG826FsfUlNM5Nu/IC3qEbFM/iJPNZj+7cqCH0oTivz9SjwusCxgyw3jLoksw8fqwmkIz
 P2UmMTWD+euoW26XkVaQLiLh8rBUVEb4+RdWEJjl2ZqiSn7GkCW1ViinLN1a8J2+//CcSr9aE
 tnpVZWz4vWrt0GrbQuRSE8C0fHVapPk6QwvasdTZ2Q67lJRhWGV2nW4SS01c3dQu3Nw2jn5QC
 TPNMLAOgv8ZuVwwKRWtOAKKaP6mKVOy4YjNG1E8sM19Tp+7IcMnzpBhA274gioj82oFPRFl9j
 CK33AvgrouCOiwdurkLdixxN/kxgMqJ44QD7rMoa096RvydzvpkdfHkZUlQ9KdAlqpdRG6dwa
 HU7+OSSBc2Lkljslz+IfuK0xZSUOMS++qwb3VPO4Jb8Yt5FNU9sXFXLZl5V/Dbt6T2LqJYNBE
 oVqgodacin66GL3oOUbKXlAR/yekmu8/ciqtGLpeG1T2yCEf5jLgqp9V4NQlSI20bBLDVYzgK
 2IghVxwEWYVqpTqJQ+L4/ZCNv+nU4uCGkhr6jvb5lr5MeMZS1666ibssdGBtjQBG4JE2GSr59
 iTwVCEBS0A0IzlJu2by2hd1tXpdlUzndyk0YyMl8OovVBAksQr0XMhimIu36j76ErkxZ3kwxB
 hUk1MiJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/07/17 01:15, Jeff King wrote:
> On Wed, Jul 12, 2017 at 06:21:28PM -0400, roeder.git@mailnull.com wrote:
> 
>> In Git on macOS (git version 2.13.2 | brew install git) the status
>> command will show folders as untracked even though they are committed
>> and checked out from the repository. Does not reproduce on Windows and
>> Ubuntu.
>> [...]
>>
>> 	"d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\320\243\314\213/"
> 
> Probably the issue has to do with Unicode normalization, and you have
> files in your repository that can't be represented on your filesystem.
> For example, the first two code-points above are "d" followed by U+0307,
> "COMBINING DOT ABOVE". That pair can also be represented as U+1E0B,
> "LATIN SMALL LETTER D WITH DOT ABOVE".
> 
> I don't recall which form HFS+ normalizes to, but basically what happens
> is that Git opens the file with some name, and the filesystem quietly
> rewrites that under the hood to a different, normalized name. Then when
> Git walks the directory later to ask which files are present, it sees
> this other filename that it has no clue about.
> 
> Generally the solution is to commit the normalized name. There's some
> logic inside Git to "precompose" names to the right normalization, but I
> think that only affects new files you add. Existing committed files with
> the wrong normalization run into this issue.
> 
> -Peff
> 
Thanks for the fast analyzes -
in short:
what does
git -c core.precomposeunicode=true status
say ?


The easiest thing may be to set
git config --global core.precomposeunicode true


