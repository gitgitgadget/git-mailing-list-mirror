Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCAC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B3D613F8
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhGBVWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:22:39 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:14317 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhGBVWj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:22:39 -0400
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzKNr-0004gU-EQ; Fri, 02 Jul 2021 16:43:11 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <874kdcal1k.fsf@evledraar.gmail.com>
 <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com>
From:   martin <test2@mfriebe.de>
Message-ID: <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
Date:   Fri, 2 Jul 2021 16:43:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 16:15, Randall S. Becker wrote:
> On July 2, 2021 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
>> So aside from the "are these aliases good idea?" discussion, would 
>> you prefer if they're implemented that we theat them the exact same
>> way we do "git fsck-objects" and "git fsck"? I.e. list them twice in git.c, just pointing to the same cmd_fsck?
> Without knowing the full history of why the duplication, yes. That would be my preference. If it is a git command, it should be handled like one as closely as possible. Presumably, it also would show up in git help -a. I would not expect aliases to show in help.
>
But, if it is a git command, can you still overwrite it with your on alias?

As it was pointed out, some of those are used by people as aliases for 
other things already.
