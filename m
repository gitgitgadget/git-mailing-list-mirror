Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBDD1F404
	for <e@80x24.org>; Tue, 24 Apr 2018 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeDXJli (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:41:38 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42581 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeDXJlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:41:37 -0400
Received: by mail-pg0-f65.google.com with SMTP id e12so10453960pgn.9
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rqFOGxbUCabeeweTpQrB94FhGLsldM6/bf1eIcZrU4Q=;
        b=Du1MS65Wn5hk5gqgGSmmoS6fUExS77gzovoweRlU3jAKs/FP4H4eX85qVN5ElLWtp9
         B3diCvAPatt11/J+rdc7W70b1Tf8Xz9uhhuD3/bh8fn0WLp3C5i6qOPSwa6sSClOSnhS
         4XwqgleN1zDC6JCDKySVxYbiUofXad0BzWQGnvKZbOqpQ9nBO7XWgOfK7HMPRFCoEaMA
         Cjqayg2SkzNcNNAAPQ6HiU406qBpvii5kikhWg1Nuch8F4AVKzt3oXuNdyBRJFbEa33Y
         7lsATL2idR4zgejH66tc2XDfAW/nw6DkyGEqi4w7ZHnJcjPsX0s+5RbcgHPdDP5QA1ZF
         5xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rqFOGxbUCabeeweTpQrB94FhGLsldM6/bf1eIcZrU4Q=;
        b=gLy+no6d3kHE+8HL4gNweLjISR1PjKyFUzUvNGe9y/60jUY3G6J+XZX9s/p23Azo0V
         8VHQ/ZR6q10f1WMr/vSJLRGdrmqRPDviiRG6dFgFqmh+l0vTiFyh6NVzrmx4UkVDWZR7
         25XjNTTqepAf61vVej+8I2WCenh9vjCyx/QGAdDTRnWRTd5ggzh2eLUaMSrlZR88KMMB
         VfVIlAughAXTNU9b0MoPdpQPDg1fwn2wiyBMaunPa8KXnfAU6zcn8y/5DO5D8gsR3H9G
         Gltx+dWCNgevkZOL16x3pKpQo5dCBQ/A7pBWFIeYqX49oxZ6YkBFgJiEsDi2tinID5qt
         2Svg==
X-Gm-Message-State: ALQs6tAj3UxS9n8uRsGiYaounKjioSc1H6x8gJSgcO8m9CKrfRYZV/2t
        VA2/JJr2Pkj9EX+7xGTgDR0BK5Cfzlv502ecuzg=
X-Google-Smtp-Source: AIpwx4/9dRjxCNKfmBmV3Nwo8TjOgu1mpInwVho3JDJxACnkSrKwfKGwysXJk1Gq0ow7+0QWU0lRiem3tzUZHZTuqxI=
X-Received: by 10.98.80.80 with SMTP id e77mr23512080pfb.16.1524562897356;
 Tue, 24 Apr 2018 02:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:41:36 -0700 (PDT)
In-Reply-To: <20180423233951.276447-3-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-3-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:41:36 +0200
Message-ID: <CAN0heSroUKRz_gZSTbXxO0jkB-WWd45aykpjASrWt8aB=q0iPw@mail.gmail.com>
Subject: Re: [PATCH 02/41] server-info: remove unused members from struct pack_info
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 01:39, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The head member of struct pack_info is completely unused and the
> nr_heads member is used only in one place, which is an assignment.
> Since these structure members are not useful, remove them.

Good catch.

> @@ -228,7 +226,6 @@ static void init_pack_info(const char *infofile, int force)
>         for (i = 0; i < num_pack; i++) {
>                 if (stale) {
>                         info[i]->old_num = -1;
> -                       info[i]->nr_heads = 0;
>                 }
>         }

Minor nits: The braces could go. Not something you're introducing, but
the nesting of the `for` and the `if` looks odd. There used to be more
inside this loop, which explains this.

Martin
