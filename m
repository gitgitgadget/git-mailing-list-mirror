Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D07C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 20:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4EA2145D
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cuOpu0OO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgIGUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:09:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:39607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 16:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599509370;
        bh=Yn9bL0e/X/PAnr1blDQdf8ex/P+pOW5KZ8h2u72O9s4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cuOpu0OOOQ73WON9T9DVL4LiLXSl5SAhcvDl2EyEhLqC3qaJy62pAnbXOJdyYM8+k
         2tS3nDeNfJNn4OPZWPIUdmgP090zMcCRdSDg2U7rL6HlWCAfJfaUYzhb1WcDsIu74N
         Pc/f9gPBcBzD14MoMx9hX6bukdNYMhZaTsmY26GE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1kR7JF0BqJ-00xMyY; Mon, 07
 Sep 2020 22:09:30 +0200
Date:   Mon, 7 Sep 2020 22:09:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] contrib/buildsystems: fix expat library name for generated
 vcxproj
In-Reply-To: <pull.728.git.1599458405948.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009072208430.56@tvgsbejvaqbjf.bet>
References: <pull.728.git.1599458405948.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QgtrLpgvz7EwYuCQVnHBnkJrzu3MlmiBXyiNUgV6qi3GcefowBQ
 Elsdras8lE59BhHCyOL3p2aLk06LjQqckSoAszv9Sixqfp+kV4pjsXCSNocBNh9j3Ujjmqd
 BpvBxQitmirXpNL3MiFCJA6WmmZUBdkOxt6oaKW2z4e1aTDH4q+DYeK0OXtuEEH8lxiJkyy
 GqTakDzVnWeToE/NUAtAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xiAcVDVRI9s=:nnyoJXTQd5o5O/uRxRDBK3
 5et31SqrGfIsUA2XhAGm55O3Ml3uN8A2Qa4o854eKCc1ZPd3wrstXJ8NHox4yS1wQfq8yOViA
 i6Y+rBoe+igFQiNa9aThQ8HQLqMBLvHnW4467Ky0fjDxjzbcOmVc2p5QKAa7A9hCYwd1xUgJh
 tiswh/GGZ29lv/ZJHuDzZxYVbUNY/f9j5NkfCBuzNWKJnAdqoIGgRfTWdCTVfHybp9yB9wXgN
 LChQ546IXS+1CYuqfRM7ALGNujmqRymjTm1B35bDDdJInyWuNfTw55dpBMqeEAsWlfzVBFTo6
 KzAjrQpYWwbxT3JcCMfyP3ZkGmw3DUJFkVjF7gU5wRgdDDriySo6N/NX+tMM0m78WArn5tJNg
 Zm4qrsug12tV5FPoR4RSJE3CUwg8v0xCl81U0Inz3/N5zIFOOyBDSkUxaBSIQYl33L4AuG2VV
 LYEjYMNA5rYL+nNAye7dYijFeJYZ7rV6n1gRU9AUfSaVminKo9U7IurNNqnYAurP6QAjqpTka
 0WFQB8BQ4/53TtujcWw3bcHxZKLTsDmU0t2r5kM3uds3hqHgW8OFkvJ+SddlFwRtxcoCyCYOr
 E+JY3V868RZyLZ/gngjsrmGcPsPQF+CyVr3grV5io5BlpyUjoWphbHbyDv+nMhL4uLyuTH/FD
 1JgA5xz0vPALKvDBIFAgSOcQ6cEOEFDEgcF23tRQaWeLg4ZRhRy6dnrQECKtJR1UYcxjrAfWZ
 FUjcdKZ5so19LaA+Ik46QSAxcaTRVoU3GF6NZBkG0/C3DbRcJ5pZGbFZMxH+yUI9gLOQ4slTb
 gP4l1Trct0rzRekpuSDWS81kz1ov1pe/peFQAffe3oWDhh/TbC13fUG4Zk3UQqN8xJ6Hjn4bc
 +Pb3jOEt+0cyQybD8YL62wFOfUm9mGV3tyi2KNjAIMohjLKVw3vwJ2fY3Lan7qugmDtYpwOUw
 AjlclXDA19tZ1BMyyiUpkSDkr48kOk8M1zFrUBp+z0MgabcR4qCjGutU7Q+DfbHMfmrs7pEvJ
 ASxUdSzcfL6RY9T1bewNGOYCxuHNj57WlsgzXWDb2QyNhbbSkv1HGW3ukAO7XD5ib/uSBhyTs
 /6jiQMcr5iWw31oQBGKyb0aDIwDrCfkSb84X4+mx+4KDv1vGNkiEm7uBX5gWdsEdyIdZrlz24
 5MeehKfcBao6WC5S9SVCaengfFFoHl4xYZmZpyS4qigWPdAG9XaNwTWDdC/CCT9PPU/HtGcP5
 2q1Xr/2NUrpbo3XyFjgmK0mKSzFn4lm0w+hrM0g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Mon, 7 Sep 2020, Orgad Shaneh via GitGitGadget wrote:

> From: Orgad Shaneh <orgads@gmail.com>
>
> expat.lib -> libexpat.lib (libexpatd.lib for debug build).

Good point, I forgot to verify that this is also needed for `vcxproj`, not
only for `MSVC=3D1`...

Thanks,
Dscho

>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     contrib/buildsystems: fix expat library name for generated vcxproj
>
>     expat.lib -> libexpat.lib (libexpatd.lib for debug build).
>
>     Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-728%2F=
orgads%2Fvcxproj-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-728/orgad=
s/vcxproj-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/728
>
>  contrib/buildsystems/Generators/Vcxproj.pm | 1 +
>  contrib/buildsystems/engine.pl             | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/builds=
ystems/Generators/Vcxproj.pm
> index 5c666f9ac0..d2584450ba 100644
> --- a/contrib/buildsystems/Generators/Vcxproj.pm
> +++ b/contrib/buildsystems/Generators/Vcxproj.pm
> @@ -80,6 +80,7 @@ sub createProject {
>        $libs_release =3D join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib=
\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
>        $libs_debug =3D $libs_release;
>        $libs_debug =3D~ s/zlib\.lib/zlibd\.lib/g;
> +      $libs_debug =3D~ s/libexpat\.lib/libexpatd\.lib/g;
>        $libs_debug =3D~ s/libcurl\.lib/libcurl-d\.lib/g;
>      }
>
> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engin=
e.pl
> index 070978506a..2ff9620459 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -349,7 +349,7 @@ sub handleLinkLine
>          } elsif ("$part" eq "-lcurl") {
>              push(@libs, "libcurl.lib");
>          } elsif ("$part" eq "-lexpat") {
> -            push(@libs, "expat.lib");
> +            push(@libs, "libexpat.lib");
>          } elsif ("$part" eq "-liconv") {
>              push(@libs, "libiconv.lib");
>          } elsif ($part =3D~ /^[-\/]/) {
>
> base-commit: e19713638985533ce461db072b49112da5bd2042
> --
> gitgitgadget
>
