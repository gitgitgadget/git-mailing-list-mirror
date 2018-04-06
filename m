Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633051F424
	for <e@80x24.org>; Fri,  6 Apr 2018 10:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDFK4W (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 06:56:22 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44273 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFK4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 06:56:21 -0400
Received: by mail-qt0-f181.google.com with SMTP id j26so635568qtl.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sQYJqvIj1jQbiV8dJWA3T7qpawcaHp6FE0miJSKYf8U=;
        b=Hv0kiCl5YnvMw7fhBDKW9C1Um76kbJhcPvUjIW8LmcJhNF7qg1zYJNIFq+8N8jJgDC
         9uuAnAJHJyI7mkTrfwudCKUnHBju6LfGW7F2FnqRPSMLwlBElY7KDIqb2uC+5bq0IOCk
         qvHXhLZGlYS/dMXOyZpHIY1MOLfQOnlJkzFQporA+Gb+NZ3Ll9GSRxlOVyO2lyv4+MTB
         0naw5ESyZtg5seF5ESN3E59YdzYjKDogJfejG+p+62VzBla8UUJK06NSVBqUWYP42FDJ
         N0HnYMpR1qkuvEY5nx8zC9Ems5TvXmAT85fSPbHnlcXcacpw0UBBfrdS3QmiuDBfQo7S
         fxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sQYJqvIj1jQbiV8dJWA3T7qpawcaHp6FE0miJSKYf8U=;
        b=PwL5Rol/RPvUGWPm5nnVgGQHO4NhLLDtk/2JxdTJefT9LgY11LQ72rmJoPdyUn3FNA
         Gle30uD4jEaToQiJ+rTHvx6JK1axbKVNA6wRrtapzmVMCjOSji7LLEViqOfwjklCcHDz
         AtJyLFQlpydGRdGUe+MsQSrXv2ngkkL6m/9PE7+pdJRrL6xwlQM7JIoT/9osvmm2oRLU
         v7qBZu57XZXuBexiRBGeF7r/8h5O1Jt4xKEoQ8V1iqDen0yqq1/5NXmw+URd1Hl9uN/g
         METXhZpWKqtJSQJHFZkdT/wAwo0KY+gCUGe5Dc62oHtOi5XhRGFyeYPTnpzVPXBNIB91
         Ia5w==
X-Gm-Message-State: ALQs6tBBtVM+aXl1rUMSCcRtN+dXifu/+9wNKxFuaLA7pT/DrlLk6d8f
        6Dkg1aDDMgu7AFBtu/8kom/bmGPnyxquKq32wbU=
X-Google-Smtp-Source: AIpwx4/OqulHHtzo5eLxjIVRofaXCgdr7xVJJ3onvO8RCtxLi+IvFNc+DF2ETey1D/yMYvTbPL7QvdIIy1l5mtTZzaQ=
X-Received: by 10.237.49.195 with SMTP id 61mr36967665qth.77.1523012180570;
 Fri, 06 Apr 2018 03:56:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 03:56:20 -0700 (PDT)
In-Reply-To: <516b28e82ace0a0b6831c644f246c19dad1187ac.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
 <cover.1522968472.git.johannes.schindelin@gmx.de> <516b28e82ace0a0b6831c644f246c19dad1187ac.1522968472.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 06:56:20 -0400
X-Google-Sender-Auth: OmQuZf2GECZe7K-zPfLf_Z34cCM
Message-ID: <CAPig+cRW6VhZGrV3qN5gDyMu1Oc=hjDOpyo_OY43jyoQNc6Q1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Document the new color.* settings to colorize push errors/hints
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 6:48 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Let's make it easier for users to find out how to customize these colors.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1088,6 +1088,16 @@ clean.requireForce::
> +color.advice::
> +       A boolean to enable/disable color in hints (e.g. when a push
> +       failed, see `advice.*` for a list).  May be set to `always`,
> +       `false` (or `never`) or `auto` (or `true`), in which case colors
> +       are used only when the error output goes to a terminal. If
> +       unset, then the value of `color.ui` is used (`auto` by default).
> +
> +color.advice.advice::
> +       Use customized color for hints.

Is "color.advice.advice" correct?
