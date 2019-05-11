Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F561F45F
	for <e@80x24.org>; Sat, 11 May 2019 02:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfEKCgi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 22:36:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41617 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKCgh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 22:36:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id o65so6274151ywd.8
        for <git@vger.kernel.org>; Fri, 10 May 2019 19:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q9roFgdzAv5AqpbUUJVlchFmQ3nN5r1N4ccWl0IOCIo=;
        b=v3h4wtIZwQ8BhNRTC/ZP3yo/isB9DVHH/bP772vvTwnXnfMrbgUVkvlH/Jlq651aPH
         yUUGX7FKEpagTywyQgcjhEGWNNQOPQ3Kj0U3G7+UowCQglK9f/jz55qobvT6Mj7GNh0m
         w+bJ3Orl4/4dfLs2igJT9ijjMtbqgSNYKx7Jo1UVraOpS3XR/H0zYY0QhfRHJHTbn+iP
         SogDLgtha0iMK/I8ZPmKEgjaS6pLpERvdgqpHHzYA1tsTqQttsCT17CjWb8PuI8ATrwO
         Z41dZ3q4GkHZnCoUzYTRNGY6JQGpOwUg5QpBIHi9QXEdZz8pH+aufvTrcYQXdwom+U5O
         hwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q9roFgdzAv5AqpbUUJVlchFmQ3nN5r1N4ccWl0IOCIo=;
        b=ALBfxaGgy6Mzs0ftkDpSjX50Od1QML3VoFfrQKNCkrg7nIr0J6nmfC5uxpwfy/3R0u
         iXO6O77UZsTit73XSXHywuAfxjkxQqi4N6xFmsL8YnOlsZfbq+Gpp57cGRtZi4PwrT/i
         cbC1I6QY1tUk4jvRMWfKfpyEE2L9QUymFYkitJSF02AT4fGR+R6yyDExH0z2qyVcZvSk
         pjRPR9jKcA9X7Y+2KUijki7O3VSnBpp34wqgy8RAPZ5khsNV7WXus5r9LWhhbBnvMPdQ
         ie9tE8JptNk5skQ3bccWjNebnG58klKS/LNY4XyF45EDF48Dib5wa5ky0po50NXNsHM6
         FF8Q==
X-Gm-Message-State: APjAAAXNHfj00FZfo8pPlrO2whTorpG9TzZ8UcsMs9wWLQm308fNLduf
        UTaP83Z8ACVG9wPfnOHStOO5dPJc1kdvBCbwhg/iJw==
X-Google-Smtp-Source: APXvYqzmrZQ6j1HJk1G8ZyTIe69/BDy4v++qhC4lNUd3HCKgFmhOUxXKC2SFxNSyjQVU5hL/8i/ls6EKgb5D3b7iGsg=
X-Received: by 2002:a81:314d:: with SMTP id x74mr32694ywx.221.1557542196895;
 Fri, 10 May 2019 19:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190510004715.29298-1-liboxuan@connect.hku.hk> <87woixx556.fsf@evledraar.gmail.com>
In-Reply-To: <87woixx556.fsf@evledraar.gmail.com>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Sat, 11 May 2019 10:36:00 +0800
Message-ID: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
Subject: Re: [PATCH] doc/gitattributes: add Octave
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 11, 2019 at 7:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, May 10 2019, Boxuan Li wrote:
>
> > `matlab` pattern is also suitable for source code
> > in the GNU Octave language.
> >
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> > ---
> >  Documentation/gitattributes.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
> > index 4fb20cd0e9..1b28381bda 100644
> > --- a/Documentation/gitattributes.txt
> > +++ b/Documentation/gitattributes.txt
> > @@ -819,7 +819,7 @@ patterns are available:
> >
> >  - `java` suitable for source code in the Java language.
> >
> > -- `matlab` suitable for source code in the MATLAB language.
> > +- `matlab` suitable for source code in the MATLAB/Octave language.
> >
> >  - `objc` suitable for source code in the Objective-C language.
>
> I've never used either, but browsing our patterns I see:
>
>          "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]]=
.*$",
>
> I.e. that last bit matches ^%%, and then here:
> https://en.wikibooks.org/wiki/MATLAB_Programming/Differences_between_Octa=
ve_and_MATLAB
>
>     MATLAB uses the percent sign '%' to begin a comment. Octave uses
>     both the hash symbol # and the percent sign % interchangeably.
>
> So here we have the "function" pattern matching a comment, right? (this
> doesn't have any tests) and we'd want to add "#" to Octave, but not
> MATLAB.

Thanks, that's a great catch! Actually, '%%' is used to start a code
section in Matlab
(https://www.mathworks.com/help/matlab/matlab_prog/run-sections-of-programs=
.html),
while Octave uses both '%%' and '##'
(https://octave.org/doc/interpreter/Sections.html).

>
> I see both tend to use the ".m" extension. Anyway, isn't it better to
> add an "octave" pattern, and document that they're mostly the same

I agree. I'll send an updated patch soon.

> (although it looks like we can add #-comments, to future-proof
> ourselves?
