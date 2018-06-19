Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F651F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966747AbeFSUe4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:34:56 -0400
Received: from mout.web.de ([217.72.192.78]:47747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757263AbeFSUez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:34:55 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfqEy-1fsQV915DY-00NA89; Tue, 19
 Jun 2018 22:34:47 +0200
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
 <6ab94453-84ef-e269-c320-e102b02d6f3b@web.de>
 <20180619191156.GA21641@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <385b429e-5d57-91c0-054c-0f04c59538e3@web.de>
Date:   Tue, 19 Jun 2018 22:34:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619191156.GA21641@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zaSf6YR8eKL1U1kOQ7LJuz8t9QL3kQifQVq64z9hgkX8g80xN58
 C4XRqiEW7SFeIr8itXLoXYJ3LSXw691iAucdyqCQHCmCTN0EV6itlRTPAKwHJ7SlJEAYXKN
 OQgRw0MKtv8wrYVQpRrQwdbj9uhp3kZOkC/MdOpWEzQ3jaCkiL+/2LWx6VyijyMUAdFsatv
 GlHX3t1N6ITzTPzvAuN7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S4+dCjpQwUQ=:ivxFM9MocTPwyN7SdLJFB+
 rLhVxFZkV7TiY1gzCz8XOHn9ldVXI8LxcyXnQ55gDrSTx+VOcBWdIqJOVuBlmg8ADbJsHfo8P
 u/r8g0S/AzK4d+TFEwvGuVcwDQA5V5TWjCfqTVOIRjm9vFM3inpglKxUiI5665ZlhsAfr73LE
 nSMeFmU096btxMkFNJRUi/0YfrG2aPmkoLxSljUpWeAqddebRBoaFaPHmlVGmv1dQ/PJddrS7
 N986+wAXOSpv1ByCFn5C3g5okHdvh+Zx1qbLur7wkJ4RXf5jp7us1CH90brMaKGR3vn0QGYgq
 x28QN94nRaN3SGcMw4LhYJPmglxqQzLJckDzknTobsTw52hjavBJSC/60NaueK9lO3UZwY2CU
 gq/yNQcvLKshLmZg+vR5AGkCJNGNMitOV9uxge3c3caOLFSo0cbaaXjr7evB85UujRhTAPoTk
 WNgS/nbvu6yF5YV2F3/cDz7E7NTMQeBy+GDePjkDPi/dDaKVSSpgoCX5DEQEUib2OLRveUR9l
 HslEvWQOm9xj4rJVBv26h+zHn/LwAamaWNqT0SoJLoHx++EAKVc8XSTg9F5fVsGQT3pcBInaj
 pMGg1jSqBHZXblmjpNwUNcVUOHTHiWCvpqyBTr1THz4PT8fwRgzHgIiR3Fm9XRwO2098E7TdG
 ivtbQ4oPiAYW8g4vxUgkzm44fTf+Ja7tr+tYtL0O3EMxilUKiOsKd4JDOTlx0ENH0FSYI4mKY
 WOOMm7M1dKYSMeQkHwefkiDd3XL8RpsEkzDavQAOTd7qbl1yOGhGEG46K0p4zHfa+L4kF911u
 VhEUck4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 21:11 schrieb Jeff King:
> On Tue, Jun 19, 2018 at 08:50:16PM +0200, René Scharfe wrote:
> 
>> Negation causes the whole non-matching line to match, with --column
>> reporting 1 or nothing in such a case, right?  Or I think doing the
>> same when the operator is applied a second time is explainable.

(Not sure where that extra "Or" came from.)

> Yes to your first question.
> 
> Regarding the final sentence, yes, I agree it's explainable. But I
> thought that handling negation like this was one of the main complaints
> of earlier iterations?

That's possible -- I didn't read the full thread, and I didn't argue
for or against any specific behavior in this regard before AFAIR.

So let's see what your example does:

   $ git grep --column --not \( --not -e foo --or --not -e bar \) trace.h
   trace.h:13: *  #define foo(format, ...) bar(format, __VA_ARGS__)
   $ git grep --column --not \( --not -e bar --or --not -e foo \) trace.h
   trace.h:13: *  #define foo(format, ...) bar(format, __VA_ARGS__)

Impressive.  That expression is confusing at first sight, but showing
the first matching column anyway requires no further explanation.  I
like it.

René
