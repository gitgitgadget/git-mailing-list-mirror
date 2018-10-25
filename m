Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FDD1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 17:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJZBiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 21:38:05 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35539 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJZBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 21:38:04 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id Fj3XgFyXPO2g2Fj3YggIaK; Thu, 25 Oct 2018 18:04:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=2sTeQnkmm5jFPH-en80A:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 2/3] reset: add new reset.quiet config setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, peff@peff.net, sunshine@sunshineco.com
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
 <20181023190423.5772-3-peartben@gmail.com>
 <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
 <xmqqpnvyk4jc.fsf@gitster-ct.c.googlers.com>
 <xmqqbm7igyw6.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <47378681-3d7d-97fd-cf2a-4a0fe344a9e1@ramsayjones.plus.com>
Date:   Thu, 25 Oct 2018 18:04:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm7igyw6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGw9zqRVAw5f5HdlNzRYVKETdzG9LhQnfo+W4uy++QE4aKa133gGgDnJPqJDmiTULXBhypMfIjnzv5+Fya1zwDWcKGzpVxNF7rnPziB4b/DCalLSJ9gS
 bGoTJvRsYIsSFfCFVxd/p482m/qel/whYEYpWSE4xMvD9FB459LD6qfS0ba93/PkFiE42+msuj0WYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/10/2018 10:26, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> To be honest, I find the second sentence in your rewrite even more
>> confusing.  It reads as if `reset.quiet` configuration variable 
>> can be used to restore the "show what is yet to be added"
>> behaviour, due to the parenthetical mention of the default behaviour
>> without any configuration.
>>
>> 	The command reports what is yet to be added to the index
>> 	after `reset` by default.  It can be made to only report
>> 	errors with the `--quiet` option, or setting `reset.quiet`
>> 	configuration variable to `true` (the latter can be
>> 	overriden with `--no-quiet`).
>>
>> That may not be much better, though X-<.
> 
> In any case, the comments are getting closer to the bikeshedding
> territory, that can be easily addressed incrementally.  I am getting
> the impression that everbody agrees that the change is desirable,
> sufficiently documented and properly implemented.  
> 
> Shall we mark it for "Will merge to 'next'" in the what's cooking
> report and leave further refinements to incremental updates as
> needed?

Yeah, the first version gave me a 'huh?' moment (hence the
comment), the last version was better and, as you can see,
I am no great shakes at wordsmith-ing documentation! ;-)

Thanks!

ATB,
Ramsay Jones

