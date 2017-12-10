Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE4C1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdLJVO6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:14:58 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:46547 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdLJVO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:14:57 -0500
Received: by mail-wm0-f43.google.com with SMTP id r78so11157855wme.5
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1KCVGyPI3PQxBeetOCzGL3vCLaL/BZX1r4efOrZUzCk=;
        b=uCYrWIfjfPl3MXMfT8RZJMP/p0IjpGWbBpdnsFPYxBF8tBuBDsBuJBsRRKBAExJFqT
         mjO7T0AqarbszlrfhZex4jRXsMZDjfEe4n5bgOc+UjlkOf3xmDtdzg2WP6g+brBB8bzk
         ammQhMZu7jQwLtY3msd9wgebh98CoVn5ouiSRY9sO3sSA6e1dzPrAht/8Kq/m2Uf8RA4
         3gDUhjtUbZcwxo+WXuTb5OU9w3M8Qcoyi5doZDx6c7wZHjGAdlFBK6GAR5q34L4I9yJn
         Z4py/lOP2FKguR/9d4M7eDDYYXDDai7DST7xBgNq128bbW4LANpykjiFU6lngnyoFRQG
         H3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1KCVGyPI3PQxBeetOCzGL3vCLaL/BZX1r4efOrZUzCk=;
        b=PTfSeyF0zaU6LnLWTkoyQ3bKZodOE7VDjWYsEXK//aJQlCVu9XKaMeMz9MnCQ8cnHh
         1f/DUWay64IBOVuI6VWxTaodpEj04JSTy3B/MLRqDCEmNXKUWemMioRW6sXPOE/L0H0X
         KAxKlm09TLiHqiCTdmXYi4noPx+1qIe3H9jEZpduSrli08JjMr/GmvpIVVwlX/o99o/f
         QN8NdX9ls9IABwppxefnsq53hq+js1bldq9biNA2gPAjNDvtWCINOipi/df09HKuPty/
         q8bmU4WZyQ2gHzXGcu1ijp7pZYucy4paAh7BQRcouRT2BOQcjJjf7fORrqe2G0uSE+0V
         isbg==
X-Gm-Message-State: AKGB3mLZAmz5ryCr46mTRSP8mhtFVS2HVjGLn6GEh+evtgUgUHoUOvYa
        5zkgtXUfPecCvzWeDDqAwvwrR6Fq
X-Google-Smtp-Source: AGs4zMYi/264ipsvA7r1dqHloxcPjIvvOcHAbDYPVw0wm93qU38XBbkf8B3jUlTZiT1cfzkeAAq7yg==
X-Received: by 10.28.55.82 with SMTP id e79mr8476287wma.60.1512940496689;
        Sun, 10 Dec 2017 13:14:56 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id m127sm7327352wmm.48.2017.12.10.13.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 13:14:55 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eO8w2-00032z-K5; Sun, 10 Dec 2017 22:14:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t9001 failures on 32-bit Linux?
References: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com> <CACBZZX7+tTCNrLQzjh2dP-bnty3BegpaO+xrUqJQ7_Nh22JyDw@mail.gmail.com> <95fe2703-07b2-88a7-dfe6-c3c29cb565a3@ramsayjones.plus.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <95fe2703-07b2-88a7-dfe6-c3c29cb565a3@ramsayjones.plus.com>
Date:   Sun, 10 Dec 2017 22:14:54 +0100
Message-ID: <87374ie14h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 10 2017, Ramsay Jones jotted:

> On 10/12/17 20:33, Ævar Arnfjörð Bjarmason wrote:
>> On Sun, Dec 10, 2017 at 8:58 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>> I noticed the revert of the 'ab/simplify-perl-makefile' branch on
>>> top of 'pu'. So, I fired up my 32-bit Linux and attempted to see
>>> if I could debug this t9001 test failure.
>>>
>>> Unfortunately, I could not get it to fail. :(
>>>
>>> Both of the 'pu' (@77e921d77d) and 'pu~1' (@cfef1ebefd) builds pass
>>> the full test-suite and, likewise, running t9001 in a loop for a
>>> count of 100 (about 45 minutes run-time each).
>>>
>>> [If it makes any difference, I don't have sendmail installed (no
>>> /usr/sbin/sendmail or /usr/lib/sendmail), or any sendmail in my
>>> $PATH.]
>>>
>>> Sorry I couldn't help with this! :(
>>
>> It's a bug in my patch, I'll follow-up with a patch once I figure out
>> what it is, but for now I wanted to say it's my bad.
>>
>> That this is failing has nothing to do with 32bit per say, but that
>> system doesn't have Error.pm installed, so we fall back on our own
>> copy, there's some bug in the new Error.pm fallback logic I
>> introduced.
>
> Ah, OK, that makes sense.

Updated patch sent just now as <20171210211333.9820-1-avarab@gmail.com>:
https://public-inbox.org/git/20171210211333.9820-1-avarab@gmail.com/
