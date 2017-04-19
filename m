Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C571FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030607AbdDSSSu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 14:18:50 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:38684 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968832AbdDSSSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 14:18:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w7VcW3Q8tz5tlK;
        Wed, 19 Apr 2017 20:18:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3734E42C2;
        Wed, 19 Apr 2017 20:18:34 +0200 (CEST)
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a #!
 line
To:     Brandon Williams <bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-3-bmwill@google.com>
 <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org>
 <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
 <20170419155659.GA132229@google.com>
Cc:     git@vger.kernel.org, e@80x24.org, jrnieder@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ba722dbf-f1f1-fa9f-9fc2-57620e9e7b8e@kdbg.org>
Date:   Wed, 19 Apr 2017 20:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170419155659.GA132229@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 17:56 schrieb Brandon Williams:
> On 04/19, Johannes Sixt wrote:
>> Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
>>> Windows can only run scripts with a shbang line.
>
> Out of curiosity how did you have t5550 passing on windows then?  Since
> the first patch in this series fixes a that test which doesn't have a
> '#!' line.

I guess, I don't run it at all in my setup.

-- Hannes

