Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB621F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAYTYv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:24:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40699 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYTYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:24:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so7713153lfe.7
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GFN0g3yAY17OrTTVBReP1PHDUf2lLolDJz0Gis6j2hk=;
        b=cShI0w+Y0yd0HuvUvlx9ChZGiZNS2ftc7GFIwK1vq3ahnd1mWfr6gHeVg2zQl1dOOa
         dRpKBQ/OwH9ir9maKYWEs8BWMiAhFNSkfnFqki5GSLqpYLiSwXspsAqLunNzmQsMU1SC
         FU4gqI5u5J+GN5lUbORqhJP6EIr0ShzPhPvvMJiV2GtoVMNEeDHtdALSp8O4v3uirKen
         B9Qhls1I+uYPM8cEbbW6RORhaIIJL7kLnz+FSjplX+nTNVBy6TZX77Is0WSeBzDJw7jq
         c7gA9BB3dyvdB3bq8ylNoX/CIkCgfbCl/wiuObnIpnXt+jslAhvYOa+I+cQ77JbXN2+H
         SZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GFN0g3yAY17OrTTVBReP1PHDUf2lLolDJz0Gis6j2hk=;
        b=mjWm/t0nQbj9b6PFMAeOsyYULthzhLPMdozyf31yU5HzHcNsV0rC1wGjMztSvnhKBR
         ZwjuAgU+3Z7teSz4QVzx0U01lVQjIqM4G+R+eqwGkm6KhITX2lWa2Jk/aelwL6UnXYYI
         iDbb3SFq32K6oz0NIFhPhTQ7sJGXN9YL10gLPRdShPyt1Vx2UEIbxsyBgSrR4blviaoc
         6eaueRbiFaBY7YuI+Pz61hH3xDKi7m0Jymg/qabZzf3Xg4/pywyd+RjQJFrxlYVZhf6y
         vKPCy3/adkw1gyhTM5ik7a5eqF7psKFRwZzQx4+CC+SiQDOtZCYp2W8gfrB2b4nDO4Hc
         EKDQ==
X-Gm-Message-State: AJcUukf80eR8jMSs2FbY93fGb3mSbMBH7hgd+x+VJCwCnmIRXU9N8Dya
        DNY47IMEBiPdqwPjkjVLl1xyUJ4HNwLjROavGOtWqWRSn20=
X-Google-Smtp-Source: ALg8bN4O8jgIDYm+gICogMofOaBLJfQB+mzZdg5AIRl56kCXtSuL0VSEPzALputD1sjRKzfuzzr9+GEelsoyMamjr2Y=
X-Received: by 2002:a19:910d:: with SMTP id t13mr9354444lfd.98.1548444288691;
 Fri, 25 Jan 2019 11:24:48 -0800 (PST)
MIME-Version: 1.0
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com> <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net>
In-Reply-To: <20190123055704.GA19601@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 25 Jan 2019 20:24:35 +0100
Message-ID: <CAN0heSoNvTVfC6A8fFK83u4TBX3sLaTJ_NqKwkCZORiCKdVwcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct repository_format`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 Jan 2019 at 06:57, Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 22, 2019 at 10:45:48PM +0100, Martin =C3=85gren wrote:
>
> > Call `clear_...()` at the start of `read_...()` instead of just zeroing
> > the struct, since we sometimes enter the function multiple times. This
> > means that it is important to initialize the struct before calling
> > `read_...()`, so document that.
>
> This part is a little counter-intuitive to me. Is anybody ever going to
> pass in anything except a struct initialized to REPOSITORY_FORMAT_INIT?

I do update all users in git.git, but yeah, out-of-tree users and
in-flight topics would segfault.

> If so, might it be kinder for read_...() to not assume anything about
> the incoming struct, and initialize it from scratch? I.e., not to use
> clear() but just do the initialization step?

I have some vague memory from going down that route and giving up. Now
that I'm looking at it again, I think we can at least try to do
something. We can make sure that "external" users that call into setup.c
are fine (they'll leak, but won't crash). Out-of-tree users inside
setup.c will still be able to trip on this. I don't have much spare time
over the next few days, but I'll get to this.

Or we could accept that we may leak when we end up calling `read()`
multiple times (I could catch all leaks now, but new ones might sneak in
after that) and come back to this after X months, when we can perhaps
afford to be a bit more aggressive.

I guess we could just rename the struct to have the compiler catch
out-of-tree users...

> A caller which calls read_() multiple times would presumably have an
> intervening clear (either their own, or the one done on an error return
> from the read function).
>
> Other than that minor nit, I like the overall shape of this.

Thank you.

Martin
