Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A8C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF426613F4
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhGBLYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:24:24 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:8943 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhGBLYX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:24:23 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 07:24:23 EDT
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzH8o-00086H-Tk; Fri, 02 Jul 2021 13:15:26 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
From:   martin <test2@mfriebe.de>
Message-ID: <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
Date:   Fri, 2 Jul 2021 13:15:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60def07e686c7_7442083a@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 12:54, Felipe Contreras wrote:
> martin wrote:
>> IMHO it would be good to (partly) follow other vcs, and have
>> commit = ci
> I'm fine with leaving co out of the default aliases if it's deemed "too
> controversial".
>
> But ci doesn't make sense. ci comes from "check in" which has no
> similitude in git.
svn uses it for "commit".
It can be seen as CommIt.

But of course other letters can be picked. I don't see an advantage in 
it though.
Like CoMmit cm ? or CommiT ct ? None of them seems any better to me.

> I don't think it's a good idea to leave "git checkout" without an alias
> (it's perhaps the second or third most used command), but at least some
> aliases are better than no aliases.
Well, that goes back to a bigger question. And from the brief time I 
have been on this mail
list, it appears to me there is a divide into 2 groups.

If checkout is really meant to give way to switch/restore then it needs 
no further
advertising. And then the current usage statistics are a relict from the 
before switch/restore time.

If on the other hand checkout is not just to be kept for backward 
compatibility, but should
always remain an equal alternative to switch/restore (i.e. it should 
still be taught to new
user in 20 years) then it wants to have a default alias.

