Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0081F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeKGVsx (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 16:48:53 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41821 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeKGVsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 16:48:52 -0500
Received: by mail-oi1-f172.google.com with SMTP id g188-v6so7649817oif.8
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pR7yAoUWwB9FuRrlauUd3vMo/OM2MzkQ7Bg8rLGOX04=;
        b=H+xFiKrU/YcGE/hD7f7DjZRcHMIY5svPA7gCRfUQZIS8HU7C3Se9Txul2gGJ21kFu8
         fu4ni8Xdpm3EloOvLKhmUXBWUcuqYib9eaNKybE91bUjENtDqayIbSgVEQ9p1X1VJ0tp
         v9rS0ZzCPrb6bLXQ+RcLBzNbXHq1ONQcdbEcIoy1GBZd8qlsFXVI4BEa8klOMkvGgWzg
         YuV6X1xDJrhmWnW8xBMgBQYxEANGcvodjmLg0aK+652gWI8Q2UCv9fMQqx9w21/WmHxT
         MlaNeH+ghdNBZHzkT5TJLIznRYYQe91BO30mPm/pRJjYz7wkkeat/6rkYudufUgEjc+2
         MKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pR7yAoUWwB9FuRrlauUd3vMo/OM2MzkQ7Bg8rLGOX04=;
        b=sqhOWiQe6T85PrzOqvfK1EgPGL6fim41PZjelHHB8i7WaepL9YrJvtbp4fmPzp2YAF
         VX9+LZjCBjQGb5gX81hZuMMTzWisLC7NJ1ZP93u4J0SLAFIJ1/LjekueJpdfhc4M9eJM
         3GPFIJ7H1KhgFZI0eQ20oZcjgHs1t5htLMW7FJAd8zZMFd6IDztixWEmOoR3XtkmME0t
         4gk86zkJ2nmzomgNGl1nR7i+x28dmBeIVzttpF8RTouIgp/7AmQvOgDDpL/vYX3JaG8A
         DnJKVck0tfKb22xMcSKFCeCuSzFlLKgH8lFreUjTe15Tyupa58VsqjvOYVSClxxLN2Qo
         UOkg==
X-Gm-Message-State: AGRZ1gKu0XgGeEIwNiCx+I2O8jwmjSR5r4ewT7/l0OSuBojeynjfjdsC
        yBDT3GFHkUlwGWNVtx+qsH2mmHO5UIaavIumP5/zuqO0
X-Google-Smtp-Source: AJdET5fOugHcASWKEkFUKJTwAoh/q9Z9GAgka32g2HqTRQVrjiPxlUwt4ikF8EH5grKyLU7kug9p4rPK6FNUHENEYck=
X-Received: by 2002:aca:48d4:: with SMTP id v203-v6mr863274oia.69.1541593123636;
 Wed, 07 Nov 2018 04:18:43 -0800 (PST)
MIME-Version: 1.0
References: <CAJosSJ4eKJfa4s+3LcP3Q5qatcg3aFjh9H=Q9bETnkROu06+KQ@mail.gmail.com>
In-Reply-To: <CAJosSJ4eKJfa4s+3LcP3Q5qatcg3aFjh9H=Q9bETnkROu06+KQ@mail.gmail.com>
From:   yan ke <yanke131415@gmail.com>
Date:   Wed, 7 Nov 2018 20:18:32 +0800
Message-ID: <CAJosSJ75G8-ThqCG4ky5LXAQ0a41iRQweYwdx0st+bM4Zf78GQ@mail.gmail.com>
Subject: Re: build error on mac os 10.14.1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solved, It is because the macOS SDK headers loss in 10.14.1.  Need
install command line tool 10.1 and install the header package in
/Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10=
.14.pkg

So  I think the git make configure need check the SDK header to get
the correct reason of build fail
yan ke <yanke131415@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello
>
>     when build on mac os 10.14.1 with the master branch, I got the
> error as blew, so what is wrong?
>
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clangclang: error: linker command failed with exit code 1 (use -v to
> see invocation)
> : error: linker command failed with exit code 1 (use -v to see invocation=
)
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> clangmake: *** [Makefile:2369: git-shell] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** [Makefile:2369: git-sh-i18n--envsubst] Error 1
> : error: linker command failed with exit code 1 (use -v to see invocation=
)
> clang: make: *** [Makefile:2369: git-credential-cache--daemon] Error 1
> error: linker command failed with exit code 1 (use -v to see invocation)
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2369: git-credential-cache] Error 1
> make: *** [Makefile:2369: git-credential-store] Error 1
> make: *** [Makefile:2383: git-remote-testsvn] Error 1
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2393: git-remote-http] Error 1
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2369: git-http-backend] Error 1
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2372: git-imap-send] Error 1
> make: *** [Makefile:2379: git-http-push] Error 1
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2376: git-http-fetch] Error 1
> make: *** [Makefile:2369: git-daemon] Error 1
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2369: git-fast-import] Error 1
> ld: archive has no table of contents file 'xdiff/lib.a' for architecture =
x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
> make: *** [Makefile:2046: git] Error 1
