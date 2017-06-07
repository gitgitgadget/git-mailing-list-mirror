Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7861FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdFGQOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:14:51 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32858 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdFGQOu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:14:50 -0400
Received: by mail-io0-f176.google.com with SMTP id b184so9109884ioe.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R1TkFn2nvUunfIz87uCgKPmRV93EFXXvMdRGAzU0MpI=;
        b=B90SzEv9qNfJKeabNVuBY4vsmO49LrjSQq6yx3kKHaLcoSOLikQi1sVFbQ/suqub1R
         847fRYl+LB+Zt0w2PiYCCH/T/UtxixsdXnE+NCEq6ILMD29/LhiMJkXg32/nUI3tScC5
         wA5hDwJQXw7QWVD9zypW9Tutd4Xh5uYIvJy2ptS7fsFLPLh+ZFsvtNdFDWu7UuF/wT44
         aBjC2YfnseTemsa7ah0WWWpIZGAGU2M/Sd1H8JkZXgYzCUPLNd47SeCSGHoxnaEiX8Ht
         PskGyRTd/0TVIEO7NEXGKrZq+PIB1D0nwBFefBsNagmgUtBa+vFBMKGObh05lDswA0F4
         u1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R1TkFn2nvUunfIz87uCgKPmRV93EFXXvMdRGAzU0MpI=;
        b=crTvAAxtDhZfJ0eR65NCbjTINZq29BkKL1Qbm2nGLC7h+P+zDRKUKbnsfnuFuo3VuE
         s7FXAdlUDITtnUbSJV/oNiyjIXFyPpWWvkyhuHKQLuuvXGk96glAxHqwgeyF3Attd0Uc
         1GxUbAoNrsX6TJOj90Qy3DJ2wCS2kakGfnELFylbVu/kTCP5rymotF5HFOSkljFC3dVe
         rNulrFyfb8PspkgEbe0eJu9APNJqv51lhYXfaoAohnHH81jWH9ay6ClqZ1FQ2xnO1ecB
         zsSqcFhp7V78sDYWnB0nJdQClItvzw61+X8JVBVesth0NUNGbd3eenRbBK0hlnsZbJh7
         GgmA==
X-Gm-Message-State: AODbwcAS/2Td4ocGrl0HlD83B2iFvM/lUb8FBdt4fgEE7kZ8hb4pWJX+
        9sZtFmzOS10CCi0fjPG6Ep+8ZBDZoQ==
X-Received: by 10.107.178.130 with SMTP id b124mr18264838iof.50.1496852089765;
 Wed, 07 Jun 2017 09:14:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 09:14:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706071749430.171564@virtualbox>
References: <20170601182056.31142-1-avarab@gmail.com> <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706021803460.171564@virtualbox> <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
 <xmqqshjfuv48.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706071749430.171564@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 18:14:28 +0200
Message-ID: <CACBZZX5Mk=TpQ=6YV9upUUgDsoHwzfQA16JAXg+G5=57774Hcw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 5:50 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 5 Jun 2017, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > On Fri, Jun 2, 2017 at 6:10 PM, Johannes Schindelin
>> >>
>> >> Will continue with testing Git for Windows using PCRE2 next week and =
keep
>> >> you posted,
>> >
>> > Thanks a lot for testing it. Great to hear that it (definitely almost)=
 works!
>> >
>> > If the grep tests it's very likely that all of them will pass, the
>> > only tests I run when developing this series (outside of the full run
>> > for list submission) are t[0-9]*grep*.sh t[0-9]*log*.sh tests, since
>> > those are the only ones impacted by it.
>>
>> 'ab/pcre-v2' was marked for 'next' in "What's cookin" a few issues
>> ago, but I'll keep it in 'pu' to wait for the above---please give me
>> a go ahead when we all are happy with the topic.  I expect to be
>> offline in the later part of this week, by the way.
>
> It turns out that the entire test suite passes when I enable PCRE2. I wil=
l
> try to make the packages available generally in Git for Windows' SDK
> tomorrow.

Great to hear, thanks a lot for testing this & packaging pcre2 for Windows.
