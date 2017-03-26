Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7897320958
	for <e@80x24.org>; Sun, 26 Mar 2017 22:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdCZWkk (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 18:40:40 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46996 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbdCZWkg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 18:40:36 -0400
X-AuditID: 1207440f-141ff70000003517-1e-58d8435ff1d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 21.30.13591.F5348D85; Sun, 26 Mar 2017 18:40:33 -0400 (EDT)
Received: from [192.168.69.190] (p579076D0.dip0.t-ipconnect.de [87.144.118.208])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2QMeT1a031780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 26 Mar 2017 18:40:30 -0400
Subject: Re: [PATCH v3 1/2] [GSoC] dir_iterator: iterate over dir after its
 contents
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
 <1490465551-71056-2-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c9b6276a-331f-f42e-94b4-bb38109485a4@alum.mit.edu>
Date:   Mon, 27 Mar 2017 00:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490465551-71056-2-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqJvofCPC4N4hdovHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Mmbe
        +cpa8Iq/Yt2vb4wNjM94uhg5OSQETCQePTzO2MXIxSEksINJ4k3PG2YI5wKTxPt9u9m6GDk4
        hAXCJOZsdwcxRQSsJa6v8QLpFRIol7jYN4cVxGYWsJE43tTLCGKzCehKLOppZgKxeQXsJZb8
        PwFmswioSqybOI8ZxBYVCJGYs/ABI0SNoMTJmU9YQGxOAUeJv59XMELM1JPYcf0X1Hx5ie1v
        5zBPYOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQI
        CV3+HYxd62UOMQpwMCrx8ApI3ogQYk0sK67MPcQoycGkJMrr6XA9QogvKT+lMiOxOCO+qDQn
        tfgQowQHs5II724WoHLelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv
        pRNQo2BRanpqRVpmTglCmomDE2Q4D9BwQZAa3uKCxNzizHSI/ClGRSlxXkeQhABIIqM0D64X
        llpeMYoDvSLMmwZSxQNMS3Ddr4AGMwENnr3hCsjgkkSElFQDowFPS86c5o4Q89N1fL6XruaW
        XXu9/XL3Yq37HhphfYb8kqlMF1oXH2eZHLy5t62vnvlev++D9em+1ZoXP148bplWH7xLpPOs
        xnb+SqUvV2f2syzU4WxP239nzsdAvZwfE25wrpwXOvF/3dVrco8q3SKvG7PU7Xv60OF3Q8gV
        Vy/xGrvf884cVmIpzkg01GIuKk4EAIGpQNgIAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/25/2017 07:12 PM, Daniel Ferreira wrote:
> Create an option for the dir_iterator API to iterate over a directory
> path only after having iterated through its contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18).
> 
> This is useful for recursively removing a directory and calling rmdir()
> on a directory only after all of its contents have been wiped.
> 
> An "options" member has been added to the dir_iterator struct. It
> contains the "iterate_dirs_after_files" flag, that enables the feature
> when set to 1. Default behavior continues to be iterating over directory
> paths before its contents.
> 
> Two inline functions have been added to dir_iterator's code to avoid
> code repetition inside dir_iterator_advance() and make code more clear.
> 
> No particular functions or wrappers for setting the options struct's
> fields have been added to avoid either breaking the current dir_iterator
> API or over-engineering an extremely simple option architecture.

This patch would be easier to read if it were split into two: one
extracting the new functions and changing old code to use them, and a
second adding the new functionality. As one patch, is is hard to see
quickly which changes have what purpose.

I also suggest adding a new `unsigned int flags` parameter to
`dir_iterator_begin`. I think that's more natural, because it doesn't
make sense to change the iteration order during an iteration. It's not
much of a problem to change the API given that all callers are in the
same codebase. If you were to forget to convert any callers (or if a
different in-flight patch series were to add a new caller using the old
call style), the compiler would complain, and the problem would be
obvious and easy to fix.

I didn't actually read the patch carefully yet because I don't have time
this evening to seek out the interesting parts in the long diff.

Michael

> [...]

