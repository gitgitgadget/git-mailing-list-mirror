Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4777E202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 10:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbdJUKOw (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 06:14:52 -0400
Received: from mout.web.de ([212.227.15.14]:56867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbdJUKOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 06:14:51 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfAro-1dQCSz0U12-00olel; Sat, 21
 Oct 2017 12:14:37 +0200
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
 <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
 <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
 <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
 <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <437f4e47-fcb1-ff8c-3c5a-fa9a5cecedfe@web.de>
Date:   Sat, 21 Oct 2017 12:14:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ciFRnoa/dbN+4kUdLwZg4ye0Jfr07tZcdo4PmND+ohRDiiypmjb
 M8kgS6C9yS/DnTm9uPx0j/DruAx8v68xdBCgm7dOqTdtSobFKIxaqCJY8cx69bPuozlgHiv
 AoZI3+DdKQkOE+Jg7DiZv6B0EUuz4vXZwbncvVozxtyEL3v1xNfnr1nPHcRCgb0JLVKKBws
 dLbiiBGBcPDSmdHjPF0Pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXapZI5AmBA=:aJ75x46FyvwKf+qoxgoPVZ
 3H+EXuSUgFcFG0BQCbpMHXkh2mvP9zc206lwR+4zlAtZGIzATJ4AD/Qsb/n9zrZhe+mrO8UFd
 oUYt2JwcocFfgbeP2wDNQv5PqM8WEqtDZpN/Tci4yTe3fOqs1EqA89SnzLs8dua5Y+Zsl/0Qt
 esqM4dOumj1r3B2aCFPOxg8GcQLBtg37elsDif9Jz0mL+rL1hJMtz4zgqfmQdtE9NnYJUVe3Y
 DxFkkkVqvK1LXZ/litFDNYHiiXzRqaT0vUiY44SHZkWgETpRJQcwub7RRCyzyTCpiZcledR+l
 G8WTSMrqH1i7muHWx+c5sdhXxp3OtMOAnMjJe7z7yxbrN+LSm2Ht9u09VTfuTmTsbRgXJKJTa
 bYQP6E43I2M0kIUklWyTqJBL10JDKIeNrzd6totGgl86N8pGCD6Riv/oOjeLLqzKR/FblpV16
 1f8VT35PAWR76mIz2lCJa3z/KoWMtdL06n8ix/87ZqNdMuLc+7cJHbiXwauBwCPp/V3hdm3Gy
 nFFkGy0+vnkDdrFl6ikoQP/U9QEEYsYiaOLtpP0E1ySDN7jwTVjvp2FwDy2m/1unlu+b1o0o1
 HY+xNacagXdm7r5BRZ6zpx6w/36IgzvYX5k0gvc5V2JePxmIyBLlrd5ewNJieiGJklNYNLY3Q
 nF1hBJo+43vNBz9xUROZgvgKcuc0s66Ds6E/yDPFKBHoVwwNvcuAZ30scOTrVzeFoxV0ueW4m
 sVkOvunIgHIb7HERnTOBLINhq+RGyRZ8Y6iVSZeog8hYL1HWrglluU+LS7sI/wCgdmu/bldgu
 amgFsou6s+QEg1gXPpApgh6R5hlEVfT/I+mFNnJMbXyQ3IHVyo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.2017 um 07:35 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> <shrug> It seems weird and inconsistent to me that the meaning of "-h"
>> depends on the position and presence of other unrelated options.

The position is relevant with parse-options for *each* flag for a
different reason as well: You can't put a flag after a non-flag.  I
find that more annoying, as it slightly but noticeable slows down
adding a flag to a previous command by requiring to navigate to the
middle of the line.

(I guess I should train myself to use Meta-b for going back one word
more often..)

> I may be biased as every time I think about this one, the first one
> that comes to my mind is how "grep -h" (not "git grep", but GNU
> grep) behaves.  Yes, "-h" means something else, but by itself, the
> command does not make sense, and "ls-remote -h" is an exception to
> the rule: most sane commands do not have a sensible semantics when
> they take only "-h" and nothing else.  And even for ls-remote it is
> true only when you try to be extra lazy and do not say which remote
> you are asking.
> 
> And that is why I think "'cmd -h" and nothing else consistently
> gives help" may overall be positive in usability, than a rule that
> says "'cmd -h' is for short-help unless -h means something else for
> the command".

FWIW, I use "-?" for that everywhere.  I have yet to find a command or
environment where it does something dangerous.

René
