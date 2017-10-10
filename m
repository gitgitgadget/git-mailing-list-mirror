Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430EF2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbdJJREp (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 13:04:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33280 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbdJJREn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 13:04:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id m28so36897606pfi.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ln0ztltlSEkU23Jj5wLZbaFKBon8U9z3kzHZR1zEvoc=;
        b=gb5sCnj3UWkNbaptFK7JSqMMKeFJhisbx7/UXK1M1xgdAwyB716TqL8Y5gwuLxRRhy
         DLtJBhtJ9ReFjqRusXo/FNUNQNFL3mZ1a9eUtP4tizPmeGkJjKSBgfuQXy03gsiAj6df
         s/OO77+xjd7ZeckBPzj9rbmh0vR3f4wAr2xHapnifHrRdRYgSWPmb+2TmXYOQ/9OZp0/
         iQ+3kmoxW0xynWYcjASQ2NAsYH/EJlF+zqV5oGof6ELJmwnjDwM0e42ZhpDWLPRXCeNU
         SPkO7HnZ4yj6DzKjxM4pmAPMVj+WuDLx9SQK6MJVfFQv9i92kE46aPhWwY7HEyUNbNH7
         iVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ln0ztltlSEkU23Jj5wLZbaFKBon8U9z3kzHZR1zEvoc=;
        b=PvKyrAYbuxQY7DIsqB85MgoyLCfcU9ynTk45ga/U4Vq3ATDAOIQk8GdGarZJDJ0Yhi
         srpVUaL4667dMreK2FXJjQrrxoxP8sKGGf5bE7f4qT5YGRMF8/nC4Ccu/4n3kiv8ZT/u
         Ttu4O3EQkjMTh8IDLh5sWgbG+jy8RU7gOVvZq+yqSkBCPVDD7ifh6U+fOp52AP0Lf8zo
         xZBMfyMnbtAlJWJ+s40MaAwTSh65OFEk4mMh91546jqukTRodI9t1duUck3CKaFDFems
         1j4ExnxahNUwqBmEE6ZLIneAYKArdcb+NMFa7itpIqTmVGpkorS0ROYkPTYVmHPs4OSZ
         MjEQ==
X-Gm-Message-State: AMCzsaXECw3jRMVGzrdquLogsEBEB9ZF6jVP935vTo/eqtDg0dMB24d8
        QKW51L3JH3zETT3mngY1H0GzkcRg42ISfbj5BCWlrqkf
X-Google-Smtp-Source: AOwi7QD+BAMe8bhvEyKL3pBnI5zAv/iKurU5gAvWGEfovLlC92hgkbw72wak6TFCVqgNorSw0z05nQqbKfd5y1Kfk1E=
X-Received: by 10.159.206.134 with SMTP id bg6mr12724263plb.273.1507655083293;
 Tue, 10 Oct 2017 10:04:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 10 Oct 2017 10:04:42 -0700 (PDT)
In-Reply-To: <20171010142930.vao2nqg4pv7f2znk@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info> <20171010141019.3vfowj4fvxdvvl3c@sigill.intra.peff.net>
 <20171010142930.vao2nqg4pv7f2znk@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Oct 2017 19:04:42 +0200
Message-ID: <CAN0heSr5EN2Ls5Xd-Sg6b-z9WsJM9s1xB7ZczDkRgv79hxhsaA@mail.gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 October 2017 at 16:29, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 10, 2017 at 10:10:19AM -0400, Jeff King wrote:
>
> it will randomly succeed or fail, depending on whether sed manages to
> read the input before the stdin terminal is closed.
>
> I'm not sure of an easy way to fix test-terminal, but we could work
> around it like this (which also uses "-p" to actually invoke the pager,
> and uses a pager that makes it clear when it's being run):
>
> diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> index 9441145bf0..d322c3b745 100755
> --- a/t/t9002-column.sh
> +++ b/t/t9002-column.sh
> @@ -180,14 +180,14 @@ EOF
>
>  test_expect_success TTY '20 columns, mode auto, pager' '
>         cat >expected <<\EOF &&
> -one    seven
> -two    eight
> -three  nine
> -four   ten
> -five   eleven
> -six
> +paged:one    seven
> +paged:two    eight
> +paged:three  nine
> +paged:four   ten
> +paged:five   eleven
> +paged:six
>  EOF
> -       test_terminal env PAGER="cat|cat" git column --mode=auto <lista >actual &&
> +       test_terminal env PAGER="sed s/^/paged:/" sh -c "git -p column --mode=auto <lista" >actual &&
>         test_cmp expected actual
>  '
>  test_done

Makes sense. FWIW, I don't see the flakyness with this.

> All that said, I think I'd just as soon test a real command like "git
> tag", which doesn't care about reading from stdin.

For reference for Kevin, in case you consider testing, e.g., git tag,
the main reason I referred to the test I posted as "hacky", was that I
just inserted it at a more-or-less random place in t7006. So it had to
play with `git reset` to avoid upsetting the later tests. It could
obviously go to the end instead, but I was too lazy to move it and
define a pager.
