Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94902C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FAA613FC
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGBVnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:43:02 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:19140 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:43:02 -0400
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzQti-0004uC-9o; Fri, 02 Jul 2021 23:40:30 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <60df7ee3128d6_28bb2086c@natae.notmuch>
From:   martin <test2@mfriebe.de>
Message-ID: <74124ed2-2905-a167-90b6-9b289521ea83@mfriebe.de>
Date:   Fri, 2 Jul 2021 23:40:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60df7ee3128d6_28bb2086c@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 23:02, Felipe Contreras wrote:
>
>> If I was a committer on this project, I would have to be much more
>> convinced that there is long-term value in this series than appears on
>> the surface.
>   1. It doesn't affect anyone negatively
>   2. You don't have to use them if you don't want to
>   3. They don't affect your aliases, even if they have the same name
>   4. Everyone has aliases
>   5. Every SCM in history has had aliases
>
> What more would you need?
>

Well, it might be good if they were configurable.

core.built-in-alias=false
core.built-in-alias=true
core.built-in-alias=sw,rs  # switch,restore

Also, it can be debated if they should be on or off by default. (hence 
built-in)

If the setting is undefined, then if a user does
    git sw branch
It will print:
built in aliases are not enabled. Please run
   git config core.built-in-alias=true

That way no one is forced to anything, but they are easy to enable, and 
self advertising.

