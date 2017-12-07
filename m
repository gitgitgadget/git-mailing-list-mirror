Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA00420C33
	for <e@80x24.org>; Thu,  7 Dec 2017 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdLGVIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:08:04 -0500
Received: from siwi.pair.com ([209.68.5.199]:21633 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbdLGVID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:08:03 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 211C0844B9;
        Thu,  7 Dec 2017 16:08:03 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BF18C844B0;
        Thu,  7 Dec 2017 16:08:02 -0500 (EST)
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
 <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
 <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com>
Date:   Thu, 7 Dec 2017 16:08:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/7/2017 10:48 AM, Johannes Schindelin wrote:
> Hi,
[...]
> 
> That is not the only thing going wrong:
> 
> 	https://travis-ci.org/git/git/builds/312551566
> 
> It would seem that t9001 is broken on Linux32, t5616 is broken on macOS,
> and something really kinky is going on with the GETTEXT_POISON text, as it
> seems to just abort while trying to run t6120.
> 
> Ciao,
> Johannes
> 

I'm looking at t5616 now on my mac.
Looks like the MAC doesn't like my line counting in the tests.
I'll fix in my next version.

Jeff
