Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC82E1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfFMTTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:19:33 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:58831 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:19:32 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PtpT5ld2z5tlC;
        Thu, 13 Jun 2019 21:19:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D44234A87;
        Thu, 13 Jun 2019 21:19:28 +0200 (CEST)
Subject: Re: Reducing git size by building libgit.so
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
 <20190611234815.GB8616@genre.crustytoothpaste.net>
 <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
 <20190612233142.GC8616@genre.crustytoothpaste.net>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e37e5429-d66a-4cad-93b0-0dd849d4ce5c@kdbg.org>
Date:   Thu, 13 Jun 2019 21:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612233142.GC8616@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.19 um 01:31 schrieb brian m. carlson:
> [0] AFAIUI, Windows doesn't have RPATH-like functionality, and from what
> I've read, the same-directory behavior may be going away due to security
> concerns.  I don't use Windows, so any solution there is fine as long as
> Dscho is happy.

The solution is NOT to use DLLs on Windows. They are touchy and slow.

-- Hannes
