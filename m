Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F80201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdBYV4U (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 16:56:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34236 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdBYV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 16:56:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id m70so7990122wma.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w1raOQ7Je6od8IbZJpgGb4X8QqRc2dqXktkkuNzQiog=;
        b=lj0jVvwgLiR0jQ0y+FMCpriwZyD7zHujXpcPeVQ62cWNyCjs56XRm8zNXDOu8h2KPX
         D4hsJSA7CgGXM185XuOGpIz1DakH9MzSdNlNm/eE76SuKSTLby99/AZhR6saGI90G1C0
         2Wmq6O5jWyz3Pk7kAscrfOEYYjnN8DHNkniJtaMDVuktQ2r8cRm0H+G1jyWMNi0PCbqT
         LSf2vHRHxyXYoE0bXleWobveHPdqxRIf9S+pW2hN6nmTCdemiRXqy5Ce3RCr6UONupZp
         Ze7NhIF6Bia8cRplhQkOTg0vmcleuzd0Nqb4lZlI6VdSQdlnayhgHzCQz2mkdm5ogTG5
         zAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w1raOQ7Je6od8IbZJpgGb4X8QqRc2dqXktkkuNzQiog=;
        b=ZEjdajL4kA831udkUao0/NJuu6aNNY4VQwGN/dE5OCGn1plpQoHGjSoC0YQm/9wJCx
         IsIukkqK9P83hvXY0a+ld+lgT6vnEDgyky/0DnbvPM+4E10HZC11jNyartZiVNAw8Dnv
         RKHG3qcjBjYBHH+46BwwMreYdigN7W9XVDJnTwmIdhaNf1rw7gskG8YeU370Etvi7IRt
         /v4vTFdRTb9Rx3msgDNDtxKQkO6SLnb0vB3nTLdpxtezxmvdMWnWUC2tx6hNOzJaJeIS
         u0CEd1yA36gT9LZdUC2c3WxScgEFedZCzc4DLHafGKrvzFgX/Ccruj4eCkR81eZUyDpu
         kqlA==
X-Gm-Message-State: AMke39mnVmb7Dqlb4oCxRbD12doNho8vDsi+W1egky194zMS1owm7XD98qcCQ+Qe1fspow==
X-Received: by 10.28.46.19 with SMTP id u19mr506630wmu.1.1488059334253;
        Sat, 25 Feb 2017 13:48:54 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB48D9.dip0.t-ipconnect.de. [93.219.72.217])
        by smtp.gmail.com with ESMTPSA id x14sm15814379wrb.1.2017.02.25.13.48.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Feb 2017 13:48:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] travis-ci: run scan-build every time
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
Date:   Sat, 25 Feb 2017 22:48:52 +0100
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
>=20
> Introduces the scan-build static code analysis tool from the Clang
> project to all Travis CI builds. Installs clang (since scan-build
> needs clang as a dependency) to make this possible (on macOS, also
> updates PATH to allow scan-build to be invoked without referencing the
> full path).

This is a pretty neat idea. However, I think this should become a
dedicated job in a TravisCI build (similar to the Documentation job [1])
because:
 a) We don't want to build and test a scan-build version of Git (AFAIK
    scan-build kind of proxies the compiler to do its job - I don't if
    this has any side effects)
 b) We don't want to slow down the other builds
 c) It should be enough to run scan-build once on Linux per build

I ran scan-build on the current master and it detected 72 potential bugs =
[2].=20
I looked through a few of them and they seem to be legitimate. If the =
list agrees
that running scan-build is a useful thing and that these problems should =
be fixed
then we could:

(1) Add scan-build check to Travis CI but only print errors as warning
(2) Fix the 72 existing bugs over time
(3) Turn scan-build warnings into errors


[1] =
https://github.com/git/git/blob/e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7/.=
travis.yml#L42-L53
[2] https://larsxschneider.github.io/git-scan/


> ---
>=20
> A build with this patch can be found at [1]. Note that if reports =
*are*
> generated, this doesn't allow us to access them, and if we dumped
> the reports as build artifacts, I'm not sure where we would want to
> dump them to.

We could upload the results to a Git repo and then use GitHub pages to =
serve
it. I did that with my run here: =
https://larsxschneider.github.io/git-scan/


> It's worth noting that there seems to be a weird issue with scan-build
> where it *will* generate a report for something locally, but won't do =
it
> on Travis. See [2] for an example where I have a C program with a
> very obvious memory leak but scan-build on Travis doesn't generate
> a report (despite complaining about it in stdout), even though it does
> on my local machine.
>=20
> [1] https://travis-ci.org/sxlijin/git/builds/204853233
> [2] =
https://travis-ci.org/sxlijin/travis-testing/jobs/205025319#L331-L342

Scan-build stores the report in some temp folder. I assume you can't =
access
this folder on TravisCI. Try the scan-build option "-o =
scan-build-results"
to store the report in the local directory.=20


>=20
> .travis.yml | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 9c63c8c3f..1038b1b3d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -20,6 +20,7 @@ addons:
>     - language-pack-is
>     - git-svn
>     - apache2
> +    - clang
>=20
> env:
>   global:
> @@ -78,9 +79,8 @@ before_install:
>       brew update --quiet
>       # Uncomment this if you want to run perf tests:
>       # brew install gnu-time
> -      brew install git-lfs gettext
> -      brew link --force gettext
> -      brew install caskroom/cask/perforce
> +      brew install git-lfs gettext caskroom/cask/perforce llvm
> +      brew link --force gettext llvm

This wouldn't be necessary if we only scan on Linux.


>       ;;
>     esac;
>     echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
> @@ -92,9 +92,9 @@ before_install:
>     mkdir -p $HOME/travis-cache;
>     ln -s $HOME/travis-cache/.prove t/.prove;
>=20
> -before_script: make --jobs=3D2
> +before_script: scan-build make --jobs=3D2

I think we should run it like this:

scan-build -analyze-headers --status-bugs --keep-going =
--force-analyze-debug-code make --jobs=3D2

This way TravisCI would be notified via the return code if scan-build =
detected
errors I think.


> -script: make --quiet test
> +script: scan-build make --quiet test

Why do you want to scan the tests?


Cheers,
Lars=
