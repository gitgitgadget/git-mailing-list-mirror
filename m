Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548571FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 11:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbdDKLDT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 07:03:19 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36068 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdDKLDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 07:03:17 -0400
Received: by mail-io0-f177.google.com with SMTP id l7so129121505ioe.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qvDoyGLUxm78i5396vPhx/sfx/GQTvb7fGVxchTt56o=;
        b=SaIQSfaIjHFbcfmxcy/kG9UkcV8A8R1hhg+aNUZCyvHHyLO6HvE3e+EqVQpXTYB9E7
         BRZQ5w95O5k2ycivAc6qXJjeMJPLCJ719ko75ceOLC47eMQh/xtLHHxLROaL1m8CWwRc
         6KfC+7u5PtnUUEEiUVv1+Pq4xEcqL0fMmBkoOqwDQoHSDFxIsJ9FTGJ9/q+0nLZLx306
         9wf8dNCdy4W9v6auGi9GJ69FWCOhIgayGmTZyOcA7iz3ajMMrPxNLyKF95Dd4mXNlzi2
         ztA6NxRbvgVYTeazKSDjXtJWk3Xpivup3IgR7Hjt9ZPTo0mDk8vD4XZ4Qwr7r+RGMwPo
         mYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qvDoyGLUxm78i5396vPhx/sfx/GQTvb7fGVxchTt56o=;
        b=H46APYrmtxPVaxMYG7kAEKz/vt1p6TLrSnoQMmpS08YaYuLKOUgnCqwuLC8KEWUoJ1
         s59Xt4ZW3pRbjOlMQu2xnnEuWK2yOM2PhQAJnvSDorh+fdutpCcL4BX4v9wLmSnnhbrF
         tMBXogp2tp7zNd3NQcr5YlBnKPi1kg7V0TDy2gt5dq6CDRk4HPDO/ymejdtU6cEDreBc
         gKy3Ub9bU/zesp5a5NVruJ9d75byGPlciiPy3Kcn4bNUgWsrspyd+ZOpQKPBBMBTjLDM
         fpR6OTO09Z69d0NoZL2/LBPBDbBmOPl3AvAnRMtE/+8d6BJaR2zPCBcsNGFaAFgUTpNq
         ePzg==
X-Gm-Message-State: AFeK/H25dl+gPXzXMeHvTYJybmrFl7Hi6DaJPvxQxpR034kjIlz1hemX/1bjHVWjbgZJnrWTgAdJ1KC44vbFag==
X-Received: by 10.107.32.199 with SMTP id g190mr60704535iog.117.1491908596802;
 Tue, 11 Apr 2017 04:03:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 04:02:56 -0700 (PDT)
In-Reply-To: <20170411104828.skkujde3qrvn4jrt@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-12-avarab@gmail.com>
 <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net> <CACBZZX5V96Vv5NAYpkQSBWpn-4rgHOatAnL51o4-4DADAF+pEg@mail.gmail.com>
 <20170411104828.skkujde3qrvn4jrt@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 13:02:56 +0200
Message-ID: <CACBZZX6A8tcXy-hCcQqqDsGNDtXWmZMdTY=RxeAOn8QFYDypyg@mail.gmail.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 12:45:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Tue, Apr 11, 2017 at 12:37 PM, Jeff King <peff@peff.net> wrote:
>> > On Sat, Apr 08, 2017 at 01:25:05PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >
>> >> diff --git a/builtin/grep.c b/builtin/grep.c
>> >> index 9478ab5dff..dffb9743b8 100644
>> >> --- a/builtin/grep.c
>> >> +++ b/builtin/grep.c
>> >> @@ -490,7 +490,7 @@ static void compile_submodule_options(const struc=
t grep_opt *opt,
>> >>       case GREP_PATTERN_TYPE_FIXED:
>> >>               argv_array_push(&submodule_options, "-F");
>> >>               break;
>> >> -     case GREP_PATTERN_TYPE_PCRE:
>> >> +     case GREP_PATTERN_TYPE_PCRE1:
>> >>               argv_array_push(&submodule_options, "-P");
>> >>               break;
>> >
>> > Hmm. This isn't a problem yet, but wouldn't this need to pass some
>> > pcre1-specific option instead of just "-P"?
>>
>> Yes, this is a bug. I'll need to add a git_options along with
>> submodule_options and pass -c grep.patternType=3D....
>
> Maybe that's an indication we should have --pcre1-regexp and
> --pcre2-regexp, so we don't have to resort to config tweaking.

I'd rather not. To reply to both your
<20170411103018.dkq5gangx3vcxhp4@sigill.intra.peff.net> & this, one
thing I was trying to do in this series (and I don't think I went far
enough in "grep & rev-list doc: stop promising libpcre for
--perl-regexp") was to stop promising some specific version of PCRE.

I.e. I think we should have the likes of core.patternType=3Dperl & -P
for the user, but whether we implement that with pcre/pcre2, or even
libperl itself, or any of the other PCRE reimplementations around
(there's one for java, one for C#, cpython has one I think...), or
maybe even re2 should be an implementation detail.

I.e. as far as the user is concerned they just want perl-y regexes,
but they most likely don't care about the 1% featureset of those
regexes where the various implementations of "perl-y regex" actually
differ, because those cases tend to be really obscure syntax.

Having core.patternType=3Dpcre2 is a neccesary evil for our own
implementation & testing, e.g. for the submodule grep it would be
really bizarro if some edge case where the implementations differ
causes us to produce different grep results, since one side would use
pcre2 & the other pcre1.

But I don't think we should take it to the level of having documented
--pcreN-regexp options.
