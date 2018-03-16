Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6441F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeCPHWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 03:22:41 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46238 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeCPHWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 03:22:40 -0400
Received: by mail-wr0-f178.google.com with SMTP id m12so10571408wrm.13
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yVLmP9GlAty7V1PwJ7XFXQe32/9qsKRf7zR2m2aaB1M=;
        b=I+GDgEFWeR+eoKYi1CniBxboRg7HXbuSHWLDkZCac+v5+uYKXtMfW7RYk7/iytLSrW
         SZVIH+ewJu2n45tI3ymLhk2UHmMlEy3/UQ7CMkKuUax1bUkXiBv4cg/t5i+1oL/Jbirr
         ZUIiSeXerUQoF+PkKuLvM25i8ZFB0CeBMf7BINpD0S/Mz8gmAz3cC8e86fOdFie7UyVn
         fquOx6529HQpvVsZDauXwoboq2Ft8Gw09BICJ1NI3HjY7j53NpzjdV1g/qwQ0lhHtTAn
         fb87Ql+I7kSVdUaQLLmiXc41fqzMBrEE4eTYnGSzco78hcOiluqmcBnVYC1eTzdJt0xe
         SsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yVLmP9GlAty7V1PwJ7XFXQe32/9qsKRf7zR2m2aaB1M=;
        b=o/SK39x8rMncSJCX0e8CQXGx+PhDGnF29Uvxuf4MEK3RF9Wny0g6XF6qhNry2sxHMo
         gdcYo8YaCJTD6Uzd626xOYS2YR7Ep50H92xCekHU41d2BMFueSdsWMIMmBeoHrxNjqWO
         TDtRxKsJJ2kTKXWR/llAWgWTGsL0yapz6acHZAT/pzFsDHgwUxPyoEcGL+Q4HAaEHtpH
         pKv5WxRyILcNlCh8FgIfcA4A9Pqq1eoAVCdWnq6gJUfbuOwEXOdN9CabQdO3DvK0kVfi
         NxhHKgPwr1KAkgadfpJsipXO3TFI11ByuyR5FUdn2NmE2zmz0ANy6PZReW5S+bFLnbKC
         e+1A==
X-Gm-Message-State: AElRT7FOTvyoSFQvCyd7JEYxuvlyka7G6RENICWvZZ+u2C4dZQVpO3nH
        97VE0YA3iI67bC/Uh2T3C3ekDsqANAuU8l5Ez0M=
X-Google-Smtp-Source: AG47ELvRHJtG2e8h1MkulmGBW9DK8JSnlif59lXYeDqoT012RpUl+YOkRvCfoBSVfSt7YxTc0a2yxjYJRF2GM7IHwVc=
X-Received: by 10.223.136.13 with SMTP id d13mr601939wrd.271.1521184959041;
 Fri, 16 Mar 2018 00:22:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Fri, 16 Mar 2018 00:22:38 -0700 (PDT)
In-Reply-To: <xmqq8tat3qgj.fsf@gitster-ct.c.googlers.com>
References: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
 <0102016225e61cb4-b59773de-d22e-42cd-909a-d7ce71646898-000000@eu-west-1.amazonses.com>
 <xmqq8tat3qgj.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 16 Mar 2018 10:22:38 +0300
Message-ID: <CAL21Bmk03kSaO8h+uQ9nB7DomAL0Ym+7jygTo7M-rv5OM2duzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ref-filter: change parsing function error handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-16 1:48 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Continue removing any printing from ref-filter formatting logic,
>> so that it could be more general.
>
> Hmm.
>
>> Change the signature of parse_ref_filter_atom() by changing return value,
>> adding previous return value to function parameter and also adding
>> strbuf parameter for error message.
>
> This says what the patch changes, but it does not explain why it is
> a good idea to return something with different meaning to the
> callers (which of course forces us to update all callers so that
> they pass &result pointer and check the value returned in the
> variable), or more importantly what meaning the return value has and
> how the callers are expected to use it.  While at it, it probably is
> a good idea to explain what the original return value means.
>
>         The return value from parse_ref_filter_atom() used to be the
>         position the atom is found in the used_atom[] array; that
>         information is now returned in an integer pointed at by the
>         *res parameter.  The function now returns 0 for success and
>         -1 for failure.
>
> or something like that.
>
> Having said that, I wonder if a calling convention that does not
> force callers to pass in a pointer-to-int may make more sense.
> Because the original return value is an index into an array, we know
> the normal return values are not negative.  An updated caller could
> become like this instead:
>
>         pos = parse_ref_filter_atom(format, atom, ep, &err);
>         if (pos < 0)
>                 die("%s", err.buf);
>         ... original code that used 'pos' can stay as before ...
>

Martin also mentioned that, but I was not sure which solution is
better. Great, thanks, I will fix that.
