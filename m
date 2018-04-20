Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2597D1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 23:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDTX3E (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 19:29:04 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33339 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeDTX3D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 19:29:03 -0400
Received: by mail-yw0-f170.google.com with SMTP id q12-v6so3285292ywj.0
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FsSMbRbRkhQ9wL8vrJ/IsrOsTiEvigicPI1BCKJnx/8=;
        b=ccvAcThAqxBGG1JSBsVwlnbZs6uQtlVyygd1GkRJMakSBU/SO+g/y/8Ug4FhEvO5vS
         0BwmcNgtme2ndlMk7siQuKHXmtGQcRXCSwNcFsgjrsJWP+qLcCWRGKUrll70yZCTFBz5
         K3gcW67prM36Ke2nN5vZNDyalYLNegTy61+gq6G18hyzffE983S8k8hAruCd8vzmw2Lu
         UCQMsNnYIre1T7THCquEtVFYO6SatMbxcm3IaRQpix4PaoFb7vGDLqygFeydpckmdhZW
         uqQh06WJ6YwqcprQRRmGsgGZX2RB2wy5f3neLGoLdzG6EkoHJaENsEafI7+4Ab5xTGvU
         2S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FsSMbRbRkhQ9wL8vrJ/IsrOsTiEvigicPI1BCKJnx/8=;
        b=jBECAS+eCUTBLW02G3xTzL74YVVCF5XK3rvsD8viwE2+SX+hD61LA1tfEMD2hq66q9
         Osx1JeNZm5OylFGYNgV9KrmDNvUELMs0NW6X2EsBFlt1vKB1ybCeHYXHChlgS2xg9O+H
         RudKbLtc2JGERBL6d3qprq1SoUBk5uAmUXwRCJO+dQcCP+twtqTPlO/xJ6+xR45nI62S
         arhhq2aIPDGu2ww/0alMCso9nTiH8vgewxS7Y1YJ7TdLxO1OvPc1mb2WSSujJQzL/2rn
         v7uEAxJ0SIRBtYk/bHhT1gm/W+vbhWOFYFgYPk+iknUY4awfrhTYWGd8OBPzmkj+LVne
         elrQ==
X-Gm-Message-State: ALQs6tBdwV1beTBsyoM5REd27770TgDDEh8DnO0g9dCgZSdBgq+IlyqL
        YGdvY73iE1fHywzDhmw9ZaYbXeHRsOwHiyTrk2vN/w==
X-Google-Smtp-Source: AIpwx49b8KZbIwRuO/zA1m6IYj1h6RZX6fOBw4IuosV4jA+dSljh/dmsXuJO/lcFHrmm23ZH5vJ5Qf9sMNwb6VPESZs=
X-Received: by 2002:a81:5605:: with SMTP id k5-v6mr6780991ywb.345.1524266942811;
 Fri, 20 Apr 2018 16:29:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 16:29:02
 -0700 (PDT)
In-Reply-To: <8171fd3920846e37c9f1cab6f1ac658dbfb01bfe.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de>
 <cover.1524262793.git.johannes.schindelin@gmx.de> <8171fd3920846e37c9f1cab6f1ac658dbfb01bfe.1524262793.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 16:29:02 -0700
Message-ID: <CAGZ79kaH9RWJ=bK=6tEOt2nXjXopC=uxasH6NUUASieRHL7giA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] argv_array: offer to split a string by whitespace
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 3:20 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This is a simple function that will interpret a string as a whitespace
> delimited list of values, and add those values into the array.
>
> Note: this function does not (yet) offer to split by arbitrary delimiters,
> or keep empty values in case of runs of whitespace, or de-quote Unix shell
> style. All fo this functionality can be added later, when and if needed.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  argv-array.c | 20 ++++++++++++++++++++
>  argv-array.h |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/argv-array.c b/argv-array.c
> index 5d370fa3366..cb5bcd2c064 100644
> --- a/argv-array.c
> +++ b/argv-array.c
> @@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
>         array->argc--;
>  }
>
> +void argv_array_split(struct argv_array *array, const char *to_split)
> +{
> +       while (isspace(*to_split))
> +               to_split++;
> +       for (;;) {
> +               const char *p = to_split;
> +
> +               if (!*p)
> +                       break;
> +
> +               while (*p && !isspace(*p))
> +                       p++;
> +               argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
> +
> +               while (isspace(*p))
> +                       p++;
> +               to_split = p;
> +       }
> +}

The code looks correct to me.

Though this seems so low level, that I find it hard to accept
to implement yet another low level split function.
Would reuse of strbuf_split or string_list_split make sense?

Looking at the user in patch 5 you really want to have the
argv array, though, so it cannot be pushed to an even higher
abstraction layer and be solved there. You really want a
string -> argv array split, which would mean we'd have to
do the split via string -> {strbufs, stringlist} and then perform
a conversion from that to argv array and both conversions
look ugly as we'd need to iterate their specific data structure
and push each element itself again.

So I guess we rather implement it yet another time.

Looking at their function declarations:

/*
 * lots of very good comments for string list splitting
 */
int string_list_split(struct string_list *list, const char *string,
          int delim, int maxsplit);

/*
 * lots of very good comments for strbuf splitting
 */
static inline struct strbuf **strbuf_split(const struct strbuf *sb,
           int terminator)

I find they have comments in common as well as the
terminator. In the commit message you defer the
implementation of a terminating symbol, as we
can do it later. Also the isspace takes more than one
delimiter, which the others do not.

I am debating myself if I want to ask for a comment, as
argv-array.h is very short for now and it would be consistent
not to add a comment.

Thanks,
Stefan
