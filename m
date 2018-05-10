Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2D91F406
	for <e@80x24.org>; Thu, 10 May 2018 13:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeEJNPG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:15:06 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:43793 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756948AbeEJNPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:15:05 -0400
Received: by mail-pg0-f46.google.com with SMTP id k11-v6so957021pgo.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8cfmHwsc9aPqoExKX4EMS8/qTqh3z2mZx3qmK7hQPPE=;
        b=rIYJSXubIjXtXw/r4O86j2ND5/o5M2bivGOmlkC+YsKuPeo22h6ms3JDkB+2LsiQha
         uGw5xX95LLnVksG9UUJPhtbUL6hj+VRFDJgbIzHHrAQtuAMH4IGKV2UcHsXCgE1gIv/1
         9S/VfBb9FVXuWjf8FHACDgB9bB1CWBlfiq8NJMTlGarsGGA/jQ6URIt7xxT9XQ2WtPQk
         FC594Z9C5Kg73MoSxlzJhGig+gq1zZK07GB7b7ljo8cbXz3We2QSIeT3G6LdkscJhFLB
         0ZEMo+haR5vf5x9d6s7SkRDwbvi2LWEAHYAaipLH7nF8ySHT+9XYGzm0nI5Af/sY5a7m
         UOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8cfmHwsc9aPqoExKX4EMS8/qTqh3z2mZx3qmK7hQPPE=;
        b=c6tMr1cwCPx6zBWaZtOPlMQMCQmMTbNCn0raHwD9FUbS+yaUdQBwEi+SlTGYm8yr+f
         nJiAOtYLAqkWHI9Pki0Bv0w/wo7nC5LSqEomn81AFsv9Czt/opRIvg54d0KmV9Re0J+t
         MrXCtib2q2l/UmU7PYD+JpxPLqgVh/hiWGigJI07Bb52Ou8W+WHy2zA8TkOhGxesYWPO
         EdwvsDzroR9ycFdxrj1MaGT0ED723lDvJLAapRidtn3QfzSC7YRz1084GsArVc368fC1
         u2Gs4F8unMHylrlpGXqXJ4hc4ql98aP4m38wfpm2x1it5cQdlz5RXA/Xt4bMh4j3jKqG
         yUJw==
X-Gm-Message-State: ALKqPwfXE2Pred7NRL9ZJ/vZckkDqcLNZJVSFT+3N5tOtRH2g8icJPGl
        vSYlkXY5S6xebNkPBh4K16nyjwJUIdY4Y5psWqY=
X-Google-Smtp-Source: AB8JxZq2xjukPXspd/9A4K+5d8hx44OmCvpAX4q/sssMTWiyiD2dUSpXu+JsY5TnrgQe4egGTTbhZICxFQifnCWjKgc=
X-Received: by 2002:a62:d8c7:: with SMTP id e190-v6mr1363348pfg.161.1525958104647;
 Thu, 10 May 2018 06:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 06:15:03 -0700 (PDT)
In-Reply-To: <20180510124303.6020-7-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com> <20180510124303.6020-1-avarab@gmail.com>
 <20180510124303.6020-7-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 15:15:03 +0200
Message-ID: <CAN0heSoykVHTxD6s_QVUW_hMfTHG05yP-hVxnV6qsAO-eKJJ0A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] get_short_oid: document & warn if we ignore the
 type selector
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 14:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> The SHA1 prefix 06fa currently matches no blobs in git.git. When
> disambiguating short SHA1s we've been quietly ignoring the user's type
> selector as a fallback mechanism, this was intentionally added in
> 1ffa26c461 ("get_short_sha1: list ambiguous objects on error",
> 2016-09-26).
>
> I think that behavior makes sense, it's not very useful to just show
> nothing because a preference has been expressed via core.disambiguate,
> but it's bad that we're quietly doing this. The user might thing that
> we just didn't understand what e.g 06fa^{blob} meant.
>
> Now we'll instead print a warning if no objects of the requested type
> were found:
>
>     $ git rev-parse 06fa^{blob}
>     error: short SHA1 06fa is ambiguous
>     hint: The candidates are:
>     [... no blobs listed ...]
>     warning: Your hint (via core.disambiguate or peel syntax) was ignored=
, we fell
>     back to showing all object types since no object of the requested typ=
e
>     matched the provide short SHA1 06fa

s/ignored, we/ignored. We/? IMHO, it would read easier.

s/provide short/provided short/

Also: s/SHA1/object id/? That said, you add the warning. The error
message is already there and you are simply following its "SHA1".

Martin
