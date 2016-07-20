Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2821F744
	for <e@80x24.org>; Wed, 20 Jul 2016 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbcGTPoU (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:44:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:44171 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbcGTPoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:44:18 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 53D2584638;
	Wed, 20 Jul 2016 11:44:17 -0400 (EDT)
Subject: Re: [PATCH v1 5/6] Add porcelain V2 documentation to status manpage
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
 <578F98BC.9060201@gmail.com>
Cc:	peff@peff.net, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578F9BC8.4040809@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 11:42:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <578F98BC.9060201@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:29 AM, Jakub Narêbski wrote:
> W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
>
>> +Porcelain Format Version 2
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +
>> +If `--branch` is given, a header line showing branch tracking information
>> +is printed.  This line begins with "### branch: ".  Fields are separated
>> +by a single space.
>> +
>> +    Field                    Meaning
>> +    --------------------------------------------------------
>> +    <sha> | (initial)        Current commit
>> +    <branch> | (detached)    Current branch
>
> I was wondering if all possible combinations are allowed.  It turns out
> that for technical implementation reasons it is not possible to have
> "(initial) (detached)".
>
> Just something I was wondering about, no need for any change...
>

Right. I don't think that combination is possible.  Not sure how
to document that succinctly.

Jeff

