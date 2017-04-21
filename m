Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37FE1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 06:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035835AbdDUGme (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 02:42:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60615 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1035831AbdDUGmd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Apr 2017 02:42:33 -0400
X-AuditID: 12074412-a4fff70000003a21-33-58f9a9cb4698
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F5.13.14881.BC9A9F85; Fri, 21 Apr 2017 02:42:20 -0400 (EDT)
Received: from [192.168.69.190] (p57906886.dip0.t-ipconnect.de [87.144.104.134])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3L6gH4a024974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 21 Apr 2017 02:42:18 -0400
Subject: Re: [PATCH] refs.h: rename submodule arguments to submodule_path
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170412200037.18752-1-sbeller@google.com>
 <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
 <xmqqy3uu7ee3.fsf@gitster.mtv.corp.google.com>
 <cb1dd8b6-3357-57ff-650d-c55a7eb38d34@alum.mit.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8b2ef70c-4064-f726-8752-5bb0a898ee7a@alum.mit.edu>
Date:   Fri, 21 Apr 2017 08:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <cb1dd8b6-3357-57ff-650d-c55a7eb38d34@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHtm5c8Ig/aD4hZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsEroy5DfIFf1kq
        Tv/6z9TA2MjSxcjJISFgItE0/yRjFyMXh5DADiaJZSu62UESQgIXmCSe7WDuYuTgEBbwlDjx
        wQ7EFBHwkmibWQxR/pRR4vSyP2wg5cwCSRL73p9gBbHZBHQlFvU0M4HYvAL2Ehef3GQEsVkE
        VCU2XbwEViMqECIxZ+EDRogaQYmTM5+A3cMp4CBx41wDC8RMPYkd13+xQtjyEtvfzmGewMg/
        C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREq5COxjX
        n5Q7xCjAwajEw3ti5Y8IIdbEsuLK3EOMkhxMSqK8Vzt+RgjxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4a2bC5TjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgvbYCqFGw
        KDU9tSItM6cEIc3EwQkynAdouP9KkOHFBYm5xZnpEPlTjLocc+59fc8kxJKXn5cqJc67H2SQ
        AEhRRmke3BxYmnnFKA70ljCvOMgoHmCKgpv0CmgJE9CSs34/QJaUJCKkpBoY23i7tX6Zb1mf
        taDBzsf+BM+pVxvb/4avnn5Ycrv2rI9eReUn/2V8d5Wa53zdPWLevQtTPKOqjVctDStNeLZa
        uEKk8GL/ho4Uh6W34wr9VtpeEzH28Amc6SRqlGc0Y2qp5mPd2m8ez09ecwg9sO9V4EI3n0Rf
        6cIV3HtT2v0n3bihvMDyv9QhJZbijERDLeai4kQA25168Q4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/21/2017 08:32 AM, Michael Haggerty wrote:
> [...]
> I've CCed Duy because I don't know whether he has more plans regarding
> submodule references [...] get rid of the
> `for_each_ref_submodule()` family of functions entirely.
> 
> So perhaps the code that this patch touches won't be around long anyway.

Oh yeah, he has done exactly that in his nd/prune-in-worktree patch
series. (I knew I'd seen that somewhere...)

So it seems that the argument renaming has mostly been overtaken by
events, though even after Duy's patch series there are a few `const char
*submodule` arguments that could be renamed.

Michael

