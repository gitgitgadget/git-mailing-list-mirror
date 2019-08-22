Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118EC1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfHVSxA (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:53:00 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:63971 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfHVSw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:52:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46DtvV5VMyz5tlB;
        Thu, 22 Aug 2019 20:52:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A226F1D1B;
        Thu, 22 Aug 2019 20:52:53 +0200 (CEST)
Subject: Re: [PATCH] t0021: make sure clean filter runs
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org> <20190821145616.GB2679@cat>
 <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
 <20190821220355.GZ20404@szeder.dev> <20190822174901.GA71239@cat>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <79284459-d338-be91-5d13-8f06890f438f@kdbg.org>
Date:   Thu, 22 Aug 2019 20:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822174901.GA71239@cat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.19 um 19:49 schrieb Thomas Gummerer:
> Right, the above is why I think 'touch' is a good idea here.  Short of
> system clocks jumping around, which will most likely break more than
> this test anyway it guarantees that the timestamp is equal or greater
> than the timestamp of the index, which is what we need here.

Ok, thanks for the clarification. I didn't see the context. It looks
like touch is good enough.

-- Hannes
