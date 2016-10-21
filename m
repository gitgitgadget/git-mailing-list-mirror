Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E48220229
	for <e@80x24.org>; Fri, 21 Oct 2016 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936460AbcJUU2P (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 16:28:15 -0400
Received: from mout.web.de ([212.227.15.4]:65051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936439AbcJUU2O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 16:28:14 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MbQfs-1cGJjW1my4-00IiyF; Fri, 21 Oct 2016 22:28:06
 +0200
Subject: Re: Drastic jump in the time required for the test suite
To:     Duy Nguyen <pclouds@gmail.com>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
 <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
 <CACsJy8D-o8BeaV1jrL7ADXgVwJ=KwnBCHTCN_fuCGvS1VVpU6A@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <99efe668-d459-0f8d-907c-9f212b24fa03@web.de>
Date:   Fri, 21 Oct 2016 22:28:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8D-o8BeaV1jrL7ADXgVwJ=KwnBCHTCN_fuCGvS1VVpU6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BamgNfzgNxS/bQNx4QHdrTzsy4c9BrchYLluPko2lki4s3iqIy8
 /Q6iF/5+1RCOai4TDJ/vrbtRf4w+AG5SHuVVQYmgVZ+ciDOQDejtZ8mEJbp/dpS5UuCxP/4
 cyFLbFuxGldoUe1RyMIwE6IPWrcYEUnrHtZAUO3SwUEGre25GXoj70SQq5MxbA7asvWfD9G
 zrqPZpSz8mE3bcvqH/pig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n83HdCuGmbg=:O8ILqArLfIPdcjKrJxus1E
 pt6CLvlLwJpxTcvITWSJ/RjJQGCtHgbmy54sH+EU7f5EzOucztFtuhrV2PJ9FkVMriqU6mfbp
 gJOMLJEqBRFZQDwRm1+mmWZ8bGmZ10PKRNC5hVJEuyMhFW8EX+OU9buVJH2wip+6re82o7tyr
 TOVXegd8yY8fDofDhzdUBwYz9y8cZp5RubylOEts388zVAw+nfys0VjgQfw9j65OXETDvIwLW
 NCmeQ0/KfWOs1tf/C+L84N0o0E8/xRzi2WNJEEjB1Y/ZsSq+s0SnXGuC6AyJrwanU0f51gUUQ
 A6IWnAT7E60WKTKsRKrkFmhsqC5jaagR1n7e9iHOeMjIxpbTRvWz0AcbEEvNao4rsN3J8u2TM
 M5jVVKbEmWbYGPVa29cK3kSbLZ8nmY5GqjXP911uqfm3yTJNMJ5HaPK7pv5/tM1f7lwZnWLGx
 E+e8LCY/VP4ynQx8sAQRZABh4vjmOMgY4ZPFkpawONMAL2zW6h2HGwZYLu2KT7pcq2KjgNIRy
 73VNaUXhGUKtRK/wuxlTDL5tp8iSFCXHG1gN4pPznuw6u6r9mMaslPuKVChTisR11J4GdjMwg
 +kfaazCpt22hS1O/oR4s6td4Fs++ZfFuA05lvHc7Muxzc43t2kgotZAQRhYzTKBglFgtsXMw2
 sRfFQEyN6YR1h2BVxjhxFU6RaZ5ze5SzcLHbqmXB+hyIdUvNpYPXYNs3U6RUzzbKp0B4pZXUv
 b9ba7wXRBTSEvc3C0d6Zao8MA16MQV6nrjsp/EXVEEOSbMCloMlI+Q4kEtkp3oOMzdBwWycUE
 qzuqz9h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.2016 um 12:59 schrieb Duy Nguyen:
> On Thu, Oct 20, 2016 at 11:40 PM, René Scharfe <l.s.r@web.de> wrote:
>> I get this on WSL with prove -j8:
>>
>> Files=750, Tests=13657, 906 wallclock secs ( 8.51 usr 17.17 sys + 282.62 cusr 3731.85 csys = 4040.15 CPU)
>>
>> And this for a run on Debian inside a Hyper-V VM on the same system:
>>
>> Files=759, Tests=13895, 99 wallclock secs ( 4.81 usr  1.06 sys + 39.70 cusr 25.82 csys = 71.39 CPU)
>>
>> All tests pass on master.
>
> Thank you for doing this. 10 times slower is probably not worth
> following up (though absolute numbers still look amazing, you have
> some beefy machine there).

Thanks, but it's not too impressive: Xeon E3-1231 v3, Crucial BX100 SSD, 
8GB RAM.  I wonder how much faster a brand-new CPU with more RAM and a 
PCIe SSD would be..

René

