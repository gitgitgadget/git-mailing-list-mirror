Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E20207BD
	for <e@80x24.org>; Wed, 19 Apr 2017 05:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759587AbdDSFna (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 01:43:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:50774 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759552AbdDSFn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 01:43:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w79sC1XFlz5tlB;
        Wed, 19 Apr 2017 07:43:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7C38542B3;
        Wed, 19 Apr 2017 07:43:26 +0200 (CEST)
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a #!
 line
To:     Brandon Williams <bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-3-bmwill@google.com>
Cc:     git@vger.kernel.org, e@80x24.org, jrnieder@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org>
Date:   Wed, 19 Apr 2017 07:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170418231805.61835-3-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> Add a test to 't0061-run-command.sh' to ensure that run_command can
> continue to execute scripts which don't include a '#!' line.

Why is this necessary? I am pretty certain that our emulation layer on 
Windows can only run scripts with a shbang line.

-- Hannes

