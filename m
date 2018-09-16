Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6F01F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeIPNJU (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 09:09:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:39683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeIPNJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 09:09:20 -0400
Received: from [10.2.0.3] ([79.218.121.221]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lbi2Z-1fYjiT1hX9-00lC1x; Sun, 16
 Sep 2018 09:46:58 +0200
Subject: Re: [RFC PATCH v4 1/3] Add support for nested aliases
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
 <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <aede75a5-d2ba-5a95-434d-aa70f7270fd7@gmx.de>
Date:   Sun, 16 Sep 2018 09:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:49x41rTLSPxiAaMN6fnPQVgczpc8lPMHoRkraPQn2qs9A23zT2T
 oVPEsMgdkNEes0vEIR7h8wU/ATLTbZldmSgDzxHoNXVc/2F4DPsAdI32NU/vxSIBfgsUrTr
 5Blnrj7aw6NuqA1q+22KOldyRviW7mMvB83LHUFvx6V9Kltr2UhB4/9YVlBwT1N3Z/OmVDn
 vAbFu0+3+bz54Kqhdr2xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ejhFQKRxQno=:odrNAe0OfVPlP77dserdja
 4krqTCCi0Uja9cFjfxvDA4NBbK2fu35TZLw85vDQjRzcEa65fEjl7O/Sa6MZ4YaaGUw5f5HLp
 uOb+KTokvXUdxe//+KF0KLFAK2gW67oSp5DIWBhijTU+vimmqUygvunJdPmTvJ+fdHEHNQiVt
 JhtCXznQFuX/BkqAFQn8DyBjnBHeEz2si3ut47wxbu6qzvxg2BzoChgBytGFVlJCl+nijc+Ja
 kQjoY+NfzgtHRGh2Gcex8dNlZw0qWV/V164z2E/bQz2gxSvexWhwKqtj3QRm2nwq3lDCDtJjh
 t/6aSNr0b8w1/+O67mdIJJpnk6re713SdvsGZWQMPgtCkn/hQbfYvRkr9HyLJ6wYMFgQN8jiI
 CFt5sCJ0xFlOZ6Q0sX2mkjyLIXHXQqGreGFcH0ZHoD8OK28KK1m86wYq89/jI0L+hfndJ9iX8
 OFDgXfjgYmJOz2MD7dizxXocXRLhARJuX4W0zTXQmJunsHazZ/3c7RUkJm9XgtS9OHbqQVc1e
 5s2GBT/RaldyRAEA9+8NIxd6HkUcfBDzxhmz1ZiGqingfFkL0E0KBxgl5fUxnX300ioMeJ9js
 3zy6AGLXaeAPtdJxBgT8zBTkmOnNvnWdeklsXglCEB8jInf53dqt3l12vnrgPaiFI7R8r/n2l
 +bcb1gh5wHt0Zl63CWpck33SiaR6amzlC2wuO1XlG9u5YZW6CxE5Kwk+XmPVA1nSRzQIoLz2m
 9iNrt39e1Gdbh9YD3E8vToi6+p1HqqOeYLTA6qWDMOmIU/7JPfM4DSQCoulg+yDP53hq2vBmy
 gV3hQIy6Euv8gmmIeljpOY+jI78rTJYxWvTcuGNIO/Sj2YUO1w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.09.18 15:28, Duy Nguyen wrote:
> On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
>> +               /*
>> +                * It could be an alias -- this works around the insanity
>>                   * of overriding "git log" with "git show" by having
>>                   * alias.log = show
>>                   */
> 
> I think this comment block is about the next two lines you just
> deleted. So delete it to instead of fixing style.

I think that comment is talking about the code that is handing the alias,
so it still would be valid.
The check might have peen placed in between to keep it logically grouped.

> 
>> -               if (done_alias)
>> -                       break;
>>                  if (!handle_alias(argcp, argv))
>>                          break;
>>                  done_alias = 1;
>>          }
