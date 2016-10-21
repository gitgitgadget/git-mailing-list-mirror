Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314F420229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbcJUSot (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:44:49 -0400
Received: from avasout02.plus.net ([212.159.14.17]:41184 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbcJUSos (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:44:48 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id yJkk1t0030zhorE01JklKy; Fri, 21 Oct 2016 19:44:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=BnJ8Hq7HfQmhQC7nwKsA:9 a=M08BUaCgnTTxj-xf:21
 a=N5Uhb6llsmbVe2NI:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] t9000-addresses: update expected results after fix
To:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
References: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
 <20161021092024.15861-1-Matthieu.Moy@imag.fr>
 <xmqqh985d4x7.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3aa70781-e930-c7a9-c106-0268f82f6a5d@ramsayjones.plus.com>
Date:   Fri, 21 Oct 2016 19:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqh985d4x7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/10/16 17:48, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
>> e3fdbcc8e1 (parse_mailboxes: accept extra text after <...> address,
>> 2016-10-13) improved our in-house address parser and made it closer to
>> Mail::Address. As a consequence, some tests comparing it to
>> Mail::Address now pass, but e3fdbcc8e1 forgot to update the test.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
> 
> Thanks.

Yep, thanks for looking into this Matthieu.

I applied these cleanly (to both next and pu) and tested
on Linux and cygwin.

Thanks again.

ATB,
Ramsay Jones


