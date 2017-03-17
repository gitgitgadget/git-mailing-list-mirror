Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8406C20323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdCQFge (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:36:34 -0400
Received: from mout.web.de ([212.227.15.3]:55140 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdCQFgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:36:33 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbyZa-1cXd0m331K-00JGAq; Fri, 17
 Mar 2017 06:29:38 +0100
Subject: Re: Commiting files larger than 4 GB on Windows
To:     Junio C Hamano <gitster@pobox.com>
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
 <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
 <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
 <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net>
 <93ccf86d-0090-a311-9825-7e23fd6a4141@web.de>
 <xmqq4lyudyaq.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <2ebd249b-39a4-23c2-13e3-23c91a938313@web.de>
Date:   Fri, 17 Mar 2017 06:29:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lyudyaq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Fcpe+F+ht69pUvOGSFUcsav/5A11fbRrP5P8eWDIF0/J6+/6pOD
 Bhdl78D5GZidmet/MdlOhtaqAFNhZnDzAfyx/LTUWb3maG99VoHR4qWTv4Hr6UDJo27gQkb
 +E+q7CSN5RedqcBvN5wwKFVYRIu9zipYp/PUaLZ4NVoLEsKAZlKDkk2eMneM0CNZrocZoTv
 /RGPBsVVahisWbFxsDwBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OsEXFluUXoA=:36weFjTfvZts7uhDaGvgjx
 bj5VHX2J5qLeQ9EgGLuRhakyqcMr8/O5x28qMhvKLRYPOFPH85XBTcVQt5qki24id3/n7aRgU
 JoO+TF0gjf6Gi9lTlqANi3A9fCAltTqroWCAK5azn2Qps4lEH4VAkVPh0583zJfQsLqzrtJBt
 GP6PW4/5P6CGLzLc7sBea8y6QB0fNpOl3UhntNCZhjPsj8sr5POPSOsJrtFUaUVN9LY7bUSdA
 fRrzmFv1MoQwNwSy0rP4tpwnmcAubumfiIgf0fvFQ2deMBO+8sTXhZB7QClQ5SQc2vCMYiuJT
 ov5GaoFdHFuf6OoGIuMKKihRmYhsNOVHd6ceaJ9dWqH8Rg9Y0laA4KalHUFpiV2v3TyiBVXIo
 l12ErISYn1Q0IhxBZCT0E9lzt9B9qtQzEDx9pTG9hKkMmyK4IEg+tD5VyjN9EUdhxZc5/SGG2
 8yp7Yc/aBskpuNGXsltE9n2l4/UK6PDuA3nQ5uzWL8bgP3HGwoV/E665POXUGZCOGrEmzZaon
 BglDUk9Kei7BX1bdoVukvBRnOX+wY/h1FhCr7GVSN2KSGUax0oWZ8Dd69WrcPCrlSbNXoHLRf
 0A4DsIrod98xpuca6EnESE136O02llRVnBFqMk2h3dyXrJag9CqiSP0RbOZmDtWa9CRQHse01
 treiuvMqyaPjwp0MnAEv34ZD3y0Oen8ias+WCiUIUXuZBd9/QSTdPJFxN8uxy5P3GZL9MXcJt
 eE9TJkvWl2pQH8sovvuz1KKfrLnMmJ9vqJs31dHfV0ODdx1WNwxDiStfRkgMIS++5lDsThgtb
 yilhwlu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/17 22:29, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>> The real "show stopper" is at the end.
>> ...
>>
>> ==========================
>> And it seams as if zlib is the limitation here.
>> Unless we include the zlib source code into Git and redefine uLong,
>> is there a nice way around this:
>> ===========================
>>
>>
>> /usr/include/zconf.h:#  define uLong                 z_uLong
>> /usr/include/zconf.h:#  define uLongf                z_uLongf
>> /usr/include/zconf.h:typedef unsigned long  uLong; /* 32 bits or more */
>> /usr/include/zconf.h:typedef uLong FAR uLongf;
> Hmph.  Would ef49a7a0 ("zlib: zlib can only process 4GB at a time",
> 2011-06-10) and e01503b5 ("zlib: allow feeding more than 4GB in one
> go", 2011-06-10) help us here, though?
>
That is good news.
I tried to replace all "unsigned long" with size_t and got that compiling
without warnings under Windows 64 bit.

Compiling this on a 32 bit Linux gave lots of warnings..

Converting all unsigned long into is probably an overkill.
Some may stay, some may be converted into off_t, and some size_t.

Does anybody wants to pick this up?

