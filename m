Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732D1201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdF3QmI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:42:08 -0400
Received: from mout.web.de ([217.72.192.78]:61984 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdF3QmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:42:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfYrH-1d6oL22m2l-00P62Y; Fri, 30
 Jun 2017 18:42:03 +0200
Subject: Re: git log use of date format differs between Command Line and
 script usage.
To:     Shaun Uldrikis <stuldrikis@gmail.com>
References: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7e7c7d22-36e2-20f4-0cfc-8cfe37d9a409@web.de>
Date:   Fri, 30 Jun 2017 18:41:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:B38dEKFHi6YYyZW4LxJVILi5juOCz4XtlAxKfs22Wuy7K3a9GcG
 AiDDlhCTqSnlzniD4sN2/7EC1bXYHV4u1V5rzL41jGSK0rxRqou5+nbhdXdPxtxLBa3yD4J
 5acwYKn1xuPr3nA+vY7yA28ThG4NK9eC0ESbH8w0Q9dQioqyieJW1TYXCTn7ilf8gn7qvJN
 uVdei8GPaHLsue2aTHFxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4W0nDn01NdQ=:qvnpTNMWCX076hq4a5mKkL
 RhBHV/UfYe+KKBihX8nWEJX3FNFoT9mFhiX5DQslaJ1+idPhLDVRQ3pt7SA74yVx3Crze6wwJ
 Ox3K5USSKheY6oeTQeKFX8L+oU6Uqitq9JZMdmW3tLHiH0nASYTE/yhD9AaOx0TsW+kJvy9OR
 w5y6oiGoR23Z8HXilKD7ciWbnY5E0miOL3iyxstNryC5gijv5KVBDf2zWyXflbQ5C1KkhXFwK
 eWB14pgKgB7JXOGVkg3ZX++NzrTIIow6pTRnvvmgvfzNR5g+v0jIAd3ridKCQw4YM/5K3FQgL
 AwcsrZHnQ1adXfnBc0MshrqatdzE2GyiaBUj2ORjUQyDBZXyu+ryCNfvMZ7ubxxqSYNLtE5wW
 Oii7n468A4wHCogqv71el8cqGlITCuj/mXCtNsQBoQlwHaMZnZO4pDVIekUfsgn4j3oT59OaC
 ocymfC1aI745GnOfflVKG6Rz3T8Cjk0POKgwUMsoFn1W2B6rAtjO3pDrcRrxPEuV6zArDlheE
 IWS3UYR/dZHUfw7PlpiuYkyNamdIKezXyVlxps4cug9OeZ7v8OmMsQM7FokCJF8V+GgJjcZ+I
 FZ9/z3Dtd5MRxRoHtlKwOShUKJV0VYnzURY6ZTMhPVAIzG4od4zoZAEAV6goXS9YRQvNA27We
 bImB4mf6la+UHf2mgT/AsQ7pU7KKdBIfo8sEULyTzb22v21tcROTmfaI8nxQJwAbWgT95EWU7
 j1CEva/p6EDLg+q9EvkV2yIOrQwHp247aj2DnarKW8dPjgSXKGWmKpp3Rj52kKtDcNhUHhNgn
 B6Hu+GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.06.2017 um 18:06 schrieb Shaun Uldrikis:
> If you supply a non-standard format to the date configuration for git
> log, something like:
> [log]
>          date = format:%Y-%m-%d %H:%M
> 
> then, when you run 'git log' inside a script, or when using gitk
> (anywhere), it fails on decoding the format.
> 
> fatal: unknown date format format: %Y-%m-%d %H:%M
> 
> 
> However, that format works correctly on the command line.
> I do not have a patch to address this issue.

I guess you have two versions of git on your system, and the one used in
scripts is older than 2.6.0, which introduced this feature.

René
