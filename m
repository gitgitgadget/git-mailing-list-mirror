Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8AF20951
	for <e@80x24.org>; Fri, 17 Mar 2017 14:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdCQOPc (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 10:15:32 -0400
Received: from siwi.pair.com ([209.68.5.199]:18729 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdCQOOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 10:14:32 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B15C084642;
        Fri, 17 Mar 2017 10:13:57 -0400 (EDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <9ef37430-17be-dfc2-bca5-e4e33bc68df8@google.com>
 <7ce6e14f-b2b1-19f3-916a-9ed1307a3403@jeffhostetler.com>
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d8740193-9f12-84f1-1d9f-cebd6125640b@jeffhostetler.com>
Date:   Fri, 17 Mar 2017 10:13:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7ce6e14f-b2b1-19f3-916a-9ed1307a3403@jeffhostetler.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/16/2017 5:43 PM, Jeff Hostetler wrote:
>
>
> On 3/9/2017 3:18 PM, Jonathan Tan wrote:
>> Overall, this fetch/clone approach seems reasonable to me, except
>> perhaps some unanswered questions (some of which are also being
>> discussed elsewhere):
>>  - does the server need to tell us of missing blobs?
>>  - if yes, does the server need to tell us their file sizes?
>
> File sizes are a nice addition.  For example, with a virtual
> file system, a "ls -l" can lie and tell you the sizes of the
> yet-to-be-populated files.

Nevermind the "ls -l" case, I forgot about the need for the
client to display the size of the (possibly) smudged file,
rather than the actual blob size.
