Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC5520133
	for <e@80x24.org>; Wed,  1 Mar 2017 01:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdCABg1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 20:36:27 -0500
Received: from mout.web.de ([217.72.192.78]:63996 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbdCABgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 20:36:20 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1cuTiG2uAQ-00NgUZ; Wed, 01
 Mar 2017 01:59:38 +0100
Subject: Re: [PATCH 0/6] Use time_t
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
 <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702282149160.3767@virtualbox>
 <6bd6ef64-2749-f17a-aea8-d25b147892c5@web.de>
 <alpine.DEB.2.20.1703010000260.3767@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <876bb673-ae8c-64bb-6a4d-385c84fb22d3@web.de>
Date:   Wed, 1 Mar 2017 01:59:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703010000260.3767@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:s/0qL7i2HM3EmEGfl3aPaDoparsleNcHXB66TTxDc3fFfuv+otS
 gbA4J6Mt5iq9eiewcGzFQuJgGE2HCKIGwVlX1CCEV/vE4BsZHLU2g7ftPhyd3Y0YssHG2pB
 r2TulT7D8K18d1R756ESjh1+0esKpy2bFSg1WjrYS83cdd+D9Hq66DzlUblY+TjypMm7J72
 sqbGo60OMd4xpu70xCvnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:53Gx2s1qbqE=:WSJ9Km5rJzM1mH+BnHm2cv
 b8xtGLqr6ksn+zXitdcozxWaFzijctCjBkoGFN3lJcmPEmbuRd+r3FEDilXlBWq3lUDaM5wyF
 0opCEDGy4/7DpLQwfDP3eq6K/MIgliAfNIRjo5dezGyRzDjALk0HiSLgfwnuHLGfrFYMMW2+C
 pJKKd8HWLKoKc4L+GzYuBh5OYgFdOUe524lITGwIYo9qEKJqYtUDq+HOdxxwlPXVVBtw5sabW
 8+pZJ7xYnM4qFK9Hrr3jiLqPO/pvvuKklwxWPi9ElcXJidcmARnBNchetHesP65DVP/75ExG4
 D1bUOJYQ/BURSlLTZmmEBI8+02kvzD442tbwcjImuHDAbkfMOd+eMxRw3x+mjB+xPpNDQLDDK
 5eNNARR8mL+G60LbwDdsHUE3tjf/rgyTtLbABZUGZCKbIvn0v1J9qfQ56TcEZTiouiGhPIj4N
 JxgOJ/K28/3ugBk+7X3xLnvj1AmRq9DckKkRIXiO2BgnKwpiOZVp8B+PYi/NV93jP3YILoACm
 Fs24DE2uTgA7SSHIffnnpONTpGgcayEb+tvBI3FgQjv5t8/NjlPWy5I5781kuRoqhXQ06Ko2e
 MopS/YstyAWPfhFdkT4pETJWul8YkMpfAgjTnWXnXRO9ySd8kLCsQRaLImm9RmFAw8vV4dSMS
 Xz9/KbZM+09/olbzI5HwolOGJNY50MR+Mo2gVVyMVmKtbLeC9knCo2nXvuVxckxonYPjIK/Ab
 x7UO/so6p9omTp24PgNWFoPXj+psjfJajSjRk1f2r7WFcIWsqXCnkzJY18jEW2l/8TQz4ho72
 0qjhxDy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.2017 um 00:10 schrieb Johannes Schindelin:
> Hi René,
>
> On Tue, 28 Feb 2017, René Scharfe wrote:
>
>> Am 28.02.2017 um 21:54 schrieb Johannes Schindelin:
>>>
>>> On Tue, 28 Feb 2017, Junio C Hamano wrote:
>>>
>>>> René Scharfe <l.s.r@web.de> writes:
>>>>
>>>>> Am 28.02.2017 um 15:28 schrieb Jeff King:
>>>>>
>>>>>> It looks from the discussion like the sanest path forward is our
>>>>>> own signed-64bit timestamp_t. That's unfortunate compared to
>>>>>> using the standard time_t, but hopefully it would reduce the
>>>>>> number of knobs (like TIME_T_IS_INT64) in the long run.
>>>>>
>>>>> Glibc will get a way to enable 64-bit time_t on 32-bit platforms
>>>>> eventually
>>>>> (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign).  Can
>>>>> platforms that won't provide a 64-bit time_t by 2038 be actually
>>>>> used at that point?  How would we get time information on them?
>>>>> How would a custom timestamp_t help us?
>>>>
>>>> That's a sensible "wait, let's step back a bit".  I take it that you
>>>> are saying "time_t is just fine", and I am inclined to agree.
>>>>
>>>> Right now, they may be able to have future timestamps ranging to
>>>> year 2100 and switching to time_t would limit their ability to
>>>> express future time to 2038 but they would be able to express
>>>> timestamp in the past to cover most of 20th century.  Given that
>>>> these 32-bit time_t software platforms will die off before year 2038
>>>> (either by underlying hardware getting obsolete, or software updated
>>>> to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
>>>> would not be too big a deal to warrant additional complexity.
>>>
>>> You seem to assume that time_t is required to be signed. But from my
>>> understanding that is only guaranteed by POSIX, not by ISO C.
>>>
>>> We may very well buy ourselves a ton of trouble if we decide to switch
>>> to `time_t` rather than to `int64_t`.
>>
>> True, and time_t doesn't even have to be an integer type.  But which
>> platforms capable of running git use something else than int32_t or
>> int64_t?
>
> That kind of thinking is dangerous. We don't know what platforms are
> running Git, and we have a very clear example how we got it very wrong
> recently, when we broke building with musl by requiring REG_STARTEND
> support [*1*].

In general that's true, and if nobody can add to the list (glibc: 
int32_t on 32-bit platforms, int64_t on 64-bit platforms for now; 
NetBSD, OpenBSD, Windows int64_t) then we shouldn't make assumptions 
about time_t that go beyond the C standard -- at least not without 
verifying them, e.g. with asserts or tests.  I'd especially be 
interested in hearing about platforms that use a floating point type.

Systems lacking REG_STARTEND can use compat/regex/ -- that's doesn't 
sound too bad.  (I didn't follow the original discussion too closely, 
and don't mean to open it up again.)

> So why gamble? If we switch to uint64_t, it would definitely provide the
> smoothest upgrade path. It is what the code assumed implicitly when we
> broke 32-bit in v2.9.1.

We can assume that time_t exists everywhere and is used by functions 
like gettimeofday(2) and localtime(3).  Why invent our own layer on top? 
  What would it be able to do that time_t alone can't?  I understand a 
need to handle times before 1970 for historical documents, but what good 
would it do to have the ability to handle dates beyond 2038, today?

Platforms that don't use the next two decades to provide a time_t that 
can store the current time by then will have bigger problems than a 
crippled git.

> If anybody really wants to support negative timestamps, it should be done
> on top of my work. My current patch series does not even start to try to
> address the ramifications of negative timestamps (see e.g. the use of
> strtoull() for parsing). It is quite unreasonable to ask for such a
> fundamental design change when it could very easily be done incrementally
> instead, when needed, by someone who needs it.

I'm confused.  Your patch series converts to time_t.  Why not use it? 
That would prepare ourselves for the bright future when we'll have a 
64-bit time_t in every libc. :)

René


