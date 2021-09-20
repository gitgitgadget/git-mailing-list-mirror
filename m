Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D1AC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5B460F5D
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhITOgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 10:36:09 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:10354 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231952AbhITOgI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Sep 2021 10:36:08 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id B70CF1BEBC;
        Mon, 20 Sep 2021 16:34:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id DE28B1BC6E;
        Mon, 20 Sep 2021 16:34:37 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e-yMpAK8jwGt; Mon, 20 Sep 2021 16:34:37 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 49B3F1B9FD;
        Mon, 20 Sep 2021 16:34:34 +0200 (CEST)
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <xmqqtuikrzca.fsf@gitster.g>
 <20210916223528.2910292-1-wesley@schwengle.net>
 <20210916223528.2910292-2-wesley@schwengle.net> <xmqq4kakrvdc.fsf@gitster.g>
 <287f826e-8fde-2c9a-ba66-a0a96e488b9c@schwengle.net>
 <xmqqv930qgi6.fsf@gitster.g>
From:   Wesley Schwengle <wesley@schwengle.net>
Message-ID: <d1a1953b-5c1c-c18e-3e58-5b13f50b8980@schwengle.net>
Date:   Mon, 20 Sep 2021 10:34:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv930qgi6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8 a=5rxgeBVgAAAA:8
        a=FuYM9yVTVoCpN0dvNDQA:9 a=QEXdDO2ut3YA:10 a=u09W0hvIdLUA:10
        a=5NxO59_FqQjEf5CpAN6O:22 a=PwKx63F5tFurRwaNxrlG:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/21 6:53 PM, Junio C Hamano wrote:
> Wesley Schwengle <wesley@schwengle.net> writes:
> 
>> I made a booboo. I did not run format-patch with the updated commit
>> message and commit. I saw it too late. You should have a new one by
> 
> That is OK.  Mistakes happen.
> 
> I'll slow down to avoid further confusion from mails crossing, but I
> have a feeling that you either forgot to read, or sent an updated
> patch before reading, the latter half of the message you are
> responding to.

I did the same thing, the patch is present in the thread at 
https://public-inbox.org/git/20210916224603.2912887-1-wesley@schwengle.net/

Cheers,
Wesley

-- 
Wesley Schwengle
E: wesley@schwengle.net
