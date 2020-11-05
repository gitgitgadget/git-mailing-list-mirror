Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE2C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10EE20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgKEVBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:01:33 -0500
Received: from siwi.pair.com ([209.68.5.199]:12072 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKEVBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:01:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D29583F5FB8;
        Thu,  5 Nov 2020 16:01:32 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A984E3F5FB5;
        Thu,  5 Nov 2020 16:01:32 -0500 (EST)
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <cover.1604006121.git.steadmon@google.com>
 <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
 <20201102222020.GA1904687@google.com>
 <xmqqa6vyqgoc.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f7dfc2ee-673f-8386-299c-ddfbe984b04f@jeffhostetler.com>
Date:   Thu, 5 Nov 2020 16:01:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6vyqgoc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/20 4:22 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>>> So the value being passed between client and server over the
>>> protocol may look like `<sid1>/<sid2>/<sid3>` rather than just a
>>> single `<sid_x>` term.  For your purposes, do you want or care if
>>> you get the single term or the full SID ?
>>
>> I'm not sure we care too much one way or the other. A single component
>> of the SID should be enough to join client & server logs, but it's
>> easier to just send the whole thing.
> 
> It may be worth documenting this design decision in the protocol
> doc; even though protocol doc may say this should be treated as an
> opaque token, people may assume certain structure.
> 

good point.  let me make a note to revisit that text.

thanks
Jeff
