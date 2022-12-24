Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93748C4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 13:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiLXNcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXNcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 08:32:05 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF8AB874
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 05:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671888716; bh=CxtilJVXUafqISaC6amt+pPJikKQOcxhC0gWyzwvISg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V6ShV5hx8wUSxy2Tz46Pn3OJ5fVOMZKGheBAeQrdXwdnlVdKr3thw8SoM6Ch+fWxn
         4guXg/bX55Mr09ZJEkjm+y1Cf2j7B2bygPnVAUYM7jbCcgitqdr6EzIoc3BEG4P7mp
         FXjpoKVhZpuviHbiNhEfiLBB+uin7pumdm4cIvNqVPOHkjo8mAbXpYuntrMorSPnIK
         m5MC2kaj5umoqSZ4QLeUYTJdOqQVh9f+MNDU0vXmKgpJanRn7fx4gON8UKFyGa7jIt
         ltLFOVUzhhVWlZT5J52QvW2pteqQX30kpAl0xqCNVAopDmJdLh9NhTLAXvOqnbpGMk
         wlVpQ9kGcZx0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1onu9g2pDQ-017ayK; Sat, 24
 Dec 2022 14:31:56 +0100
Message-ID: <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
Date:   Sat, 24 Dec 2022 14:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <xmqqpmcqv7qh.fsf@gitster.g>
 <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr> <xmqqa63ss3fl.fsf@gitster.g>
 <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de> <xmqq7cyksy88.fsf@gitster.g>
 <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7fXLtp/L7PMRylTeYaTTzfE1fBikTqEkKJ7Rjd7OJbJF6wBj6IS
 bu2LuDtWsLkLnXwZuhMYwNkFgDXpteH2cpzyI4QixdiNAP8ytaWMsdp8GLWmza/Nlz89w73
 4eJm2fzXQaQxZlSuFOEjSuuVYtPb1FizocVPslfXVJuBl6vuFkLHhnIRdUBEIO1H3/T/xJs
 6gnXsZ+xo7NzU8XrU+eZg==
UI-OutboundReport: notjunk:1;M01:P0:hbf284dI57M=;8h/zbruMnXwU2MNRzRMLwm04AJe
 iAxdN75Q2a7VUW/mfhIaSAo9dOV0BgaNbfthdTddHWhqIlAqicM2IWtZpKHMhCiwYn86eAO2F
 M6c+Mboo6JxXZhPLHY10cfU9MpL43wZGdkorww3o0Z0b9Gdt5xcCEQ6GY3tmkrerogvNZMPlS
 WRaQy2/WLrlyY0aNjYzqBCZ2nsVdm9X4yJ/MutG6fCOzYIvdwz30NGpZIw5VP0lnpu7jRfom+
 Zdftz9vwQXp1UTpOga3XSJ7VKzLgtV4Krreb8u0XqSV+RszrvseGhNnfmp+eDXo2FMMDmzHG0
 Ejbadl3L5MvrOlf1tZBb5ugR7PPLPhTr+qbnTIw87RWBxC1MXjWPs/gobVhlw73453OZBGJaa
 QTsUDjHSDJNBK9Hx8fG/9HbFHiwTqVuMH1tgrLNb4+Dk+Xq8+L1o4EA1tfXKRD6HyuM+dl6IH
 lnA6xycdjksO3bgFTV0X667WZF1W6Wt8uZBFtmd5u/MM0CI8v0B6L34AICdeazcdbO0dOBZNQ
 XXRpaeSn3B0jTk6jyLOi0IwMe6sxvGOCizcVW15be93cuRNw0Gw5VlxjwTtfRHJKDbd3IHuzu
 qBrbnJr/1vPg5J3KE0CgGeg9ZxiSOgSmv9f7rzWGtX9GfB/suXiBf8vN0BeLJXUz+dy4apq1e
 YPpoq62swULdkSDAuYKnQkAKaDWRLw3Yg8zZvW+krvxmIW39npWEJuxthzz8uIz/RR0rfJxYs
 NcVLytBsSbOjthv20vaqOvd5ibUYoANDvktv8g1X1uRaRllvi/IDGFpnzXojd1VgVahrjnOfp
 lFs6NLGqEIiY9p5eROqv3PgIoPErrxwXXO1s+2zGt00+fhlV1dhsJzzXYhtsTZsm66lFCZpFl
 pzD/0kCpfDJffSJS0Ig/TIGNX67GBj22t0B4j7syT43NnG/URrqkzDeFYME9YQJjN7MdEDudf
 mp2iCQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.22 um 09:10 schrieb Johannes Sixt:
> Am 21.12.22 um 14:05 schrieb Junio C Hamano:
>> I know we have been operating under such a test environment, but
>> after seeing the exchange between R=C3=A9ne and J6t, I was hoping that =
we
>> do not have to keep being sloppy.
>
> Things did not turn out to be as simple. After ripping out all
> special-casing of GIT_TEST_CMP from a MinGW build, I notice at least one
> case that needs special treatment (it's `tar tf` that writes CRLF
> output).

That would affect t6132 and perhaps t9502, right?

How can I reproduce it?  I get only LF:

   $ uname -rs
   MINGW64_NT-10.0-22621 3.3.6-341.x86_64

   $ git archive HEAD Makefile | tar tf - | hexdump.exe -C
   00000000  4d 61 6b 65 66 69 6c 65  0a                       |Makefile.|
   00000009

Is there some configuration option that I need to set?

> On top of that, there are prerequisites SED_STRIPS_CR,
> GREP_STRIPS_CR and perhaps NATIVE_CRLF that should be reconsidered.

Ah, they are currently set based on the output of "uname -s".  Setting
them based on the actual behavior of the commands would allow the test
suite to automatically adapt to them being replaced by CR-preserving
variants.  With the current Git for Windows SDK the two prerequisites
would still be set, though, so tests would behave the same, right?

NATIVE_CRLF seems intended to track the macro of the same name, so it
probably makes sense to mirror config.mak.uname, but a test helper (or
"git version --build-options" line) that returns the actual value would
probably be more robust.

> For the time being, I suggest to take Dscho's patch.

The patch is intended to make comparisons faster.  That works for big
files, but the test suite compares small ones.   The total duration of
a test suite run is about one minute longer with the patch than without
it for me [1].  I retried with 7c2ef319c5 (The first batch for 2.40,
2022-12-19), and that's still the case.  Do you get different numbers?

Ren=C3=A9


[1] https://lore.kernel.org/git/31d3bf6c-c0a2-d2d5-c6e2-b185fde99170@web.d=
e/

