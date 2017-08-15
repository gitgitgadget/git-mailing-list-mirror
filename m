Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A306B1F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdHOL05 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:26:57 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37336 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdHOL0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:26:54 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so4149083pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i814jOycviSAyIvX/cvSBwj4XMKOtaVgIQ6tqmDUjUo=;
        b=S3EXEIHzOJmQ/iFo9jXaBc6YcCfZAS50AYITaaoHWab3Z6ttEQHqtFwQ4u4czZafVY
         q0t2WEda5SVhSwfXj9YCVuFMgqAaXPyGGjlXm2JoBc83uZwed7kAHccePi2ksS/ho6aw
         lI6nLboMIAR2Lx5E7rtibaUELJoJrOLPKTKiJI8f4FGuj7Llfo1g0pWXegYrMYTt8hl6
         txgDAs2whkbBzXrS/NZ6hZYRJuPkDwEE7bKhlHEtnhRBV7y3HfHckNUUFSxZrhNRqIB9
         o+c5AqtwhbN/QXR7FQPe4ypaBq5vWfcHy42GrLIQhM+KE96mV/Cp2FYKhu7fFFDdERU5
         Va4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i814jOycviSAyIvX/cvSBwj4XMKOtaVgIQ6tqmDUjUo=;
        b=jaNa08thX7e4Lx1gRVqJ+ZTyB+hUwneq1Uxd0UDumo2Yq5FB9CZr7xzBHvlPJn6vT1
         yVUbddeV64moHXJihNMIVcv9ScK8MHUupT1DsXRebct3mlTGKXmiM2ypq7A6ir8vJcRI
         1SvDw5UnStsjabAUzJDNQPGk++o2dcWMbscGsqoWvt/jNwFUo30aztiWDdH6td+eme62
         57t3JpLJERpxGq47pMScE7k9W74cQ32KBEaJ3yR8geZUnuAJ2xHKLz4Sk0ZCMK1wd7yY
         txQORRYrVNBxeMgrbQZHvqK62Qpgx6zuWcUYrTYOZvyfQtWQlgBQDsM5qK2zsxw/xibW
         093w==
X-Gm-Message-State: AHYfb5gl0YFPlTgKsd0cjLmQYrgB5eX0l20oy2NmdSmaNCWb7+l6ZqWz
        O9hJf86RF38v7f4TgUje0BjDfJgd+A==
X-Received: by 10.84.129.6 with SMTP id 6mr31821470plb.289.1502796414099; Tue,
 15 Aug 2017 04:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 04:26:53 -0700 (PDT)
In-Reply-To: <20170815102334.qc4w7akl44bti44x@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net> <20170815102334.qc4w7akl44bti44x@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 13:26:53 +0200
Message-ID: <CAN0heSrUz2jU2ijeSjYRhvyXA8qpw=JoOhaK-4Fuyv4_1L6Gtw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] interpret-trailers: add --parse convenience option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 12:23, Jeff King <peff@peff.net> wrote:
>  SYNOPSIS
>  --------
>  [verse]
> -'git interpret-trailers' [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
> +'git interpret-trailers' [options] [(--trailer <token>[(=|:)<value>])...] [<file>...]
> +'git interpret-trailers' [options] [--parse] [<file>...]
>
>  DESCRIPTION
>  -----------
> -Help adding 'trailers' lines, that look similar to RFC 822 e-mail
> +Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
>  message.
>
>  This command reads some patches or commit messages from either the
> -<file> arguments or the standard input if no <file> is specified. Then
> -this command applies the arguments passed using the `--trailer`
> -option, if any, to the commit message part of each input file. The
> -result is emitted on the standard output.
> +<file> arguments or the standard input if no <file> is specified. If
> +`--parse` is specified, the output consists of the parsed trailers.
> +
> +Otherwise, the this command applies the arguments passed using the
> +`--trailer` option, if any, to the commit message part of each input
> +file. The result is emitted on the standard output.

"the this"

I think I get why you use --parse above (and in the synopsis), although
it kind of feels like it should be --only-input or perhaps "--only-input
(or --parse)".

--only-input is sort of not covered by the "--parse"-part above, and it
is sort of not covered in the "Otherwise", since --only-input and
--trailer are incompatible. So it is sort of lost. :-) Probably doesn't
matter much. (I'm just thinking out loud without constructive ideas.)
Those who care about such details can continue reading..

Martin
