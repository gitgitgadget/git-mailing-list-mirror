Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363E320248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfDEAoN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:44:13 -0400
Received: from avasout02.plus.net ([212.159.14.17]:51178 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDEAoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:44:13 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id CCxmhWb5r2SW5CCxnhTPDD; Fri, 05 Apr 2019 01:44:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=LD9D660Xg-Vb4MLUI2MA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 01/12] t5319: fix bogus cat-file argument
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232203.GA21839@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <69f35074-7f83-ea74-41be-c6ea079a9de8@ramsayjones.plus.com>
Date:   Fri, 5 Apr 2019 01:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404232203.GA21839@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP9HQoxvfnXeafPDJXIr1wgbLMgM3r2zEgClbAkQFMIXzkDHXOkIDLGPCu3QXXO8Lpxlmp6MAby9JG/R8AADKBeD6TzneQLeOvUeZNayaF/lO5RB2uT5
 un2xdVXdgMOLi8V6WcijNw6zAcXy7ezRk0mYq4h7qBOtutNgQw1triKHkOYYLwk4SWDSnclgRDHVxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/04/2019 00:22, Jeff King wrote:
> There's no such argument as "--unordered"; it's spelled "--unsorted".

Err, isn't this back-to-front? (i.e. cat-file has the _option_
"--unordered" but not "--unsorted").

I suspect that I am not reading that right! :-D

ATB,
Ramsay Jones

