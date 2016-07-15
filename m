Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2041620195
	for <e@80x24.org>; Fri, 15 Jul 2016 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbcGONiY (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 09:38:24 -0400
Received: from mout.web.de ([212.227.17.12]:63045 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbcGONiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 09:38:23 -0400
Received: from [192.168.1.99] ([173.209.153.59]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M3SxQ-1b6FRt0Ysa-00r2KH; Fri, 15 Jul 2016 15:38:06
 +0200
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
To:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
 <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
 <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
 <20160714213222.GA20645@sigill.intra.peff.net>
 <xmqqpoqfonrx.fsf@gitster.mtv.corp.google.com>
 <20160714223843.GA22196@sigill.intra.peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <5b99a4bb-9b8e-e8c6-e214-e041209cb6e6@web.de>
Date:	Fri, 15 Jul 2016 15:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160714223843.GA22196@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iCDT0R2G+aZbCRPTA667oAF6RNjRcRwe6LEZI5CiIysijy5s8jZ
 k1KkOnrrs0CBgzAiwvPcp2gw+LVcMgGO7/BZg+saxFJ8jp0dlNdsuznPzQo8tOwe1Yb5L9Q
 n53GJcgeKUxmzG3kGC/6YcDyVrI18UwjbsFwaz2qGehYCjO2JrCu2STpoFwPdgqkiH+wcKw
 MXE9AK+b7a940GWGB9zPA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:JyDEVuTEAAg=:Hn4BuPeLlD8ISomQxui+Zq
 V7eEOj5RdL1eofHDkS26/S5FXI/KNRZPZlb37RTCSfpps10zlaOP4nMK9K4xczbbkL/5NpIU6
 VTDmynJyKyZzUOUdxrm6qKu5Mu1ES/+EWXdpjGgE5S1jwEkWRwnus0Lb3mkl7edPk//Ir4kxU
 1hmEUSMoTR0BSObWtuQHMTm7CV9bb5SbWgnS8xERdWqT6SHpZNxYaXMnyZ5Ifm1eGAr7ncq2b
 39I4wguGjbhHlBJmGj10UFnrD3YPAeP4Yz8kh4Nk3vIvhM9ZxJZ44HA/Hj1rpde6i9T6C3rEs
 +JOrF8HLDwxAg2q9F+gTv9JoJw76a+6yEK2IyMSwobWOXvclpXy/biCrHvm8Wgv2amex5T/UP
 4Mm/81C6C6Nwx17Vct8bTU6Wie9/rA3WwxrV0XoU41Ws1b5twWyKy3t9dScTPMF2GJAMn8pda
 Cpd24CVMwX+gkBmnRxXyXAeoxWqn+5Ii7wQ5JutNhaZEB+a05tsQbNLydFBT4tE30gKui8cg4
 D1/HJ5Df0AE6aRq6B2MX75YuhrILzleAKPHvgcFfRpxlhTQHSio4qzmk717serZBtVsv0wnW1
 PZOcr+IdY/+qmEjcFeiSQHjILX0TQPFHp2eO+Y83joubHMXI2uSgRjjUrcI1q5zP/NGVnd1sw
 ybUpieV6aGv/lYsLOJ7vS67yTLtNx47WdqUgejXsmvFwq5qocJ8ChaKaVK0iEBXObmrAHHvJr
 5WqAHVkyHodoX+oG2ko4h5ZeFFeeonczq1s4+IU7Y5vMwZuxjUyAOAIAJj0cA24Y/ZAkPtNLu
 RFxhC1E
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/15/2016 12:38 AM, Jeff King wrote:
> On Thu, Jul 14, 2016 at 03:30:58PM -0700, Junio C Hamano wrote:
>
>>> If we move to time_t everywhere, I think we'll need an extra
>>> TIME_T_IS_64BIT, but we can cross that bridge when we come to it.
>>>
>>> Likewise I think we'll need SIZE_T_IS_64BIT eventually (for real 32-bit
>>> systems; LLP64 systems like Windows will then be able to run the test).
>>
>> I guess I wrote essentially the same thing before refreshing my
>> Inbox.
>>
>> I am a bit fuzzy between off_t and size_t; the former is for the
>> size of things you see on the filesystem, while the latter is for
>> you to give malloc(3).  I would have thought that off_t is the type
>> we would want at the end of the raw object header, denoting the size
>> of a blob object when deflated, which could be larger than the size
>> of a region of memory we can get from malloc(3), in which case we
>> would use the streaming interface.
>
> Yeah, your understanding is right (s/deflated/inflated/). I agree that
> off_t is probably a better size for blobs. Traditionally git assumed any
> object could fit in memory. The streaming interface helps that somewhat,
> but I think there are cases where we still must load a blob (e.g., if it
> is stored as a delta). In theory that never happens because of
> core.bigfilethreshold, but you may get a packfile from somebody with a
> higher threshold than you.
>
> I wouldn't be surprised if there are other cases that aren't smart
> enough to use the streaming interface yet, but the solution there is to
> make them smarter. :)
>
> So off_t is probably better. We do need to be careful, though, when
> allocating objects. E.g., this:
>
>   off_t size;
>   struct git_istream *stream;
>   void *buf;
>
>   stream = open_istream(sha1, &type, &size, NULL);
>   buf = xmalloc(size);
>   while (1) {
> 	/* read stream into buf */
>   }
>
> is a security hole when size_t is less than off_t (it gets truncated in
> the call to xmalloc, which allocates too few bytes). This is a toy
> example, obviously, but it's something to watch out for.
>
> -Peff
That code is "illegal", it should be
  buf = xmalloc(xsize_t(size));

And the transition from off_t into size_t
should always got via xsize_t():

static inline size_t xsize_t(off_t len)
{
	if (len > (size_t) len)
		die("Cannot handle files this big");
	return (size_t)len;
}

There are some more things to be done, on the long run:
- convert "unsigned long" into either off_t of size_t in e.g. convert.c
- Use the streaming interface to analyze if blobs are binary
   (That is already on my list, the old "stream and early out"
   from the olc 10/10, gmane/$293010 or so can be reused)
