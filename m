Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C24D1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 17:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdHVRKR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 13:10:17 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:24520 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdHVRKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 13:10:16 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xcH9z0kzJz5tlT;
        Tue, 22 Aug 2017 19:10:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B3B95271;
        Tue, 22 Aug 2017 19:10:14 +0200 (CEST)
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com>
 <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1708161429510.19382@virtualbox>
 <4a5f9d64-0709-b6b0-c398-6887f1f7f4c0@morey-chaisemartin.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <63e3ebea-ad4e-14d7-1170-594390af8e06@kdbg.org>
Date:   Tue, 22 Aug 2017 19:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <4a5f9d64-0709-b6b0-c398-6887f1f7f4c0@morey-chaisemartin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.08.2017 um 09:27 schrieb Nicolas Morey-Chaisemartin:
> (Sent a reply from my phone while out of town but couldn't find it so here it is again)
> 
> It's available on my github:
> https://github.com/nmorey/git/tree/dev/curl-tunnel
> 
> The series had been stlighly changed since the patch were posted, mostly to add the proper ifdefs to handle older curl versions.

This does not build for me on Windows due to a missing socketpair() 
function. But I am working in an old environment, so I do not know 
whether this statement has much value.

-- Hannes
