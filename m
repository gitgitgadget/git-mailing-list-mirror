Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28682022D
	for <e@80x24.org>; Thu,  3 Nov 2016 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbcKCVJt (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 17:09:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17741 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932905AbcKCVJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 17:09:48 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8yK56Gt2z5tlF;
        Thu,  3 Nov 2016 22:09:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6977E14A;
        Thu,  3 Nov 2016 22:09:45 +0100 (CET)
Subject: Re: [PATCH 2/4] t0021: put $TEST_ROOT in $PATH
To:     Jeff King <peff@peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
 <d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org>
 <20161103204438.zfe653c2bsv3zqkx@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c77455b1-6621-cff5-c07f-97a247fa2eb4@kdbg.org>
Date:   Thu, 3 Nov 2016 22:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161103204438.zfe653c2bsv3zqkx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.2016 um 21:44 schrieb Jeff King:
> On Thu, Nov 03, 2016 at 09:40:01PM +0100, Johannes Sixt wrote:
>> We have to use $PWD instead of $(pwd) because on Windows...
>
> Thanks. I have to admit I remain confused about which one to use at any
> given invocation

No worries. It *is* complex, and I don't expect anyone who is not deep 
in the business to get this thing right except by mere chance.

> (I would have thought that switching to $PWD causes
> problems elsewhere in the script, but I guess file redirection is
> capable of handling either type).

Correct.

-- Hannes

