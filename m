Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725BF1F462
	for <e@80x24.org>; Mon, 20 May 2019 18:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfETSt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:49:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:43099 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfETSt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 14:49:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0C0323F4088;
        Mon, 20 May 2019 14:49:28 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:995c:4aa3:4774:bbd8] (unknown [IPv6:2001:4898:a800:1012:4a90:4aa3:4774:bbd8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 86FB23F404C;
        Mon, 20 May 2019 14:49:27 -0400 (EDT)
Subject: Re: I made a flame graph renderer for git's trace2 output
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <87zhnuwdkp.fsf@evledraar.gmail.com>
 <8794fd2e-6256-3238-6d87-2e726d4a91fa@gmail.com>
 <20190510170014.GQ14763@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0c3e48e0-ef87-39c2-a984-ba7deede0651@jeffhostetler.com>
Date:   Mon, 20 May 2019 14:49:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510170014.GQ14763@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/10/2019 1:00 PM, SZEDER Gábor wrote:
> On Fri, May 10, 2019 at 12:38:52PM -0400, Derrick Stolee wrote:
>> export GIT_TR2_EVENT=~/git-tr2-event.txt
> 
> Hrm,  better late than never, or at least better late than after it's
> in a release...
> 
> Why does an environment variable that is supposed to be set by users
> have this "TR2" abbreviation in its prefix?  What exactly, if
> anything, did we gain by omitting "ACE" and not calling it
> "GIT_TRACE2_..."?
> 
> Ken Thompson springs to mind, who (allegedly?) later regretted
> spelling creat()/O_CREAT without the 'e'...
> 

For closure here on this thread.  I chose TR2 rather than TRACE2
somewhat at random for convenience during testing.  Changing is fine
as you suggest in your other patch series.

Thanks
Jeff
