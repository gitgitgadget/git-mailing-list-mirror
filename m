Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619021F461
	for <e@80x24.org>; Thu, 16 May 2019 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfEPUqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 16:46:31 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15104 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfEPUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 16:46:31 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 454k3n3FDnz5tlD;
        Thu, 16 May 2019 22:46:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0705A20BA;
        Thu, 16 May 2019 22:46:29 +0200 (CEST)
Subject: Re: [PATCH] RFC: userdiff: add built-in pattern for rust
From:   Johannes Sixt <j6t@kdbg.org>
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
References: <20190515183415.31383-1-marcandre.lureau@redhat.com>
 <c8b6e9c6-12a4-c6dd-bea9-7f07c8af7d15@kdbg.org>
Message-ID: <aa6913d2-229e-096f-abdb-881f22821629@kdbg.org>
Date:   Thu, 16 May 2019 22:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8b6e9c6-12a4-c6dd-bea9-7f07c8af7d15@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.05.19 um 22:29 schrieb Johannes Sixt:
> Am 15.05.19 um 20:34 schrieb marcandre.lureau@redhat.com:
>> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
>> +	 "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
> 
> I assume that
> 
>        +e_1.ei8-e_2.eu128

Make that
	+e_1.e_8-e_2.eu128

> is correct syntax, but not a single token. Yet, your number pattern
> would take it as a single word.

-- Hannes
