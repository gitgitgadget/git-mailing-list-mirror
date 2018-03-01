Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E941F576
	for <e@80x24.org>; Thu,  1 Mar 2018 11:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967756AbeCALRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 06:17:14 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38650 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967618AbeCALRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 06:17:11 -0500
Received: by mail-wm0-f44.google.com with SMTP id z9so10826977wmb.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CcYUYoQJzcp/blOjzEcdzFBYQvtj8dKXHgcT2MMBXr8=;
        b=T40Sm2JSqdphiLqLyb1azbU51qFhWCgF++zBFTfhd7RN9F3I7w7H1mZGyspzeC1mlv
         gAUWX9GCcXpaz6jcUj/0iaGjliFDfzJgikuKqZJaKagX2sigdrGMyELK5gHoeu1hwGoC
         Jj4BezNJX1vls2qw9LWPqjXATKUK91puwWyywSuLKRCwknJwcw+h7zR0cz2P+Bby8Xnr
         vv8rN7fZNjZoHgs4O2TefFk4GwIxHili11U+zCHu/WHJA6mt+vM1+/ZYNd/uHxpTWZ/t
         qxWVpPMh7klrLYHJPVn4QnwB4srjQDgrJPXh9Tms+synMGydF8opolmq5Ks7eV6GmjIN
         toRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CcYUYoQJzcp/blOjzEcdzFBYQvtj8dKXHgcT2MMBXr8=;
        b=qAy/Hg9rhn438stf+6rtp92XUwxj9G6jiW1V+5C+jhQMwejHKj393Tt3GAM6wFf9Wi
         OZxyFJL601SEhn75AJwFN/5JnoXQ71hanLEnFfCjNCRV/8Vf3FXHGnXWR94Z+aSKW76F
         oGp4AC7YZyFmhb2GYcNgCTj9vmEymcQaA+ZRVTU47uO9Ny5ly80UMzMhWymgaQ4co4Gj
         kcCVdqLgnUykwtLFX8iTeVrYGHOzAVVvZN7gr7guODv0AJVNS7PC1Px5Q6xlW3ZRWh9+
         sYRTs2Ka5cl5dMBiCuErbrnWo5j8eseu7H3rXoolmRj1bywiV3Oaeotcl5+o58Lax1m6
         4rOw==
X-Gm-Message-State: AElRT7E9rKQcCBJOIf5MIi7BmUSSr49aZCDeA+oH28K9j6Q2wi6Jr4wS
        6DLrSKvrPSi7+koAd+zCVLlkXxHg13q+13vRTPSLdA==
X-Google-Smtp-Source: AG47ELu85EKPJV1mOur5VinTFH1MNdoFi+Lx5iMLShXTJPPTPR0wg2AUI60gYZ0BvZW5ScVYt9Rg1ej1b2vwv1LV/vE=
X-Received: by 10.28.139.142 with SMTP id n136mr1366894wmd.101.1519903030111;
 Thu, 01 Mar 2018 03:17:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Thu, 1 Mar 2018 03:17:09 -0800 (PST)
In-Reply-To: <20180228132550.GB32272@sigill.intra.peff.net>
References: <CAL21Bmnz=H96EE=yerdigujYQ6M7Y_U-RkDF7oR-UPDU+cZNFA@mail.gmail.com>
 <20180228132550.GB32272@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 1 Mar 2018 14:17:09 +0300
Message-ID: <CAL21BmkVq4j=hgupPvZqigSGQ-=rgwKVvzTD_X-_Z__8qmeKJg@mail.gmail.com>
Subject: Re: ref-filter: how to improve the code
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-28 16:25 GMT+03:00 Jeff King <peff@peff.net>:
> On Sun, Feb 25, 2018 at 09:28:25PM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=
=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>
>> I am trying to remove cat-file formatting part and reuse same
>> functionality from ref-filter.
>> I have a problem that cat-file sometimes needs to continue running
>> even if the request is broken, while in ref-filter we invoke die() in
>> many places everywhere during formatting process. I write this email
>> because I want to discuss how to implement the solution better.
>>
>> ref-filter has 2 functions which could be interesting for us:
>> format_ref_array_item() and show_ref_array_item(). I guess it's a good
>> idea to print everything in show_ref_array_item(), including all
>> errors. In that case all current users of ref-filter will invoke
>> show_ref_array_item() (as they did it before), and cat-file could use
>> format_ref_array_item() and work with the result in its own logic.
>
> Yes, that arrangement makes sense to me.
>
>> I tried to replace all die("...") with `return error("...")` and
>> finally exit(), but actual problem is that we print "error:..."
>> instead of "fatal:...", and it looks funny.
>
> If you do that, then format_ref_array_item() is still going to print
> things, even if it doesn't die(). But for "cat-file --batch", we usually
> do not print errors at all, but instead just say "... missing" (although
> it depends on the error; syntactic errors in the format string would
> still cause us to write to stderr).

Not sure if you catch my idea. format_ref_array_item() will not print
anything, it will just return an error code. And if there was an error
- we will print it in show_ref_array_item() (or go back to cat-file
and print what we want).

>
>> One of the easiest solutions is to add strbuf parameter for errors to
>> all functions that we use during formatting process, fill it in and
>> print in show_ref_array_item() if necessary. What do you think about
>> this idea?
>>
>> Another way is to change the resulting error message, print current
>> message with "error" prefix and then print something like "fatal:
>> could not format the output". It is easier but I am not sure that it's
>> a good idea to change the interface.
>
> For reference, the first one is what we've been switching to in the refs
> code. And I think it's been fairly successful there.
>
> -Peff
