Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21E0208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbdHJT6x (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:58:53 -0400
Received: from mout.web.de ([212.227.15.4]:62725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbdHJT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:58:53 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3PN2-1dOE9w1inw-00qxHo; Thu, 10
 Aug 2017 21:58:40 +0200
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
Date:   Thu, 10 Aug 2017 21:58:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:k0/l7DilJDcVe6ow6Dx6uZsx8iyNt1ms29sbAk06ri+ewDOqcPa
 JBEOFYvXae/lygfHR7iIi3m7TSfgLmA12bzsNl7+bNP7MY671Aueg4WURgTfoSRfKQLcIFP
 g+hL9YDPIzJLa4B6NWLiV2QoWiqWrfUrdRLkKob5yIm9yNKM7nJAtdpPdxyN1Q+vKFhoHgf
 jf3GsDM4cPygVy1v8VdhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sdVJAlzbfOs=:aNDfbxPPqv4n1Jk3lVgWN/
 qCTOnJNSGQ7+DywL/50THrOLc5mpPmHND4TQRUSIKgvpzOh3rTV0ySRCW5TWuW/2EnEl7oWYZ
 T0vlO5OvfRu0OBIYgD+KtBDk8P9gN20xIpL7m4YDYfZZ0rsGn0wDA8/yD5HAsOJA+aIuj4iXX
 4KRUK9AjknRgdOYVRrT51DxSS6Fl92XvAub4vF2+M9c1z9kWMTgTNjV3cJQlQWqo7yDJ8gW0D
 PPHuPkkTPA4ig+P13w7vnB8DW99C4aMF8/Sibk53gt4FWOc8F5MPsgaC45lFpqAOlDhm8PT9B
 iVxqAX9UQQVyIneFQ6S11qHOIFX0h/4Xafj9HLCVelsPJGsUipkn5VA1VdQnrFCmmOxjnGDnE
 ZkxQXYY16u7EYGLbv34EJnN0MccQhZ1Hf3AqHFe9n92K1MRMvmUNWLDiKiK94jqPvtwEoBglB
 r9K5FMkXbPUAzBRVXAru1DwCDX+zKDXau8CY5NOef5BfR3XO+B5xj8EVaIc7M3RO3QGU6yb6y
 wFOvCVOS3S900FStb8W2YUwYSxzMr0aiRFqvIgayXcWUbJBMgGPEdQ94qSHeK3wHFmGbNX7n9
 P8ej2ryS4kq/QE9PHSbdqtJsRK9ZY3oHhWsS3cctFaagGgxqEEZSUyatSf7m7ElcZdWsMVsxU
 tJGM6unCE2GV71S3oW/RmrC8EM9Sy/Y+jyTrIpQwYyEfvgG5but2NRkd7TaWgC3Lp9JKjC6//
 i2eIGLwitYrRcUquOP7QaM5iccr890HfGuBa3Q+XmPF98HUV6LKlByOeyV9xbLOz7UyKCjGD8
 4NISMC7pklfvYLPXRm9tdRwJXoIffLNv0grb8sG/VJiC//TSVc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2017 um 20:56 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> I doubt the type of file system matters.  The questions are: How much
>> main memory do you have, what is git trying to cram into it, is there
>> a way to reduce the memory footprint or do you need to add more RAM?
>>
>>> any recommendations on how to pin point the "offender"? ;)
>> Running "GIT_TRACE=1 git pull --ff-only origin master" would be a
>> good start, I think, to find out which of the different activities
>> that pull is doing causes the out-of-memory error.
>>
>> "free" and "ulimit -a" can help you find out how much memory you can
>> use.
>>
>> Also: What does "wc -L .git/FETCH_HEAD .git/packed-refs" report?
>> getdelim() is used mostly to read lines from files like these and in
>> the admittedly unlikely case that they are *really* long such an
>> error would be expected.
> 
> There is only one getdelim() call, which was introduced in v2.5.0
> timeframe, and it is used like this:
> 
> 	r = getdelim(&sb->buf, &sb->alloc, term, fp);
> 
> 	if (r > 0) {
> 		sb->len = r;
> 		return 0;
> 	}
> 	assert(r == -1);
> 
> 	/*
> 	 * Normally we would have called xrealloc, which will try to free
> 	 * memory and recover. But we have no way to tell getdelim() to do so.
> 	 * Worse, we cannot try to recover ENOMEM ourselves, because we have
> 	 * no idea how many bytes were read by getdelim.
> 	 *
> 	 * Dying here is reasonable. It mirrors what xrealloc would do on
> 	 * catastrophic memory failure. We skip the opportunity to free pack
> 	 * memory and retry, but that's unlikely to help for a malloc small
> 	 * enough to hold a single line of input, anyway.
> 	 */
> 	if (errno == ENOMEM)
> 		die("Out of memory, getdelim failed");
> 
> So the function is returning -1 and leaving ENOMEM in errno on
> Yaroslav's system.
> 
> I wonder if we are truly hitting out of memory, though.  The same
> symptom could bee seen if getdelim() does not touch errno when it
> returns -1, but some other system call earlier set it to ENOMEM,
> for example.

That can happen when the end of a file is reached; getdelim() returns
-1 and leaves errno unchanged.  So we need to set errno to 0 just
before that call.

Still *some* function must have run into a memory shortage in that
scenario, so adding/assigning more should help, right?

> If the same version of Git is recompiled there without HAVE_GETDELIM
> defined, would it still die with out of memory (presumably inside
> the call to strbuf_grow() in the strbuf_getwholeline() function)?

It's worth a try, if possible.

René
