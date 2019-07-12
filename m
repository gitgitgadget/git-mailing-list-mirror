Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4681F461
	for <e@80x24.org>; Fri, 12 Jul 2019 19:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGLTMI (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 15:12:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45019 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGLTMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 15:12:08 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so22641012iob.11
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PN0C7riqDf5L+J44Zc1wfBmc5eQvei5byyO6ejhvzU=;
        b=Nn27X4IUp7YjJOrMUiGVkjyYMLTaYQo596yw5Q2SpjkljiNVhTxLivEfcsTYCq9N9z
         A14IdsLacG+zLNnHAg+Wym0DCBJLLe+pDduLu8UqxiiJjoXU4/3Lgs5jTY27iq/DVn2Q
         1674FhGMX5CYIEaf6qamnZlUNyvHdYbOqrVkZnkz+6kQYly5TI3aGeunZv6rM5HXeq5j
         /WUk65hqbln6TyNQB7lyQgc9VpLoAaeJARS6ww26u8Z9iPkumnKHkp83BPzH6Qn+gSF2
         wQYsfesJykAFY0sjdWvO4KqgQFqLJ5ePwTlHgXS9y+eob9fhfXx/3tnvTOXKeMSuUKCo
         Tsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PN0C7riqDf5L+J44Zc1wfBmc5eQvei5byyO6ejhvzU=;
        b=RtKbLBphCpkswnL9WDooqkreMSU1bs/yHUdjkp8nGYN+OtFY0aOht+dDQNAkhVCx0g
         cqp1FIm4W2OPKfLm32muaaEtTLfahH6ToF91CqXFulwnl3KPPJDSPbUMQqHkrTQABeTR
         vWiR30+EQciD5kvuy2RBx2v4aFZiaiDroz7HL46/ys2wFKv/3KVWr+WOsjnLHJAIH0Sy
         cgw/fGeAPKijIR0zttBR2F61/l2vvLrJi8mwydFifCLzozJF5804+QpnLtkBek/mGX7G
         G7Ufix3nAHtR+Pxhs0j+aPEuz7Umn7+26JOXYEoPGGk/W/p5E/26kZce49vFIVFIbj6K
         eDQw==
X-Gm-Message-State: APjAAAXaMdBFDqJSsqeTYZY3k+ET6Yd28uz3lyeengxebgtpPi10TqSd
        UqBDeggL0PucViU8dlt5xDQylykFWxCjkLaSLn1WMQ==
X-Google-Smtp-Source: APXvYqzFfsNhsjdvKLK6apAQfgNvnHLMKRTd+yR8+1UnO5shbyhbeMs3XI1bnAHAUcnbeeOxPjflr4hd77voiWI1DKs=
X-Received: by 2002:a02:cc50:: with SMTP id i16mr13273139jaq.50.1562958727057;
 Fri, 12 Jul 2019 12:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.285.git.gitgitgadget@gmail.com> <e2daf21f1f2574a79f83d4e66591f67b1c937efe.1562945635.git.gitgitgadget@gmail.com>
 <xmqqtvbrp5c5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvbrp5c5.fsf@gitster-ct.c.googlers.com>
From:   Robert Morgan <robert.thomas.morgan@gmail.com>
Date:   Fri, 12 Jul 2019 14:11:56 -0500
Message-ID: <CAMgm5nNX5qF18MBQKBkkctqvFMwfd5q8XvymSdTfEncKXeiKVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpg(docs): use correct --verify syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio.

I was looking at 'smimesign' and working to understand how, when set
within 'gpg.program', it conformed with gpg's usage within git
sign,verify etc.  I happened to look at the docs for the 'gpg.program'
config variable and noticed the discrepancy.

Thanks again,
Robert

On Fri, Jul 12, 2019 at 11:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Robert Morgan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> > index f999f8ea49..cce2c89245 100644
> > --- a/Documentation/config/gpg.txt
> > +++ b/Documentation/config/gpg.txt
> > @@ -2,7 +2,7 @@ gpg.program::
> >       Use this custom program instead of "`gpg`" found on `$PATH` when
> >       making or verifying a PGP signature. The program must support the
> >       same command-line interface as GPG, namely, to verify a detached
> > -     signature, "`gpg --verify $file - <$signature`" is run, and the
> > +     signature, "`gpg --verify $signature - <$file`" is run, and the
> >       program is expected to signal a good signature by exiting with
> >       code 0, and to generate an ASCII-armored detached signature, the
> >       standard input of "`gpg -bsau $key`" is fed with the contents to be
>
> Wow.  Good find.
>
> gpg-interface.c::verify_signed_buffer() takes a detached signature
> in core, writes it to a temporary file and runs
>
>     gpg --status-fd=1 --verify $the_temporary_file
>
> and the payload that is supposed to match the given signature is fed
> via the standard input, so the above documentation is the only thing
> that needs fixing, which is good ;-)
>
> Thanks.
>
>
>
