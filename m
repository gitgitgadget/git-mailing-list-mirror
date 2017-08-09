Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFA720899
	for <e@80x24.org>; Wed,  9 Aug 2017 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdHIGQX (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 02:16:23 -0400
Received: from mout.web.de ([212.227.17.12]:52225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752002AbdHIGQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 02:16:22 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB4X-1e8FAG3eav-00XIet; Wed, 09
 Aug 2017 08:16:01 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
Date:   Wed, 9 Aug 2017 08:15:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PHGgtptwiW8yNAnBOcFafCH5xndeHwR8I8Nsh5yzQyfX64CZ1Rg
 cidV1PBDpQNByH1aBfq1H1vYBSl8ZKDMudYd65bm5RtQVrySMUEq1A/kiTd+R+3xx7Il7j1
 iRwxZbpfkhRBwVXzLru096EGPEWqL3mbtcN1rwANQbYqA4bTtMgR8XhJfAWDZ2G0jf9PTgS
 W9/GFHOCle03LeeohPi8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VMl4Z/XiLaA=:7XCEIwCqK/lxw7fj3NnU0U
 66eamv2RPax+1A3VNuqm8xF8dbG6QtyizHp/BRi3WMHsp9CNwFb2JYomSqi5TR5ZCGlzXpGsB
 kymWpRkbCKH9xWzqk8Y6vxUR3Z4Ps05DA+FmSR/ltBUCch29pbRvTW4zYRGkQPZyjxbOmjPM5
 5NXB1IIYxAp0lsxL/4w60ccwG2G5t2jqU97MEIVXlPhV3eLU5jJXQf+91ih9h8sefupbLXrYQ
 K2NYNgYmxRur7CPI26Q+5zeP3i7eXArbLAvYGG0IhgH0d7E7Y7Xh2YdY5rzvhOea44m2jHZLw
 1oDOsWC26ttbsySB6ZIug0IfgbRQHfuFxyrf3KECCjMhe5kxgd9odiVPXfIU3nySOckRYotF8
 dJ353gNW78UWgumG9VhKmuN/pBq/tPQjdaiWDM2X3E7tQrcToetyblX/9R/ozPHBM2bEAwEyh
 LSKxGW8IaEagcOIgBkPZz5RsJWw9BIrCy4lnjs8KApzbtkfc+cPXQvqEE00zvdDJX7JkFsVlx
 98o93Vhp1LCzA/b/93bJJcQMXW5NkANa/7CTXmCtmTesSlP1cYbQ+cy7qdOdqHBbSwcLoWXHO
 euHXdI/WMKEa1sJAAsU4aRjUQ2WpiIiVQVWhswdh6gl705jbWI3U/x0t5HYznjDendmx06flG
 aZVZUmie+UEadysJa9k0M1WjSua2cSwndLrHYXrZBzob0dwcvFnzQRBCot1/Fn5jTOQ38a1iC
 xXjW7j6PItjqPMU5/3UJWr0QYFrXn7rjMXLg7uuy0JkVONBOjWfFRfOWQ3sV6gKypfYHbREfU
 Abrx5ytoRAgi17CFWd+tPQ5BWQPLSbF/cBab+LQWc+kio9cYBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 07:29 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
>>> ... but in the meantime, I think replacing the test with "0$" to
>>> force the scanner to find either the end of line or the end of the
>>> buffer may be a good workaround.  We do not have to care how many of
>>> random bytes are in front of the last "0" in order to ensure that
>>> the regexec_buf() does not overstep to 4097th byte, while seeing
>>> that regexec() that does not know how long the haystack is has to do
>>> so, no?
>>
>> Our regexec() calls strlen() (see my other reply).
>>
>> Using "0$" looks like the best option to me.
> 
> Yeah, it seems that way.  If we want to be close/faithful to the
> original, we could do "^0*$", but the part that is essential to
> trigger the old bug is not the "we have many zeroes" (or "we have
> 4096 zeroes") part, but "zero is at the end of the string" part, so
> "0$" would be the minimal pattern that also would work for OBSD.

Thought about it a bit more.

"^0{4096}$" checks if the byte after the buffer is \n or \0 in the
hope of triggering a segfault.  On Linux I can access that byte just
fine; perhaps there is no guard page.  Also there is a 2 in 256
chance of the byte being \n or \0 (provided its value is random),
which would cause the test to falsely report success.

"0$" effectively looks for "0\n" or "0\0", which can only occur
after the buffer.  If that string is found close enough then we
may not trigger a segfault and report a false positive.

In the face of unreliable segfaults we need to reverse our strategy,
I think.  Searching for something not in the buffer (e.g. "1") and
considering matches and segfaults as confirmation that the bug is
still present should avoid any false positives.  Right?

Thanks,
René
