Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C0220951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdCQXJj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:09:39 -0400
Received: from mout.web.de ([212.227.15.4]:62898 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbdCQXJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:09:37 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6mgu-1c1bXY2DZs-00wSYR; Fri, 17
 Mar 2017 23:50:32 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Jeff King <peff@peff.net>
References: <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
 <ogwsaxvtiqlsiwojzxul@owpk> <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
 <tskgutqgpyszzedvyfra@prol> <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
 <ffntuqzgjgcfhebokbty@eduj> <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
 <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
 <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
 <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
 <20170317222902.isndsmzy43btxh4i@sigill.intra.peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d27d4fd1-8069-ec53-df3f-c3e176f83f16@web.de>
Date:   Fri, 17 Mar 2017 23:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170317222902.isndsmzy43btxh4i@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/tRt7ewUulFOLrT1Ypl3ZRYDQe/+4ea4xqsMUduPvxxjlyq12CM
 UZMYIpZ85xyiBUKuG7llwLNnADURfQ+X532iXJSWIjNxtlWPMUdGpwv4qVdKXo1GrOi6o3y
 bzKcraYBKXRTemlZcXmaSnbGnJ20+P/5sIHHsKYDAplYSylIq1UObeV+mJPd+Q4E1cqREqZ
 ufb0R/MGRzC3gUNGECJIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EPiol4BOqQc=:pJ46/sztzQQlP/Lpnvs5iN
 9aZehu1J81NeBO427xRPCWxz9HhPpuW8HLeZHsmlg6+GAE8qoLmlORnUVpI3qOxOqAEANsALB
 QUCZEF7DragOJU09UvqVM4Tw/JyFV9EHvjNIGRW9tOIBgrTje82oBONcGK4Wm+hLe4uIFgLZn
 MijR/kZTWcVGgiB4WAx+PYBdnuubzbebZ4JfpOG/vflh5UlV29TRzeBA/RaeebXXg80GPor5J
 gYohyJzlbWPLiy4waBHgZ5bRjc1RlRI68mfuwzxbelXlaZoyMaG/ALEtvrxENprP0rx2yx+Dy
 Jf5KHfgUOyF7RYrl2HqWVOi5vzFyJsSCq2YFH2rxBnIyBS8WfkZzm8Sdx8inKPsX7k7iSgqQv
 5la/05uYI1HK7zp4BbVYIBrlEhOM+VmO0XA5SbZK5rryVIadIX7yZrzbA9ZBi45Jg2OaFU1IN
 yYcN82DOfJJsuZC+L7nAR9IL+oSyo7ujoeYDbhuy0adeFhKVpmTv3C/Xtu2SbEcYIth6KApia
 Neh1RHHxM/Xd7+veWtrQGdE7EM5Tl/buUWbGiJdAiKLG7fm/jTqnwt09fopq2IBghs64a3wwK
 OFgDTGGXD+E258+UbbEd4wBY9bjJWOA+rlerossE7LnUiW3Wsop3lyYvVrOz0Y0RvNTvuuNTD
 EjpBQMZRCpVEnW0QAu049V6LboLmf0qWvqV+xx6nb4gUjok2Q2cUTneCq59u7sHtXK083Ey8g
 TeMBDGU/SdTbrNGu3qo532DeOtfV/wzYpqPVtW9NAaoF8TJNMfSq/0yknaLgAT/HZITZ455l7
 pqvMYW/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.03.2017 um 23:29 schrieb Jeff King:
> On Fri, Mar 17, 2017 at 10:07:18PM +0100, René Scharfe wrote:
>
>>>   As  an extension to the POSIX.1-2001 standard, Linux (libc4, libc5,
>>> glibc) getcwd()
>>>   allocates the buffer dynamically using malloc(3) if buf is NULL.  In
>>> this case, the
>>>   allocated buffer has the length size unless size is zero, when buf
>>> is allocated as big
>>>   as necessary.  The caller should free(3) the returned buffer.
>>>
>>> This sounds specific to Linux (though I am reading Linux man pages,
>>> which claim this; Also it seems I might have misread it as it also states
>>> "The pathname is returned as the function result and via the
>>> argument buf, if present.").
>>
>> I'm only interested in FreeBSD for now, as that's the platform Zenobiusz
>> reported the issue on and I haven't been able to reproduce it, so this is
>> still a bit exploratory, but hopefully getting closer.  This extension is
>> used in the first version of pwd(1) in FreeBSD's repo, comitted 1994-05-26,
>> so it was supported there basically forever.
>>
>> The oldest version I found that's using the extention is NetBSD's pwd(1),
>> which was committed 1993-03-21 and carries a SCCS timestamp of 1991-02-20.
>> Visual Studio .NET 2003 supports it as well.
>
> My big question is what happens on other platforms when they see a NULL
> (but 0-sized) buffer. Any reasonable implementation would just return
> ERANGE and we'd fall back to the existing code. But we often have to deal with unreasonable ones.
>
> So do we need a "my OS understands getcwd(NULL)" build knob?

POSIX specifies the behavior in this case as unspecified.  An 
implementation could offer a different extension, and e.g. return a 
pointer to a static buffer.  So the answer would probably be "yes" if 
this was a patch meant for public consumption.  For now it's only 
compatible with BSDs, Windows, MacOSX, Linux. :)

René
