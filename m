Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE342207BD
	for <e@80x24.org>; Sat, 22 Apr 2017 08:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1043141AbdDVIOK (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 04:14:10 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49571 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1042938AbdDVIOH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 04:14:07 -0400
X-AuditID: 12074414-071ff70000004f50-63-58fb10cd87cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 14.66.20304.DC01BF85; Sat, 22 Apr 2017 04:14:05 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M8E1f7005092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 04:14:03 -0400
Subject: Re: [PATCH v3 00/12] Fix git-gc losing objects in multi worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <024e7bbd-16ad-04e1-a565-ac7b150c11e4@alum.mit.edu>
Date:   Sat, 22 Apr 2017 10:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHtW4HeEQdMZY4uuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAlfG4im/WAsOMVfM7DzO0sD4kqmLkZNDQsBEou3JbZYuRi4OIYEdTBLbHl8H
        SwgJXGCSuPw1G8QWFvCUOHf5LlhcRCBNYvHk98wQNaYSm9bPYQNpZhbYxShx5vkdsASbgK7E
        op5msAZeAXuJu68PsoDYLAKqEhPav7CC2KICIRJzFj5ghKgRlDg58wlYDaeAmcTqN9fYQGxm
        AXWJP/MuMUPY8hLNW2czT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st
        0rXQy80s0UtNKd3ECAlskR2MR07KHWIU4GBU4uFlYP8VIcSaWFZcmXuIUZKDSUmUN+T3zwgh
        vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryT/gGV86YkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnN
        Tk0tSC2CycpwcChJ8F7m/x0hJFiUmp5akZaZU4KQZuLgBBnOAzTcEaSGt7ggMbc4Mx0if4pR
        l2POva/vmYRY8vLzUqXEeTmBKUVIAKQoozQPbg4sIb1iFAd6S5h3CcgoHmAyg5v0CmgJE9CS
        s34/QJaUJCKkpBoYrRbENlSHfpGo4SmzPmD0pabqNMfbV/a9b22+vYyuMuyY80RBdn+fAt+p
        Kdp9SWZCa6wjMtfyxk40XSdxsEP1nxXDawfuW3/WLTuwd73wD+Ef1iW71n1ttjyS8YA/UCWm
        NjQ07PuC3uQFO7gmP74yicnw2uPraXac3xh+7P6advzDxifP9DfZKrEUZyQaajEXFScCAHUV
        5mQjAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> Changes since v2 [1] is relatively small. It still needs
> nd/worktree-kill-parse-ref of course.

I read the whole series. Aside from the comments I made, it looks good
to me.

This will be able to be cleaned up once we have a cleaner distinction
between "logical" and "physical" ref_stores. But given the current state
of the code, your implementation is reasonable.

Michael

