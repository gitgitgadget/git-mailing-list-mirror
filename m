Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D891F461
	for <e@80x24.org>; Thu, 27 Jun 2019 10:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfF0Kt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 06:49:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38284 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfF0Kt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:27 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so3703827ioa.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjjsRW75Zfdaz62jZYom37Fh6xv8+bYyvoWjAjGhC5I=;
        b=IvTUGTGr75738vnUT8p7gPKlqUzE12T1iXsif0+IzS08JG+vF5YiK6Dguxt25LSQCO
         gX2n2wugvDDEcQAxO25Qi/OKyP7tDDRb9jeXK0tlfWsmoAXJOPs7B2PjmZtGquktv+pN
         zTwkRl/3OxmbY6tZadoAPj1ti8+JUhxoHhWsxKY73P7FCFeyo1Lt7QNK56U1mqHvd6WB
         c+p6Ry2gjtHqhDcDibE05hLI2l1RpkdIrJu66RiwCJ5Sx/N8JWjFHvaNALcLaYXtAQvj
         s97d6qo7ymtEO/SIW2W2YeGVuW9ycljaVIsrbuMGBbzlm+67auaC1ltX2Tvl3QcQKO3v
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjjsRW75Zfdaz62jZYom37Fh6xv8+bYyvoWjAjGhC5I=;
        b=RbWeVBeoImEGJ5wUDcXz8kjHm2Ei3iLaA6FRr3twroAKW/JwAobsRTrRM01XvmZRMm
         5lvxFli1s/tNMBB2zelGooXbRaVS1eAYlixKTadJPQmPvXcfGgo0uTA4q81s3Y9lgdnI
         xn0s16FeJSaD0hsU3YK/ls3quJasQCN7o1YNpVFljKAgGF1cjmAQlLsYu4ogMp93A1EP
         4dM53vtF7OHyZkFABwixFmnbbdUexIZtGbc0gRUDWuI9/ZJpDmcO2mRjSBCQidGwdRDg
         0xeUGJ5eG86aghooRVOC2HH99e44dp4lpPCqAmYbOrPG2secCPknaqt1xP0FXOOPM7vq
         eT6g==
X-Gm-Message-State: APjAAAWpCydLd7LRis7N+1WI3l4lbyxcBGy2lshv+7sjU2woFjE2HIJc
        tCWJs9WyKkzlzXeVkf0WhnFKTdHMP3I2AfY7+pw=
X-Google-Smtp-Source: APXvYqyVNRWvzvdlNgyU3aBI18/Mvx1TZWXDTbxmUg5Bmg5cgwe9nNlXdZTJYlbWT51PbUqvoeakRVhZy5WEleQR2/o=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr3551481ioh.156.1561632565817;
 Thu, 27 Jun 2019 03:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com> <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
 <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com>
In-Reply-To: <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 17:48:59 +0700
Message-ID: <CACsJy8CwWvKNbYvDqWc-zCwEPc_rz-P4y-SvXV-9jL8_XCFjZQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 7:40 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/25/2019 6:29 AM, Duy Nguyen wrote:
> > On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >> I'm curious how big these EWAHs will be in practice and
> >> how useful an array of integers will be (especially as the
> >> pretty format will be one integer per line).  Perhaps it
> >> would helpful to have an extended example in one of the
> >> tests.
> >
> > It's one integer per updated entry. So if you have a giant index and
> > updated every single one of them, the EWAH bitmap contains that many
> > integers.
> >
> > If it was easy to just merge these bitmaps back to the entry (e.g. in
> > this example, add "replaced": true to entry zero) I would have done
> > it. But we dump as we stream and it's already too late to do it.
> >
> >> Would it be better to have the caller of ewah_each_bit()
> >> build a hex or bit string in a strbuf and then write it
> >> as a single string?
> >
> > I don't think the current EWAH representation is easy to read in the
> > first place. You'll probably have to run through some script to update
> > the main entries part and will have a much better view, but that's
> > pretty quick. If it's for scripts, then it's probably best to keep as
> > an array of integers, not a string. Less post processing.
>
> I don't think the intent is to dump the EWAH directly, but instead to
> dump a string of the uncompressed bitmap. Something like:
>
>         "delete_bitmap" : "01101101101"
>
> instead of
>
>         "delete_bitmap" : [ 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1 ]

I get this part. But the numbers in the array were the position of the
set bits. It's not showing just the actual bit map.

The same bitmap would be currently displayed as

 "delete_bitmap": [ 1, 2, 4, 5, 7, 8, 9, 11 ]

And that maps back to the entry[1], entry[2], entry[4]... in the index
being deleted from the base index. So displaying as a real bit map
actually adds more work for both the reader and the tool because you
have to calculate the position either way. And it gets harder if the
bit you're intereted in is on the far right.

> > Another reason for not merging to one string (might not be a very good
> > argument though) is to help diff between two indexes.
> > One-number-per-line works well with "git diff --no-index" while one
> > long string is a bit harder. I did this kind of comparison when I made
> > changes in read-cache.c and wanted to check if the new index file is
> > completely broken, or just slighly broken.
>
> You're right that the diff of the json output is an interesting
> use, and the "single string" output is not helpful. What about
> batches of 64-bit strings? For example:
>
>         "delete_bitmap" : [
>                 "0101010101010101010101010101010101010101010101010101010101010101",
>                 "0101010101010101010101010101010101010101010101010101010101010101",
>                 "0101010101010101010101010101010101010101010101010101010101010101",
>                 "01010101010101"
>         ]
>
> This could be a happy medium between the two options, but does require
> some extra work in the formatter.

And the reader/parser too since you have to join that array back in
one string first.
--
Duy
