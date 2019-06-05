Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991E81F462
	for <e@80x24.org>; Wed,  5 Jun 2019 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfFEMhd (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 08:37:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:60091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfFEMhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 08:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559738251;
        bh=X7OChrVqnqjddkmusA3dE2wAnXBTqP7bQJHa66T2B3E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cSFTKUbub1XYsbBo3EYkmn9Y0GPCPDZrk8RcubbsSqxwYW7yPXg1ovhka9TJnj3Gp
         X/VX4K837l5i3KeVu0Kx0wKjha0V+wOpEHivBVb+VUsQ0Ek7AlLdCLHpSLmyP0WLNP
         yc59JqjmkNK8XFmIOIzupBQxZYBgEZElyaDO2lOU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1gqstQ3O9u-00m0Hi; Wed, 05
 Jun 2019 14:37:30 +0200
Date:   Wed, 5 Jun 2019 14:37:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] config/alias.txt: document alias accepting non-command
 first word
In-Reply-To: <13d9ddd3541e3815078c4853c6f7c25cddd89126.1559333840.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906051434500.1775@tvgsbejvaqbjf.bet>
References: <cover.1559333840.git.liu.denton@gmail.com> <13d9ddd3541e3815078c4853c6f7c25cddd89126.1559333840.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7nltF4oe787K3zaEj8BKLfAoQfadPthZv3kbsNqCDJSdCNoJ5eF
 zyDillTfoIGyFxb/W+U6jNodITZtd5AbXC3DRJEdUsysVXOlDiQf9k74Ls/y6gfNogj8huw
 eOyeQuRYplyMwvDLMIuk2Vj1KBJFzaJd88NPRVqe1TTma3Uv5wpNi28cT4HnG9KcNWWbA+a
 nn9M/z2PCkCmOuQMByN0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PFV0twDCaWY=:1jWAI7nwmbynLfSkyeXgus
 MPFISy8kvk2NW9twPE2h6MyczGEAHXAXieXeGDppqvZt304F0JIhMYQGQMmKiNizov4g0wo43
 9BQlirdrS5INMJWKgmyv0kq51Qyla5ounhS+DZzpoOXCedOjcgWHm51SnhULY6ilomDTclCmj
 kk0EicDzFfitV9Osqzr2uQ+dlHzcJza9g/TfLF9DIGDSwJ/4XPlSJKBFSo2tnBl188SCzYquY
 qmYvW1/Chsig99WduQA3x206M5fzBkAMvIqUjy6rnEvkGdmbU3nwKq4qn7XXsZIZPYoaveQuJ
 dWJQhAOzpRETTx+nenhmajbGJU/hdJ20f1p34NMC37x+Nqx0JJNTBfrdWMz7CFFfA18JDO+4l
 TvcfzrfxrO+hGCM6KbJljq+1nAV5Yu4dTla4cH25YkUJk5om3a83FPMm0womBYdkoV9YEl5VA
 xRH5kAj9VtIdC4kaRDmVkVuPBRxmAM6OqiYaTXPfwYnq7WuDrQErYasm101zg6q9qeNodq/6Q
 ugAyFf3adie+iZe9dRfD9hPOy2CswSqBkwa4mAkhi1f/Axx2pRyCur3x+ip0MOG4NHyxQUmEn
 ZjHwZSkCf3Xc8DqGCxGPaZGcWXUvXHSMJxIVMEnG4DwjSbdD5B+Y4uUbimdY6IkivqIgMV/yW
 GTM+qY1lqIDqgEPgnyiuTxKTKenbNB7Uvf4njd0o3so1VTc89OL6VcmnfM6euJXijJJYS+i96
 Le0M6B6jZ+6+OSA1dcrwbNVLS0r06nx+0UAHIzPZm2iXvncbsbxWUbCK5GRnfP53GPkaCPNH8
 OFzsf3nmEJWfu+UXvUl9sZa14WUQB2TAiaCnh36/ZEcXHZGx8ir+nF0yvyjHgLFyIwPkR1FaV
 wXwDwRYNm+6jxyAWLtuQKTr8PnOLrQM6LpTEVg4xxq0+i/eDspOSHVY3bIsOFJBVgxhY6YDAR
 HdXIHaeisvP3ELy649UyiU5TQujnwxzBZjV6ZipM4W9VYipBiDyh9FjfiM0IZOabuFvxbggWM
 XlC3hTqQpFnh8/SlFU3vHMw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, 31 May 2019, Denton Liu wrote:

> One can see that an alias that begins with a non-command first word,
> such as `loud-rebase =3D -c commit.verbose=3Dtrue rebase`, is permitted.
> However, this isn't immediately obvious to users as alias instances
> typically begin with a command.
>
> Document the fact that an alias can begin with a non-command first word
> so that users will be able to discover that this is a feature.

You caught me.

Granted, back in 2006, when I introduced that feature, we were not *quite*
as diligent about documenting new features as we are today (see
4ab243a944a6 (Allow an alias to start with "-p", 2006-07-24)).

I like your patch! Maybe you would like to mention `-p`, too, as a
possible use case, as that was the original reason I introduced the
feature? (To this day, the first thing I do on a new machine *right* after
installing Git is to call `git config --global alias.ps '-p status'`)

I'd be fine with these two patches as-are, of course.

Thank you!
Dscho

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/config/alias.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/config/alias.txt b/Documentation/config/alias=
.txt
> index 5425449a50..f241f03ebe 100644
> --- a/Documentation/config/alias.txt
> +++ b/Documentation/config/alias.txt
> @@ -7,6 +7,14 @@ alias.*::
>  	spaces, the usual shell quoting and escaping is supported.
>  	A quote pair or a backslash can be used to quote them.
>  +
> +Note that the first word of an alias does not necessarily have to be a
> +command. It can be a command-line option that will be passed into the
> +invocation of `git`. In particular, this is useful when used with `-c`
> +to pass in one-time configurations. For example,
> +`loud-rebase =3D -c commit.verbose=3Dtrue rebase` can be defined such t=
hat
> +running `git loud-merge` would be equivalent to
> +`git -c commit.verbose=3Dtrue rebase`.
> ++
>  If the alias expansion is prefixed with an exclamation point,
>  it will be treated as a shell command.  For example, defining
>  `alias.new =3D !gitk --all --not ORIG_HEAD`, the invocation
> --
> 2.22.0.rc1.169.g49223abbf8
>
>
