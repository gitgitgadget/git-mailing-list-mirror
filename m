Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD9A1F461
	for <e@80x24.org>; Thu, 16 May 2019 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEPXJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:09:45 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:59203 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:09:44 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id RPVMhQsg9WIpcRPVMhyO75; Fri, 17 May 2019 00:09:42 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=anyJmfQTAAAA:8
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=AMgbiCRiAAAA:8
 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8 a=LBdqEnOb79ycxjD7EhEA:9 a=QEXdDO2ut3YA:10
 a=u09W0hvIdLUA:10 a=YJ_ntbLOlx1v6PCnmBeL:22 a=cU_FsQMbVzznvpCqsfaC:22
 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
Subject: Re: [PATCH v3 2/2] Doc: git.txt: remove backticks from link and add
 git-scm.com/docs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
 <20190515224709.2936-1-philipoakley@iee.org>
 <20190515224709.2936-3-philipoakley@iee.org>
 <xmqqbm035fhx.fsf@gitster-ct.c.googlers.com>
 <d79d5e70-ec3a-c6ca-b23d-a44edf2579d2@iee.org>
 <20190516222204.GB11784@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d8f90604-a0de-a054-2af8-8aa33b07071c@iee.org>
Date:   Fri, 17 May 2019 00:09:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516222204.GB11784@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDxAB2zEBsMqimYOWNsbJa96vxDPbmiTYTjYEXS8ekPUpNp2iPYwimtxh/+NvNMV2PSxq172fYwQfrs7wZUDxKq8KvBiwfWyt5HgKUGy6Vz7aegOIPTG
 DdWvjo6tzkf5Ky/KaUaT1gzobBu77Zd2ATzyE75M8rFOtW2LNgxhBR57ZeRiSJRa5n5EHMhkFg8nzXya5Sq20UwN35seJrEHydbaA0zRohVrcAXQFOBeEPqF
 GGLmyDD7WYhDfdQMUl0nvedFV3uSn+hgIYflwmOMLqeIlHb77KSuj57+dvjXI4RH0rQnNEmLp+/4+tQDFntpPqkzXM4MkP3RWX3oTW5fYM/mfqMpPyDiR5qA
 wK4yVt7j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05/2019 23:22, Jeff King wrote:
> On Thu, May 16, 2019 at 12:25:47PM +0100, Philip Oakley wrote:
>
>>> Except perhaps for these to see what's there:
>>>
>>> Documentation/git-archimport.txt:	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
>> That domain is gone. Whole line should probably be removed.
> Heh, see:
>
>    https://public-inbox.org/git/20170420203441.mrlwbkqinub7m225@sigill.intra.peff.net/
>
> I left it to people who actually care about arch to clean up that line
> and figure out if there is some useful alternative.
>
Thanks. I'll sit on my hands on that one then (i.e. do nothing).
-- 
Philip
