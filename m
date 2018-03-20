Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01C81F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCTK2a (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:28:30 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:29180 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeCTK2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:28:30 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1eyEA2-0008Io-31; Tue, 20 Mar 2018 11:06:30 +0100
Subject: Re: [PATCH v5 0/3] stash push -u -- <pathspec> fixes
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <adf6ff41-cc58-89fd-8703-d620babe0cd7@syntevo.com>
Date:   Tue, 20 Mar 2018 11:06:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319232156.30916-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.03.2018 00:21, Thomas Gummerer wrote:
> Thanks again Marc for all the testing and Junio for fixing up my brown
> paper bag copy-pasto.
> 
> This iteration addresses the breakage Marc noticed with the latest
> version of the patches, adds some more tests, and moves all the new
> tests to t3905 instead of t3903, which I just noticed exists and is a
> much better match for the new tests.
> 
> Patch 1 and 3 are the same as in the previous round, Patch 2 is mostly
> rewritten.  Instead of trying to avoid part of the pipeline we're
> using to get rid of changes, we now are getting rid of the 'git clean'
> call in the pathspec case, and use the existing pipeline to get rid of
> changes in untracked files as well.  I'm not adding an interdiff,
> because Patch 2 is mostly rewritten and the other two are unchanged,
> so it is probably easiest to just review patch 2.

Thanks, Thomas. All of my manual tests have been working fine now.

-Marc
