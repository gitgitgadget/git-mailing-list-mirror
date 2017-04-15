Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294EA20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbdDOJu2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 05:50:28 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34208 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdDOJu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 05:50:26 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so20915575ioi.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DVdMLmbjHb+Z6tlHem0kLgBdrOE9ucCSyBQ380S7L3w=;
        b=T4cGGTe1XB5EZmhaUUJpxtKnad/6aoFJHS0pKilXqXiylJvbd6bLWIdkQUwGpXR78k
         1MLMF63f5lwjSpzYyw1NFWNuK5V7HsyQULCyAHhqKFNMwbxev+uoIXFnCW/8+ax1YfLc
         r+Yb6A/qNnkbiFbLTuT3B1s6lemhoe2NEJt2nkYmvp7yWOzdXKPsd/r59mulMAVsAGSY
         eQlRvuwmOc1F6qjVOh604fgewwxlcJvUzJNSd3HP1QZJSfp6p1uTCttpZLz44QArkbzY
         3HAD3rkaXTg4Vz72U3HvM9+NBMGn3tmt2bS8dN/uO7pPBdTAn2AOp0ymE0f/HhTcong2
         qXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DVdMLmbjHb+Z6tlHem0kLgBdrOE9ucCSyBQ380S7L3w=;
        b=CYdvlYyQvQKpw0Eh3wJ07AY5EhKg8ACavQqNE55WZKvNIweRCzZx1Xgo0ynxGh5Q2L
         dicCWCOApGliNW+iFBxuU/trGjojWQlwpjMzCvY7JePFi1ljljRRQEHVo+VjTJFQlHkc
         QXYz+GV/9jXzfd/taKKww+RYf9hib8dmiNxIkH9+VNSm/2b4kB8+C3YZZNqRZt6Gj2zr
         wygy6+bmwavQFnc3AShf3TZPDAne/MhSXyA8IOdaBQ9VZD2MkwBZxo9BxpmjRufa5/nH
         OYCro6d2aJqN1M8uemt1VZwnyqwEbUZgazUrlj3UEgBxZlcdP/WULnQZQF/+d6vWqxF+
         jO8g==
X-Gm-Message-State: AN3rC/5HIhWT6agyBcUnSuzZs7LtFcinY4R+Qn5o9X9CpNZDZLhPskBb
        fXFj+UtReCvYtaKFBaPQ/4zCwunHwg==
X-Received: by 10.107.35.200 with SMTP id j191mr1620753ioj.33.1492249825863;
 Sat, 15 Apr 2017 02:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Sat, 15 Apr 2017 02:50:05 -0700 (PDT)
In-Reply-To: <xmqqinm6m6p0.fsf@gitster.mtv.corp.google.com>
References: <20170408132506.5415-1-avarab@gmail.com> <20170411104739.xzhxggpufvwgr3fu@sigill.intra.peff.net>
 <xmqqinm6m6p0.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 15 Apr 2017 11:50:05 +0200
Message-ID: <CACBZZX6G4LFyqxvbba72ZzwuOPakiPWTSVbFCX7DzrZ5D5Vpqg@mail.gmail.com>
Subject: Re: [PATCH 00/12] PCREv2 & more
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, Apr 08, 2017 at 01:24:54PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> This adds PCRE v2 support, but as I was adding that I kept noticing
>>> other related problems to fix. It's all bundled up into the same
>>> series because much of it conflicts because it modifies the same test
>>> or other code. Notes on each patch below.
>>
>> Overall, the series looks OK to me.
>>
>> I'm not sure if it is worth all the complexity to carry pcre1/pcre2 as
>> run-time options. That does make it easier to do back-to-back
>> comparisons, but it makes the code a lot more complicated. In particular
>> I'm worried about subtle cases where we pcre1 turns into pcre2 (or vice
>> versa) by use of the aliases. That shouldn't matter to a user for
>> correctness, but it would throw off the benchmarking.
>>
>> If we literally just added USE_LIBPCRE2 and built against one or the
>> other, then all the complexity would be limited to a few #ifdefs. The
>> big drawback AFAICT is that anybody doing timing tests would have to
>> recompile in between.
>
> Yeah, having to dl two libs at runtime, even when you would ever use
> just one in a single run, is less than ideal.  A small downside
> inflicted on everybody will add up to million times more than a
> larger downside only suffered by developers, so I tend to agree with
> you that we probably should simplify to choose just one (or zero) at
> compile time.

I'll document & clarify this in v2, but I don't expect / want anyone
who's distributing git to link to both v1 & v2, more details in my
<CACBZZX6HLDmWSGiQ+cJ-p0Ak6SQHcmECaGqsfVz-Js4q7aSEwg@mail.gmail.com>.

It's just something we already have 95% of the code to support anyway,
and doing the remaining 5% makes it easier to test & benchmark it for
us devs without incurring any real maintenance or tech burden.

But as noted elsewhere in that message I'll include a patch to only
add the ability to use one PCRE version. So we can just review &
discuss the tradeoffs of doing that then.
