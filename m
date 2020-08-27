Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3356FC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCC20737
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0UtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:49:05 -0400
Received: from mail-gateway-shared02.cyon.net ([194.126.200.224]:51558 "EHLO
        mail-gateway-shared02.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgH0UtE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Aug 2020 16:49:04 -0400
X-Greylist: delayed 821 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 16:49:04 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1kBOcB-0003cz-Ux
        for git@vger.kernel.org; Thu, 27 Aug 2020 22:35:22 +0200
Received: from [10.20.10.230] (port=28300 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1kBOcA-006EAP-OZ; Thu, 27 Aug 2020 22:35:18 +0200
Subject: Re: [PATCH] gitk: use the 'reference' format for the commit reference
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Paul Mackerras <paulus@samba.org>, Git List <git@vger.kernel.org>
References: <20200827161224.824365-1-dev+git@drbeat.li>
 <CAPig+cRZEgu4GfMGSWQbs4cV9OGT9z7gKh8v8S+_sWmKFJd4Sg@mail.gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <55bcebf4-5d5a-7133-35b8-c8780d7ee154@drbeat.li>
Date:   Thu, 27 Aug 2020 22:35:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRZEgu4GfMGSWQbs4cV9OGT9z7gKh8v8S+_sWmKFJd4Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.08.20 18:26, Eric Sunshine wrote:
> On Thu, Aug 27, 2020 at 12:19 PM Beat Bolli <dev+git@drbeat.li> wrote:
>> Since 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19) in
>> the main Git repository, there's an officially blessed format for commit
>> references. Update gitk to also use this format.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> 
> See this thread:
> https://lore.kernel.org/git/da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com/T/

Ooops, my memory is lacking!

Please ignore the noise...
