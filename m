Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED451F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeJTD6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:58:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:45325 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeJTD6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 23:58:03 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 23:58:03 EDT
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4878A3F40F1;
        Fri, 19 Oct 2018 15:40:53 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:b142:7803:a30c:e413] (unknown [IPv6:2001:4898:8010:0:9a78:7803:a30c:e413])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 18FFA3F400E;
        Fri, 19 Oct 2018 15:40:53 -0400 (EDT)
Subject: Re: [PATCH 0/1] commit-reach: fix first-parent heuristic
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.51.git.gitgitgadget@gmail.com>
 <xmqqk1me3bw0.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c28702fa-f25c-08be-f061-1e5881e82f1a@jeffhostetler.com>
Date:   Fri, 19 Oct 2018 15:40:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1me3bw0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/18/2018 10:31 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> I originally reported this fix [1] after playing around with the trace2
>> series for measuring performance. Since trace2 isn't merging quickly, I
>> pulled the performance fix patch out and am sending it on its own. The only
>> difference here is that we don't have the tracing to verify the performance
>> fix in the test script.
> 
> Thanks for sending this separately.  What's the current status of
> the tracing patch series, by the way?
> 

I'm still working on it. I hope to reroll and submit a new version
next week.  We are currently dogfooding a version of it with our gvfs
users.

Jeff
