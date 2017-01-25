Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967501F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdAYAVE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 24 Jan 2017 19:21:04 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:51998 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdAYAVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:21:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id C723F1E186C;
        Wed, 25 Jan 2017 01:11:51 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3paCzMwk3rK4; Wed, 25 Jan 2017 01:11:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 4686F1E2CF2;
        Wed, 25 Jan 2017 01:11:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zB35psvDIPgm; Wed, 25 Jan 2017 01:11:51 +0100 (CET)
Received: from [192.168.178.31] (aftr-185-17-206-134.dynamic.mnet-online.de [185.17.206.134])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id BD0671E186C;
        Wed, 25 Jan 2017 01:11:50 +0100 (CET)
Subject: Re: [PATCH 7/7] completion: recognize more long-options
To:     Stefan Beller <sbeller@google.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
 <20170122225724.19360-8-cornelius.weig@tngtech.com>
 <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <967937ff-e5ff-2515-2f50-80a96683c068@tngtech.com>
 <xmqqd1fcca8n.fsf@gitster.mtv.corp.google.com>
 <a921bc92-4f20-3284-6577-344470a60c6f@tngtech.com>
 <CAGZ79ka0PSb9L71tkiacZS+FH=YbUBrQr6a5UQu7ochpihRqEQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
Date:   Wed, 25 Jan 2017 01:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka0PSb9L71tkiacZS+FH=YbUBrQr6a5UQu7ochpihRqEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/25/2017 12:43 AM, Stefan Beller wrote:
> On Tue, Jan 24, 2017 at 3:33 PM, Cornelius Weig
> <cornelius.weig@tngtech.com> wrote:
>> On 01/25/2017 12:24 AM, Junio C Hamano wrote:
>>> Cornelius Weig <cornelius.weig@tngtech.com> writes:
>>>
>>>>> Please study item (5) "Sign your work" in
>>>>> Documentation/SubmittingPatches and sign off your work.
>>>>
>>>> I followed the recommendations to submitting work, and in the first
>>>> round signing is discouraged.
>>>
>>> Just this point.  You found a bug in our documentation if that is
>>> the case; it should not be giving that impression to you.
>>>
>>
>> Well, I am referring to par. (4) of Documentation/SubmittingPatches
>> (emphasis mine):
>>
>> <<<<<<<<<<<<<<
>> *Do not PGP sign your patch, at least for now*.  Most likely, your
>> maintainer or other people on the list would not have your PGP
>> key and would not bother obtaining it anyway.  Your patch is not
>> judged by who you are; a good patch from an unknown origin has a
>> far better chance of being accepted than a patch from a known,
>> respected origin that is done poorly or does incorrect things.
>> <<<<<<<<<<<<<<
>>
>> If first submissions should be signed as well, then I find this quite
>> misleading.
>>
> 
> Please read on; While this part addresses PGP signing,
> which is discouraged at any round,
> later on we talk about another type of signing.
> (not cryptographic strong signing, but signing the intent;)
> the DCO in the commit message.
> 
> So no PGP signing (in any round of the patch).
> 
> But DCO signed (in anything that you deem useful for the
> project and that you are allowed to contribute)
> 

Right, it's crystal clear now. What confused me was the combination of

> Do not PGP sign your patch, at least *for now*. (...)

and then the section with heading

> (5) *Sign* your work

So I didn't even bother to read (5) because I deemed it irrelevant. I
think if it had said `(5) *Certify* your work` this would not have happened.
