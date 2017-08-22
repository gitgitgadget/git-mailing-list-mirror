Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35621F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdHVSXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:23:00 -0400
Received: from 9.mo176.mail-out.ovh.net ([46.105.78.81]:56506 "EHLO
        9.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdHVSXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:23:00 -0400
X-Greylist: delayed 125753 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Aug 2017 14:23:00 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id B9022825AD;
        Tue, 22 Aug 2017 20:22:57 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 22
 Aug 2017 20:22:55 +0200
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
To:     Johannes Sixt <j6t@kdbg.org>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com>
 <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1708161429510.19382@virtualbox>
 <4a5f9d64-0709-b6b0-c398-6887f1f7f4c0@morey-chaisemartin.com>
 <63e3ebea-ad4e-14d7-1170-594390af8e06@kdbg.org>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <0851413b-b83a-7290-76d4-249a49eb30c9@morey-chaisemartin.com>
Date:   Tue, 22 Aug 2017 20:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <63e3ebea-ad4e-14d7-1170-594390af8e06@kdbg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS2.indiv2.local (172.16.1.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 8539387845739472861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtddtgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was sadly kind of expected...
I need to look for another way to handle this on Windows.

Thanks for the test

Nicolas

Le 22/08/2017 à 19:10, Johannes Sixt a écrit :
> Am 21.08.2017 um 09:27 schrieb Nicolas Morey-Chaisemartin:
>> (Sent a reply from my phone while out of town but couldn't find it so here it is again)
>>
>> It's available on my github:
>> https://github.com/nmorey/git/tree/dev/curl-tunnel
>>
>> The series had been stlighly changed since the patch were posted, mostly to add the proper ifdefs to handle older curl versions.
>
> This does not build for me on Windows due to a missing socketpair() function. But I am working in an old environment, so I do not know whether this statement has much value.
>
> -- Hannes

