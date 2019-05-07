Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6B41F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEGKXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:23:07 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:56826 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfEGKXH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 May 2019 06:23:07 -0400
Received: from 200116b8467f8b0031021c7e41c85f0b.dip.versatel-1u1.de ([2001:16b8:467f:8b00:3102:1c7e:41c8:5f0b]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hNxFW-00038R-Hq; Tue, 07 May 2019 12:23:02 +0200
Subject: Re: [PATCH] make slash rules more readable
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190504101905.7522-1-admin@in-ici.net>
 <xmqqlfzilgrm.fsf@gitster-ct.c.googlers.com>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <6549e684-ac91-4a66-afa0-73c0e8c658f8@in-ici.net>
Date:   Tue, 7 May 2019 12:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqlfzilgrm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1557224586;8a2166ca;
X-HE-SMSGID: 1hNxFW-00038R-Hq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07.05.19 12:07, Junio C Hamano wrote:
> "Dr. Adam Nielsen" <admin@in-ici.net> writes:
> 
>> gitignore.txt: make slash-rules more readable
>>
>> Make all paragraphs valid, even if they are not read
>> in strict order. Make paragraph better understandable
>> for pattern without slash. Add paragraph for pattern
>> with slash. Be precise whenever a trailing slashes
>> would make a difference. Add some examples.
>>
>> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>>
> 
> Have you run "git diff --check" before committing the change?  It
> seems that many updated lines end in trailing spaces.
> 

Uh, I forgot that. I will send a clean version in a moment.

