Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427071F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbdHIRU4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:20:56 -0400
Received: from mout.web.de ([217.72.192.78]:52007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752518AbdHIRUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:20:54 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzba-1dsCEg3Qn4-00DpnB; Wed, 09
 Aug 2017 19:20:44 +0200
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
 <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
 <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
 <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
 <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
 <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
 <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
 <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
 <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
 <xmqqh8xg7mhy.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <13394372-1494-6650-05ec-0122e02664d3@web.de>
Date:   Wed, 9 Aug 2017 19:20:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8xg7mhy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FTGMObxWOKjrtFPBiHQO1Kx00hCJJ7kLXJBTqfM5WJBseSY+YQA
 0wkR0aDabErQqYngjv8uBuxnYEaNjv308KozSn9WL1Fbcijykvss8k4CpoFTp+NlQ3jk4RC
 KYkkxgmod3YllLMStBjcCv/lvAJLgQQhC7IWrIPS4hfsutDZhzeXGh3pbromdgXIwS8sg+Z
 jqKrnVZkhHDxbJtCXIU2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ndJJUuWf0dA=:l/+Zk8bp5yUfrgemoK58K5
 DWENwY6k8gISixhTCTUELVplC+p+zgruzR838QG8I9tw0rIcgmEIpHBTRKOUfIkeGkaGfI7cD
 HiWuH4xIPS9A67UFsJqkeQHaAiU6Wy+voovzEO+vKg50qNZZ6iBF+CN/Un2nlMNNCex7yjwTx
 klED31CIf2qPcPKHIl5xKqWJ+iUcp68r0pVs84+YbsFFy2pmPHdy6U0jMlEzdGnU2rRBtOPuV
 pfqGEE8ckVhDUWB46RirI4w/keJr0vA+88esZC+zFGIlZCHh0Fd6k8Uh7NPdZ6yrOTEvjKLk2
 MBFUrfmGzAD2qHMR9BL0uNduB4GJygH1fXqJKW8UgMma9Vfizf2vX4QgsWG+sk3iV1hipLEl6
 bAhTgiwzNg27G0WYDW8St1H3RptCAQTt7tc1Xt3irA+Ui1fWh9wuy495/6ntomRkFKs9q3ktZ
 zXbo3iUVBgUE8rKyeY/7kjKUtRQ1WsP9oHFs4JaynQUAs295K/1vmtbwPCy96ckZZ1plBgcth
 BRP3nWnDZYfHqzrqVd/2SAWzU3V/1Geyd0SNmVRDY6R8GsaIFJ2JrQbPQ4loX2e7jLiahBs8r
 w9xzHIVe0lYMO0cB23Yao84O73eabi8mAm7jE5/yoNtnqDwznUD7FQPWKeTznZJafRgK4PV1G
 YtiecGwpYwiCh61H1XkzHbm4YemqkE/1IXdKTekYdlMxGYUUOn1BBmWqcEYVUwSy3dy8AOieR
 AakhQwfXvFmy1bi2TwDjA9L+1yWPdh9pmsZ++uWEqNmnPsL9iy/RuMOpy0/jcokdTW9FinKpx
 OEj8D+fSFZIO9UR4smrE6xJ6V/yOGASganj5TDd8S3fl5xrX18=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 18:07 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>>> In the face of unreliable segfaults we need to reverse our strategy,
>>> I think.  Searching for something not in the buffer (e.g. "1") and
>>> considering matches and segfaults as confirmation that the bug is
>>> still present should avoid any false positives.  Right?
>>
>> And that's not it either. *sigh*
>>
>> If the 4097th byte is NUL or LF then we can only hope its access
>> triggers a segfault -- there is no other way to distinguish the
>> result from a legitimate match when limiting with REG_STARTEND.  So
>> we have to accept this flakiness.
> 
>> We can check the value of that byte with [^0] and interpret a
>> match as failure, but that adds negation and makes the test more
>> complex.
>>
>> ^0*$ would falsely match if the 4097th byte (and possibly later
>> ones) is 0.  We need to make sure we check for end-of-line after
>> the 4096th byte, not later.
> 
> I do not have a strong objection against "^0{64}{64}$", but let me
> make sure that I understand your rationale correctly.
> 
> We assume that we do not have an unmapped guard page to reliably
> trap us.  So "^0{64}{64}$" will report a false success when that
> 4097th byte is either NUL or LF.  There is 2/256 probability of that
> happening but we accept it.
> 
> A pattern "0$" will give us a false success in the same case, but
> the reason why it is worse is because in addition, we get a false
> success if that second page begins with "0\0" or "0\n".  The chance
> of that happening is additional 2/256 * 1/256.  Worse yet, the page
> could start with "00\0" or "00\n", which is additional 2/256 *
> 1/65536.  We could have yet another "0" at the beginning of that
> second page, which only increases the chance of us getting a false
> sucess.

I demonstrated a lack of logical thinking and now you bring on
probabilities!? ;-)

There could be any characters except NUL and LF between the 4096 zeros
and "0$" for the latter to match wrongly, no?  So there are 4095
opportunities for the misleading pattern in a page, with probabilities
like this:

  0$                          1/256 * 2/256
  .0$         254/256       * 1/256 * 2/256
  ..0$       (254/256)^2    * 1/256 * 2/256
  .{3}0$     (254/256)^3    * 1/256 * 2/256

  .{4094}0$  (254/256)^4094 * 1/256 * 2/256

That sums up to ca. 1/256 (did that numerically).  Does that make
sense?

> So we are saying that we accept ~1/100 false success rate, but
> additional ~1/30000 is unacceptable.
> 
> I do not know if I buy that argument, but I do think that additional
> false success rate, even if it is miniscule, is unnecessary.  So as
> long as everybody's regexp library is happy with "^0{64}{64}$",
> let's use that.

The parentheses are necessary ("^(0{64}){64}$"), at least on OpenBSD.
It doesn't accept consecutive repetition operators without them.  We
could use "^(00000000000000000000000000000000){128}$" instead if
there's a problem with that.

René
