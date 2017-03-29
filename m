Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377F220966
	for <e@80x24.org>; Wed, 29 Mar 2017 11:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdC2KpO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 06:45:14 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52181 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752080AbdC2KoS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 06:44:18 -0400
X-AuditID: 1207440d-041ff70000003721-75-58db90009943
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C3.56.14113.0009BD85; Wed, 29 Mar 2017 06:44:16 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2TAiE0Y017469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 06:44:15 -0400
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
 <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8eeadbe1-6a28-cee7-5dcb-5d408aac8925@alum.mit.edu>
Date:   Wed, 29 Mar 2017 12:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1GWYcDvCYMcLY4vHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Mm6e
        7GIuOMZacfLZAtYGxsMsXYycHBICJhK3Tm1j6mLk4hAS2MEkseHeYjaQhJDABSaJ1W+dQGxh
        AV+JhjNrgRo4OEQErCWur/GCqF/LKPFy5SJmkBpmARuJ4029jCA2m4CuxKKeZiYQm1fAXmLv
        nXVgcRYBVYmbLXPB5osKhEjMWfiAEaJGUOLkzCdgB3EKOEjM/N7JAjFTT2LH9V+sELa8xPa3
        c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKE
        BC/vDsb/62QOMQpwMCrx8O7IuxUhxJpYVlyZe4hRkoNJSZT3hOHtCCG+pPyUyozE4oz4otKc
        1OJDjBIczEoivPqKQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv
        Sh9Qo2BRanpqRVpmTglCmomDE2Q4D9DwgyA1vMUFibnFmekQ+VOMuhw3jh94wyTEkpeflyol
        zrsZpEgApCijNA9uDizpvGIUB3pLmPcGSBUPMGHBTXoFtIQJaIm4zS2QJSWJCCmpBkauBD2l
        NhZhZxbFzzf1Zu98PGOZf6jEVtY//75/MeK/KukT9fIOh0fii2ARe7t3zz+vl72WbPOkKFiM
        YXH1yjdlXZqvtapO3Jgn3++3asMG0ZdLpp2vsD/q6JXIN7vx6izvjhm7Kstsz4jfmrZttqPz
        32S9vE9mpoEvp5is/5wtf/5yv8tPrjolluKMREMt5qLiRADLH99vFQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 11:56 AM, Michael Haggerty wrote:
> On 03/29/2017 02:32 AM, Daniel Ferreira wrote:
>> [...]
> [...]
> The disagreement is not a surprise, because there isn't a corresponding
> coding error in the code below that returns the directory itself in a
> post-order iteration. The net result appears to be that there is no
> recursion at all into subdirectories when `DIR_ITERATOR_DEPTH_FIRST` is
> set. So due to this bug, we get neither a correct post-order iteration
> nor a correct pre-order iteration with the new option.

Correction: the second-to-last sentence should read "there is no
recursion at all into subdirectories when `DIR_ITERATOR_DEPTH_FIRST` is
*NOT* set.

Michael

