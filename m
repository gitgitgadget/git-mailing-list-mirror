Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF991F453
	for <e@80x24.org>; Thu,  8 Nov 2018 14:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKIABm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 19:01:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40557 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKIABl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 19:01:41 -0500
Received: by mail-io1-f68.google.com with SMTP id a23-v6so14736238iod.7
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjIwfhcqGmdEXmOADM1dw9it1uxMBVBjIgvfQyUuB78=;
        b=Cg7itPCKNzGWJYk7JpXvdraxuiSPWgln+JIX8L87kKz1sD9SmYa5ivSV3z4BHgj/A7
         7/subWSRX1cekg2DUgloTOtnMDzCE6GqxIHwbS8wOuTNgQD8FBgeCvFfg49BJ11agYjO
         Rb7z8gXmPswKgIKra76oujagV4IYZ3PKnlW3jve+stKD+1v0Gh14sihRzD2QXQmoKihg
         GH8+k8M+CcdIb+xAbfZAYQPgtkDBUka10PrQUnbVE643Vexhy2U7cbeBHePO6QDHz0Ej
         QkiXlPLmFTyfH5yaQXl85X0V6r428p9UZS5zp7xI1vW6Bh1z91hI+wWGgEFxfuAUhnGl
         WCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjIwfhcqGmdEXmOADM1dw9it1uxMBVBjIgvfQyUuB78=;
        b=J59AxXemhtEO9GXhtNLsImpc+DGTnwNcaKMHEeSv9BIUnr9xdXZSTfkK/W5/af9pum
         5gc6NffB+Kg5eHMPYI3TUtcZXtxSxAs4B41Wxy6nZsSGhZT4+x+WHT5KoP3kQjlm1uVZ
         k3zQnieUH1BBr/ITM5dJqZ9+y5XuntRBaLLW2jmvIdbgmtOJ58m4/HAjB8aw3qzfvkKG
         2eqXzKJ9NagfLayUW8VA+jauVKuJqZMyHu3LTMC2GvfzvGkllFxLNh/muJhE9TwHZGP6
         b86lUr+Z7K9wsz2hM5CG7CrEGl9DA3MX2LDmXt6SS1mcM52nII+SbH3qQ9zkU8cP6d7B
         4UPQ==
X-Gm-Message-State: AGRZ1gKFhnMAEzemjGV2VU4yeMWSbgelt1E4E2+n5AAMXzh2wX38V2A2
        47bIatYY0zx/OUlJtyAMpmox6nbnPz5JpqvEvdk=
X-Google-Smtp-Source: AJdET5cvXDhdXlClDxuS7q+FtjOd/Fuzh+2AvmHp9UpNNRzjJA8f3lpIEYdddeDjwLmDThg8iP4YNhwTwzZ+DFq/BXQ=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr3855677ioc.118.1541687157282;
 Thu, 08 Nov 2018 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Nov 2018 15:25:30 +0100
Message-ID: <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 2:14 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Peff,
>
> On Wed, 7 Nov 2018, Jeff King wrote:
>
> > All that said, if we're just interested in allowing this for config,
> > then we already have such a wrapper function: git_config_pathname().
>
> Good point. I agree that `git_config_pathname()` is a better home for this
> feature than `expand_user_path()`.
>
> But now I have a really crazy idea: how about ~~/ssl/certs/ca-bundle.crt?
> The `~` prefix is *already* a reserved character, and while it would
> probably not be super intuitive to have `~~` be expanded to the runtime
> prefix, at least it would be less ambiguous than `$RUNTIME_PREFIX` (which
> *is* a valid directory name).

One thing I had in mind when proposing $VARIABLE is that it opens up a
namespace for us to expand more things (*) for example $GIT_DIR (from
~/.gitconfig).

(*) but in a controlled way, it may look like an environment variable,
but we only accept a selected few. And it's only expanded at the
beginning of a path.

> Of course, `~~` is also a valid directory name, but then, so is `~` and we
> do not have any way to specify *that* because `expand_user_path()` will
> always expand it to the home directory. Or am I wrong? Do we have a way to
> disable the expansion?
>
> Ciao,
> Dscho



-- 
Duy
