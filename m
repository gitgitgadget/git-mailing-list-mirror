Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB35820248
	for <e@80x24.org>; Mon, 11 Mar 2019 23:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfCKXxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 19:53:25 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:37428 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKXxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 19:53:24 -0400
Received: by mail-io1-f46.google.com with SMTP id x7so482186ioh.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jX0VQoocihvt8sAeCGNOLuKRqCjLnL9wQJ32wkxQfOU=;
        b=Rzxu7mXziwPevAvrueOLSot2muOPzZP3TK3zPGLu8Layy3G1VBAWrI/kRuZy0glrij
         rU7akK2SlLZihlC+yW4oLpXP/bX90YEPsok12ggbi03sfS00qhoLeDjg1xMjBHrXW5j0
         1+chE5q4Lvmx6C7j0cCVPP7n44mk4BRxVIkD8zvUS2nR5rZGe7ap6bpF1X3KB1rfOntV
         rQTPGUwR4D6PSAzs6UsIJipTEVIhF3WMyP/Z1p+goFi5/CvXcDiMoe1zyb/uPJK135bS
         ETrZxwiB2W5hXOy7Fch7ZuMf6VYOvWvZ+oHZd1L8eaND3VD/BN4djlNxExP/cMlt6sub
         6bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jX0VQoocihvt8sAeCGNOLuKRqCjLnL9wQJ32wkxQfOU=;
        b=EjCx9+bbQwl6mJRfhM0DozMvf4rDHbD96NLjrjap021cc2iXuGC6zG2f2ANJZBAmp+
         inykv2BVEcbcroTa2CYOY2ebfJzmyAA/zC05DRv+wP/yGibo3GFn+vBZSRXbBJKmeZh3
         /ynfJksxULSJU4yW7QezwtQO3u8g8i7p1H8lU1oXDfgyuB8jCBd1yPjYtDpuJ674hfGZ
         UjoDBdAQcjwuu1865TMhc6o26OXWudyZN1MVSkyLwChebRwCiRC0gDgq51092bioxuvZ
         x8wvNnnlKFAr94edTq+3fn5Hn67OJwdONzVeVZy40JAMPGl6Z8/Yz6lHk1Gve7TfKcpX
         A2rw==
X-Gm-Message-State: APjAAAVKy0LAZJ5Ce81/5A09gg8RVkZXl/oYfWOy2t6GVVQ1oW1cAEvO
        Lk017Wr/j7wYVqCXXkQcLn2IfrdEUlA9Bdmw9Ryoqbef
X-Google-Smtp-Source: APXvYqzs+zgRNnRhA1DG3NFOKkAyxSAN0fAkHXrIg1gxR269iFxWnZJdp8YOEiibSUvx+jtV7hCmIoUunBWjUYu8CHA=
X-Received: by 2002:a5d:9806:: with SMTP id a6mr12135755iol.296.1552348404059;
 Mon, 11 Mar 2019 16:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
In-Reply-To: <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 19:52:54 -0400
Message-ID: <CAH8yC8=YrZR=j9R8Ae+O2UzfxB_Hc1Osu68T-M1mczHiEasfJQ@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> [cc:+=C3=86var]
>
> On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote=
:
> > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > I put /usr/gnu/bin first on-path.
>
> The first question is if you are really running GNU 'sed'? My guess is
> "no, it's still picking up Solaris's 'sed'".

Yeah, you're right:

$ make test V=3D1
...

gmake -C t/ all
gmake[1]: Entering directory `/export/home/jwalton/Build-Scripts/git-2.21.0=
/t'
rm -f -r 'test-results'
SED VERSION: sed: illegal option -- version

I wonder why ... Let me check if I am exporting PATH.

Jeff
