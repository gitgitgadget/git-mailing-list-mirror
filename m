Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEBE201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdGCV5t (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 17:57:49 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33960 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdGCV5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 17:57:48 -0400
Received: by mail-qt0-f172.google.com with SMTP id 32so153022929qtv.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JCagRnFOiEyjEcxBNhIG2oQf7aifTUj37TKJSskOgkE=;
        b=ZiaHOPFZRGNIoPXEAX9x416HEM0rCol0O0z7X+PSyzQP6QOSKWKeXxKNc2maJxSr4f
         06yMIxzd85DhJ8TdgxbxlXhqFYW4d9tumMqhTqPDKnWVfRCtUc4L0QZS3C1bDgltMZqB
         MDUPc9DFz31aZE1SDfdicINrjWyqr9sqxiz0NymGxxhq4Z/DvBsp/gdf+hip478cQoFg
         jgCIZR5V4LOntTHJ0H5wYLZeqO+ZqBd3s2qG9fBqrQep5yIPRhBqvqmtoi9/aCMP1um/
         P1+hUkrdDrCyJ495WA6W37z61GtA0TkcVgiA0i7EtfJyLbSMVvCDDOpJ+l1p9d9riQyP
         0thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JCagRnFOiEyjEcxBNhIG2oQf7aifTUj37TKJSskOgkE=;
        b=lvnaK90gCq2fBTrdzzP0DowQT10SIoHBI+fFdIlBTRmJaNkTjCYJVqdcVJcPkQb3wd
         CbUCAM92QTNM9DdFiW40xlxI51LFjCdQTzYXKi2Nsj6dHMvi2jp7Y4hArWOCWVKlbA0N
         fFrltx9HNy0BUix46SoyJs9IGJj2kA6HJWQZleXbk55u6e+jeUNurHhJIwj1M2PhAE3Y
         sD5uukw3d6Vz3UyT5Dusn0FsbuydNJch2dSt9hLNP5Uc10MjvTQDMt42uQA1eov+lwEN
         IFQn8SJ7dgrk+jcn77h0u/Rvro0dmUYcsEL7h/21617y9neggwX9QmCj4aEiAc32/VOj
         f8SQ==
X-Gm-Message-State: AKS2vOxvcd1K1s9eLxkSxQmwuOq9j7tY7yxWRvpBBOWccwiXJ2jTwVGN
        oThnLzB3SHc4KrZmPhQ01BCi3nA0D4ID
X-Received: by 10.237.43.35 with SMTP id p32mr43041838qtd.86.1499119067132;
 Mon, 03 Jul 2017 14:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.140.141 with HTTP; Mon, 3 Jul 2017 14:57:06 -0700 (PDT)
In-Reply-To: <871spxchvm.fsf@gmail.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <871spxchvm.fsf@gmail.com>
From:   Francesco Mazzoli <f@mazzo.li>
Date:   Mon, 3 Jul 2017 23:57:06 +0200
Message-ID: <CAPB=P5zY3BHqSJ8bvBPLHRuOritN+R7j5omq5r95VG3zpirFKQ@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 July 2017 at 23:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
>
> On Mon, Jul 03 2017, Francesco Mazzoli jotted:
>
> > The flag can be overridden with `--no-force-with-lease`, or by
> > passing the config via the command line.
>
> Thanks for hacking on this. A couple of things:
>
> * Most things (but not all) that configure `git whatevs --some-option`
>   are configurable via whatevs.someOption, I think this should follow
>   that convention. I.e. be push.forceWithLease not
>   push.alwaysForceWithLease.
>
>   See my
>   https://public-inbox.org/git/20170324231013.23346-1-avarab@gmail.com/
>   patch series for something that went through many of these cases
>   (although I see I didn't send it all to list). Anyway, something like
>   8/10 of our config variables for switches follow that
>   convention. Let's use it for new config.

OK, my worry was about the fact that if I call it like the option I'd bette=
r
support the full range of options available to `--force-with-lease`. Anyway=
,
I'll change the name.

> * It makes sense to also document this the git-push manpage. See
>   e.g. how we document --follow-tags:
>
>       Push all the refs that [...] This can also be specified with
>       configuration variable push.followTags. For more information, see
>       push.followTags in git-config(1).
>
>    You should add something like that to --force-with-lease.

OK, will do.
