Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A0C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239D260FC3
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhHKUcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:32:52 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:47467 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:32:52 -0400
Received: from [192.168.1.103] (089144221100.atnat0030.highway.webapn.at [89.144.221.100])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4GlM205zWdz5tlD;
        Wed, 11 Aug 2021 22:32:24 +0200 (CEST)
Subject: Re: Re* [PATCH v4] userdiff: improve java hunk header regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
References: <20210810190937.305765-1-tsdh@gnu.org>
 <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
 <xmqq35rhc5la.fsf_-_@gitster.g>
 <157a0c35-1c82-9a2e-3bcd-ae6059ec71bd@kdbg.org> <xmqqv94c9ddm.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <adb3a9cd-f5f6-5746-eb52-d12f6b88a995@kdbg.org>
Date:   Wed, 11 Aug 2021 22:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv94c9ddm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.21 um 18:04 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> + * When writing or updating patterns, assume that the contents these
>>> + * patterns are applied to are syntactically correct.  You do not have
>>> + * to implement all syntactical corner cases---the patterns have to be
>>> + * sufficiently permissive.
>>> + */
>>
>> IMO, as written, the comment falls short of suggesting that patterns can
>> be simple. How about appending "and can be simple"?
> 
>     The patterns can be simple without implementing all syntactical
>     corner cases, as long as they are sufficiently permissive.
> 
> perhaps?

Perfect! Thank you.

-- Hannes
