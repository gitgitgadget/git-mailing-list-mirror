Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8CE1F461
	for <e@80x24.org>; Mon, 13 May 2019 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEMWYo (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:24:44 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:26360 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEMWYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:24:43 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QJNBhxcFoniZTQJNBhqr4p; Mon, 13 May 2019 23:24:41 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=yfvn1nA9lu61BVH--AoA:9 a=QEXdDO2ut3YA:10
Subject: Re: How to exchange rerere/redo resolutions?
From:   Philip Oakley <philipoakley@iee.org>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
 <871s17xk79.fsf@evledraar.gmail.com>
 <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
Message-ID: <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
Date:   Mon, 13 May 2019 23:24:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfPR1wxLncsGukMxW8uCNFApX0hjBE0Fj5MXJkrckteCiByuayvsrt7qrQmxRHZL0fmBoViPffL28hIgOES8dPoDY4xyt2xdXgmSnsP5KWgAOYcgK+Zo2
 JviNh2B8PRMRcR/arqQAn50kRpKsCU58Dj6rfKKDbkZcLs0p7Exm3WmnFJKpsXdrBWCCrWErd5GuQm9ylUp3ToLOLEyZnuljZ1hafQU4mtLN2w4YELG0vQH6
 GlPY9HOb1XwLlJk2BAf/OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

On 10/05/2019 15:59, Philip Oakley wrote:
>> You can publish your merged branch somewhere, and others can use
>> contrib/rerere-train.sh to learn from the resolution.
>>
>> Supposedly, I've never actually used it...

Does the contrib/rerere-train.sh actually work? I'm reading the code to 
ensure I understand what rerere/redo is doing, and in the training it 
tries to detect MERGE_RR via L87

     if test -s "$GIT_DIR/MERGE_RR"

It's not clear if that is an internal implementation detail, or a 
mistaken use of a historic path name. Can anyone enlighten me?

> The tricky part is when the patch series doesn't apply so the conflict 
> isn't yet on any branch.. 
When copying patches across to Git for Windows, the conflict resolution 
can be tricky.
--
Philip

