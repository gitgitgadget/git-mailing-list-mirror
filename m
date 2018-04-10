Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EA61F404
	for <e@80x24.org>; Tue, 10 Apr 2018 13:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDJNhD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 09:37:03 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50536 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753258AbeDJNhA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Apr 2018 09:37:00 -0400
X-AuditID: 12074414-aa9ff700000073ca-f3-5accbdfbe5f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.F4.29642.BFDBCCA5; Tue, 10 Apr 2018 09:36:59 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC7F4.dip0.t-ipconnect.de [87.188.199.244])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w3ADat7Y024060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 10 Apr 2018 09:36:56 -0400
Subject: Re: [PATCH 07/16] refs: add repository argument to get_main_ref_store
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.us, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-8-sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d338f068-4ccd-292d-c65b-342fab4cd018@alum.mit.edu>
Date:   Tue, 10 Apr 2018 15:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409224533.17764-8-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0gTYRzHee5u2zk8O+d0T7MWHlQkzBQkDpSUCN2LMCEC25u63OVG25S7
        bWkRikODKSkmyZY1C1Ea+Wbmv0owm8HMLMySKSmZ2hBWofSPNLpzqHv3Ob7fzxeO54ejiocS
        NW6y2ljOypgpqRxTyE6maf8OT+gz3eE9tGu6AaH7J0/QkVAnoCf6mlC6oTUC6Hr3b4Tu7b2B
        0d7hSZCP67pDm4huyPNRpuvw23XT88sS3bpfo5tb6ceKpXp5roE1mxwsd/T4BbnROXsbVPyT
        Vj75Oo/VgBmJC+A4JLPhwGKKC8hxBTmIwK7aRhD9eItAZ3gGdYE4PIksgu6O+0BkJXkIun13
        pGIJJUcA7H7dLosarQD+6u5DxJaU1MIHjc4tJsg8+M73SCIyRh6Ebd+7pCInkyVw/s2aNNpJ
        hEH3EiZyHEnDlSn/FqPkYbhxbwqNsgrOLnmRKB+AA5F2tBmQnhjdE6N4YhRPjNIBMB/QMGa7
        RWthTGaeLdXypYzVynJaOsNismWwBrsfRF9EOQgCQc0oIHFAxRPNz1/pFRLGwVdZRsFeHKGS
        iadNE3pFwsVyQ5WR4Y3nObuZ5UcBxFFKSZh7hIwwMFVXWa58O0rFMUpFoNnDegVZxtjYyyxb
        wXLb6T4cpyAx9EwQEzm2jK28ZDLbdmMEjxPH44XxL2KH4CsYC28qi+bjIE2tIvKEE1KQYmC0
        W3fc7QtbBSrhV5IIp9iKF+5vx14VhhFh+OWprWEbsxupa4DaU9yzvvxYV2ifHTm97HVRyLns
        WvZIYUKzM73gbkv++5JjoRdjmrWMrsSNvuDnQOenH4sjA5bWQMvNa3U5sjMpOdUFbfVzlCPk
        C0dyUxG+YP/YwoxxSb1Z7/pW41iYHuerz2Ypc4qU/VPaK9f9t/7UBdxh/frPzNCH4KK3iMJ4
        I5OVjnI88x/LYtm/PAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/2018 12:45 AM, Stefan Beller wrote:
> Add a repository argument to allow the get_main_ref_store caller
> to be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
> 
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.

This seems OK to me from a refs perspective.

The macro trick is surprising. I guess it gets you a compile-time check,
under the assumption that nothing else is called `the_repository`. But
why actually commit the macro, as opposed to compiling once locally to
check for correctness, then maybe add something like `assert(r ==
the_repository)` for the actual commit?

But I don't care either way, since the macro disappears again soon.

Michael
