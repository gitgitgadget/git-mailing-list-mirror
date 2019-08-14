Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE9C1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 12:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHNMia (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 08:38:30 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34960 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNMia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 08:38:30 -0400
Received: by mail-ot1-f53.google.com with SMTP id g17so30920257otl.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+CEHsFArE3i0uk1EhJIcnDyWVDrmmBsBUks1eQRKzA=;
        b=fea6MGkPGfP82i1IvqUF9xUIUUfpRgi+7TCd/WOlshom9bx31WyXbZItkLoZuG8EMJ
         8LoKNW4gf4hmW5A45Mw/mCzE9M8dfb4QECKcsJFT2xEk6lE43ra8GLGSkpgRrCgHskiK
         3YOjzPkMWS+N5uX/gJw0eCsQyi9vWRRCLL7r74RjMK+SH1Kb5LmPmdjTtxA+kWCUAwk4
         /KrjECy5YRF06LGnXULCKdRkiAOpwwWBXPiowcx8OdtUz64aZTRbwEzoB1JrmQ69im1H
         ao2FwuTMtVfv2WbM5RxmEp01TXiQ54OynCTRrJD8bIPfjjAALzff3LrLPcR4T0m2iw8F
         +hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+CEHsFArE3i0uk1EhJIcnDyWVDrmmBsBUks1eQRKzA=;
        b=g23UIGbR4Wi5EWjcdBf8R2rNRnUgjb6KMZMo1muu0YzNZrmJRaPTyWo8zR8g6Pksmn
         JYYpcNn04n2x2YTyrrGmgvTKXvTlGm5U/Du6pI1J2nzhMr1hNEx8EDsXQCvzwwK5/7ya
         E5h1zInOoW8O4+lCXflvQVJPCl4UA8VQ9otnLduIqPd+x3YObsNvWlu/7ern45g2t41m
         c1JeOvTI35McCeeTz5joNiPQTeSH07CgP/xhjXiBX5+6i7wt36Pmdk5EuKION2hN0UO7
         kEhaGSdjVISwoJd+rY0w7+RHCqwzVQLzZuEC+LRKRVRbFxf4kPbiajJdET+FVFsFhUcR
         8OIA==
X-Gm-Message-State: APjAAAV1U6PQYr+F4LrX0fU8iq8uE2Vo1ZSIDdWo/H4UgmsWGvCCUzKe
        ZJGHI4lYTbnoiPEIjtAUgy+TFDH1Lz/hnJa9stY=
X-Google-Smtp-Source: APXvYqytFzesQsk7zfLTBzku5uyM2hEJGPH7Ukzx5OrhRUs6n4uC9Lcs3k+gqsxRupxN3HntwzFATzr6wGAVmrt2ii0=
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr2237907iog.195.1565786309323;
 Wed, 14 Aug 2019 05:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=KXnspgZa=R9=8wvPY-Y8pvuAah-D+Jc4CM_+cdemYGUJ09A@mail.gmail.com>
 <20190814121045.GA30302@sigill.intra.peff.net>
In-Reply-To: <20190814121045.GA30302@sigill.intra.peff.net>
From:   Bo Zhang <zhangbodut@gmail.com>
Date:   Wed, 14 Aug 2019 20:38:18 +0800
Message-ID: <CAO=KXnvrVdTRW=FhKMixSHuR-qahJ2QqUKOn4PerZAVcxVJHww@mail.gmail.com>
Subject: Re: Potential asterisk expansion bug in Windows Git Bash?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much Jeff!

It turns out I ran into
https://bugs.openjdk.java.net/browse/JDK-8131329 on Windows. The
example was also a mistake. Anyway, false alarm, thank you again!

Regards,
Bo

On Wed, Aug 14, 2019 at 8:10 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 14, 2019 at 07:50:47PM +0800, Bo Zhang wrote:
>
> > Today I noticed that on Windows Git Bash, the asterisk (*) is
> > incorrectly expanded even when it=E2=80=99s in a quote or following a
> > backslash (\). I=E2=80=99m wondering if this is the correct behaviour (=
which
> > seems like to me NOT).
> >
> > Step to reproduce (in Windows git bash):
> >
> > zhb@zhb-PC MINGW64 ~/Desktop
> > $ bash --version
> > GNU bash, version 4.4.19(2)-release (x86_64-pc-msys)
> > Copyright (C) 2016 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
.html>
> >
> > This is free software; you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> >
> > zhb@zhb-PC MINGW64 ~/Desktop
> > $ cat 1.sh
> > echo $1
>
> Your script doesn't quote "$1", so whatever you pass in will be subject
> to wildcard expansion inside the shell running the script.
>
> Try this:
>
>   $ cat bad.sh
>   echo $1
>   $ cat good.sh
>   echo "$1"
>
>   $ bash bad.sh '*'
>   bad.sh good.sh
>
>   $ bash good.sh '*'
>   *
>
> > zhb@zhb-PC MINGW64 ~/Desktop
> > $ bash 1.sh '*'
> > $A 1.sh 1.txt
>
> So this is the case I showed above.
>
> > zhb@zhb-PC MINGW64 ~/Desktop
> > $ bash 1.sh "*"
> > $A 1.sh 1.txt
>
> And this is equivalent. The quotes suppress wildcard expansion in your
> interactive shell, but the script itself does another round of
> expansion.
>
> > zhb@zhb-PC MINGW64 ~/Desktop
> > $ bash 1.sh \*
> > 1.sh 1.txt
>
> And same here.
>
> -Peff
