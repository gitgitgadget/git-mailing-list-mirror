Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5C9202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdGLSZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:25:15 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:42995 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdGLSZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:25:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x76nN75T5z5tlN;
        Wed, 12 Jul 2017 20:25:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 79FAA135;
        Wed, 12 Jul 2017 20:25:12 +0200 (CEST)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
 <577e31a0-ecb2-d0a0-b259-b65b31116be8@kdbg.org>
 <20170712012631.o7jdced5hqkqzug2@genre.crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9e1e9c83-95b4-30ed-e391-1a09618abce7@kdbg.org>
Date:   Wed, 12 Jul 2017 20:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170712012631.o7jdced5hqkqzug2@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.2017 um 03:26 schrieb brian m. carlson:
> On Tue, Jul 11, 2017 at 07:24:07AM +0200, Johannes Sixt wrote:
>> I can revive the patches if there is interest.
> 
> I'd be interested in at least a pointer to them if you have one.  I
> think it might allow us to take advantage of desirable features that are
> in the intersection of C99 and C++.

See here: https://github.com/j6t/git.git  c-plus-plus

I do not think that there is a lot of intersection, though.

-- Hannes
