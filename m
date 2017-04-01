Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50EAF20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdDATL0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:11:26 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35340 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdDATLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:11:25 -0400
Received: by mail-io0-f177.google.com with SMTP id z13so56611813iof.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YPDtRjLbUeqrB2jpFCby7+Hh8vD/8lgGl/Dkws83aTI=;
        b=ss9eX4koq1OOF2c6Hqr6tlgpBn9NmMDGL1/qWrqJDOSTB2MEnjgeA+NojSXi+eu7CQ
         fqUeSltA3S2IyEkbBt/h8n148UYju5UI2opEfw5tR+6ViFZHZqALuOfPcba8j/Uy0FNT
         k1w6pjjJyJarjsBbpDLfQY4x6dfC9dtcC0XOGtzAZw8PbypAaFaIfQ4oqK/wEYvfok4P
         E9Lxtfye2ms5JPXI/JYNVcAz8aeFQTtqMiF88Y6LSoOdQGfUxzrPo2QwLm4QGy3I3EcY
         9v3X0xzdgm/quYg5jPLH0zG7LU9zMKZNo28uPrd/+qEuV8FZGKrX2jSL7+bszpLUavNo
         PQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YPDtRjLbUeqrB2jpFCby7+Hh8vD/8lgGl/Dkws83aTI=;
        b=kqszPyhEI44VWUf0Zz6aNE/iSC67Tjw5WPliWe7AShR8BElGr8Q59cbb9fnKvtf1LB
         TxWp4dcZILi5Bljh+Ans1hc2mF5j92Ky08Y8aI21NT8i+KMJnkbZVy6ag1nLdXgr2ZYT
         n0/DM5alsiN07yhPS9730ZNVdMxFz0Q+PX9qhI8cQP+YEVwrU4uTVohAu969Ay/I/Rm4
         JisD20wpL7WHuYq5Hca9cthqbzTtCpLJdoTFhvnc+U35Hk+JcrzsP5gFIzaaWbMFCx6m
         BRVAjExgDu2IVCHxomqopPokI+GdT0DWo2q4QUqKIU1Zuv/I7eGH1jhvPTSLMF+HY8/e
         O40A==
X-Gm-Message-State: AFeK/H2Ygz8d2zQ16SQyolHFxjgdPpvF2TefExzEek03Q3joN++0xs1LsbZYeUnRjw/bbf+y29ZN3sBQLmVGIg==
X-Received: by 10.107.34.68 with SMTP id i65mr10376062ioi.147.1491073884286;
 Sat, 01 Apr 2017 12:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 1 Apr 2017 12:11:03 -0700 (PDT)
In-Reply-To: <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
 <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com> <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
 <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 1 Apr 2017 21:11:03 +0200
Message-ID: <CACBZZX5mEMq2ZRKKc-5HxhauNRemPpN4P+wzmihO1YhZq_vJPg@mail.gmail.com>
Subject: Re: Very promising results with libpcre2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 8:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Apr 1, 2017 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> That enables the new JIT support in pcre v2:
>>>>
>>>>       s/iter    rx fixed   prx
>>>> rx      2.19    --  -33%  -44%
>>>> fixed   1.47   49%    --  -17%
>>>> prx     1.22   79%   20%    --
>>>
>>> The numbers with JIT does look "interesting".
>>>
>>> I couldn't quite tell if there are major incompatibilities in the
>>> regex language itself between two versions from their documentation,
>>> but assuming that there isn't (modulo bugfixes and enhancements) and
>>> assuming that we are going to use their standard matcher, it may be
>>> OK to just use the newer one without linking both.
>>
>> There's no incompatibilities in the regex language itself (modulo bugs
>> etc). So yeah, I'll prepare some patch to use v2.
>
> Just to make sure that we are on the same page.  While I do not see
> the need to link with both variants and allow users to choose
> between them at runtime, I do not know if the whole world is ready
> to drop pcre1 and use pcre2 (the latter of which has only been
> around for a bit over two years).
>
> So we'd probably want to do
>
>  (1) keep USE_LIBPCRE and enable v1 when set;
>  (2) add USE_LIBPCRE2 and enable v2 when set;
>  (3) make sure to error out when both are set.
>
> or something like that.  It is tempting to allow us to say
>
>     make USE_LIBPCRE=3D2
>
> but the existing builds are likely to be depending on "is it set to
> anything? then use PCRE1" behaviour, so we unfortunately cannot take
> that route.

We're on the same page, all of this makes sense, there'll be some OS's
/ environments which for years won't be packaging pcre2 but will have
pcre1.

I am very tempted though to support them in parallel, if only for ease
of performance testing and to be able to roll out support for
grep.patternType=3Dperl meaning pcre1 for now, but add a
grep.patternType=3Dpcre2 for testing (and make grep.patternType=3Dpcre1
work, with grep.patternType=3Dpcre being synonymous with
grep.patternType=3Dperl, i.e. whatever the default is).
