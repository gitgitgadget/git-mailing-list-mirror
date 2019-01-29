Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EC71F453
	for <e@80x24.org>; Tue, 29 Jan 2019 02:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfA2CXU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 21:23:20 -0500
Received: from avasout05.plus.net ([84.93.230.250]:55064 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfA2CXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 21:23:20 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id oJ3Ugohm41cwCoJ3VgYazq; Tue, 29 Jan 2019 02:23:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ffiDNXYF c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=5-Zug_wmKHpAMMnqrocA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
 <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
 <20190129015207.6emajopy7xqmqo4j@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f107d853-da55-ddd2-191f-8157cd5a8edd@ramsayjones.plus.com>
Date:   Tue, 29 Jan 2019 02:23:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129015207.6emajopy7xqmqo4j@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMNInLMjNR3p7K0xsOdNcxpnHRTe6P8bKuSB9UExNGvTjP8US0QaDQab7bGQGE/FoVSnWxQDgWQVHHUr9omOj8mv7ihDHjxgpeUDJfhzii5+JtN/TZ8H
 mjTZjo5zQgEdrH3MGaCCvoOawHIRePfGsu7sbzofF3u8yralfFp4epztadW1i8wYP0QV+4eIDYSBLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/01/2019 01:52, Luc Van Oostenryck wrote:
> On Mon, Jan 28, 2019 at 08:13:03PM +0000, Ramsay Jones wrote:
> 
> Hi
> 
>> The dependencies for the 'sparse' package includes: libc6 (>= 2.14),
>> libllvm4.0 (>= 1:4.0~), libxml2 (>= 2.7.4), perl:any
>>
>> However, for git, we only need to build 'cgcc' and 'sparse', which
>> means we can forget about libxml (only used for c2xml), and libllvm
>> (only used for sparse-llvm/sparsec/sparsei). Also, I'm not sure what
>> perl is doing there ...
> 
> perl is only used as the interpreter of cgcc.

heh, yeah (palm-face), I was only thinking about _build_ dependency! :-D

ATB,
Ramsay Jones

