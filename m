Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EF21F803
	for <e@80x24.org>; Mon,  7 Jan 2019 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfAGL1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 06:27:09 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:38022 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGL1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 06:27:08 -0500
Received: from [192.168.1.12] ([92.29.14.220])
        by smtp.talktalk.net with SMTP
        id gT3igWOA1AGVrgT3igiPVV; Mon, 07 Jan 2019 11:27:07 +0000
X-Originating-IP: [92.29.14.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=iGBlNkCVnKJDjRvOkgwXUw==:117
 a=iGBlNkCVnKJDjRvOkgwXUw==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=nHQKa-zZioyFk7W9XugA:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <0797a920-32f3-aaaf-9321-528f78d980ae@iee.org>
Date:   Mon, 7 Jan 2019 11:27:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFDOF6TLbvHuxW9TXHRlm+zVHmfZcldZoBxLvmoZ6bEh9HV9vjnhUlgsPqrj2gDkPrF0gIWe7jbYv/EtRSgvBiAkgu0mifGj6lcLRRgkKP3S5GVdkYWe
 ZovSXcqaln1Wt7KdLoA/USFtutmxbJAWHTuDAvJUu+WEr5034c45T5m34cbLG6ZOkubB66v9lKIxelH09DurQgogB23mr1d6Aw4tAt2r0Omzo16svCU4eGYf
 aYsaaKBD6zJZUzB/4qjEOnbV5UJngV1EGLT5n3H6b8k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01/2019 16:45, René Scharfe wrote:
> Add and use a function for loading the entries if a loose object
> subdirectory for a given object ID.

The second part of the sentence 'a loose object subdirectory for a given 
object ID' does not scan for me. Is there a word missing?

>    It frees callers from deriving the
> fanout key; they can use the returned oid_array reference for lookups or
> forward range scans.
>
> Suggested-by: Jeff King<peff@peff.net>
> Signed-off-by: Rene Scharfe<l.s.r@web.de>

-- 

Philip

