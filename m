Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA37D201A7
	for <e@80x24.org>; Mon, 15 May 2017 13:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbdEONOj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 09:14:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:55840 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933405AbdEONOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 09:14:38 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A6F6E8446D;
        Mon, 15 May 2017 09:14:37 -0400 (EDT)
Subject: Re: [PATCH 0/5] p0004: support being called by t/perf/run
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <543cd794-273f-9d11-b4cd-4d8dc8b6df96@jeffhostetler.com>
Date:   Mon, 15 May 2017 09:14:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/13/2017 11:55 AM, René Scharfe wrote:
> p0004-lazy-init-name-hash.sh errors out if the test repo is too small,
> and doesn't generate any perf test results even if it finishes
> successfully.  That prevents t/perf/run from running the whole test
> suite.  This series tries to address these issues.
>
>   p0004: simplify calls of test-lazy-init-name-hash
>   p0004: avoid using pipes
>   p0004: use test_perf
>   p0004: don't abort if multi-threaded is too slow
>   p0004: don't error out if test repo is too small
>
>  t/perf/p0004-lazy-init-name-hash.sh | 47 +++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 5 deletions(-)
>


Nicely done!  Thanks for cleaning this up.
Jeff
