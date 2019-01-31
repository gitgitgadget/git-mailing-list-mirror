Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D092D1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfAaSrA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 13:47:00 -0500
Received: from 0x63.nu ([109.74.10.199]:44698 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfAaSrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:00 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gpHMX-0006nx-Lc; Thu, 31 Jan 2019 19:46:57 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181208163647.19538-1-anders@0x63.nu> <20181208163647.19538-3-anders@0x63.nu> <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com> <87o99iwmjn.fsf@0x63.nu> <20190129165523.GA7349@sigill.intra.peff.net> <87pnsfkvk1.fsf@0x63.nu> <CAL21Bmmx=EO+R2t+KviNekDhU3fc0wjCcmUmbzLa14bb0PAmHA@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit value
In-reply-to: <CAL21Bmmx=EO+R2t+KviNekDhU3fc0wjCcmUmbzLa14bb0PAmHA@mail.gmail.com>
Date:   Thu, 31 Jan 2019 19:46:47 +0100
Message-ID: <87o97wll60.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Оля Тележная writes:
>> Oh my. I wasn't aware that there was a totally separate string
>> interpolation implementation used for ref filters. That one has
>> separated parsing, making it more amenable to good error handling.
>> I wonder if that could be generalized and reused for pretty formats.
>>
>> However I doubt I will have time to dig deeper into that in near time.
>>
>
> Sorry, I haven't read your patch in details. If you will be at Git Merge
> tomorrow, you could ask me any questions, I can explain how for-each-ref
> formatting works amd maybe even give you some ideas how to use its logic in
> pretty, I was thinking about it a bit.

No, unfortunately I'm not at Git Merge.

I think I got how the formatting work. But if you have ideas on how to
reuse the logic I'm all ears.

