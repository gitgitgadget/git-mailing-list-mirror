Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19047C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAAC60FF0
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhFQMDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:03:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:39865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhFQMDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 08:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623931289;
        bh=WuLxYuFE9N3XfW7y6z/Y1bxatzMCkUgWVOQdJ0D3v08=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T0KsnamVyW3Vp0tL7Quh7TyExxh900Jgb196KE/wUVSsOxNdsobP2oUL6vU/NZb4c
         9htNLdN18Kk6fT0gAbWSwlCuJYjKQJJ28M3rgCaQj+LageimKaxQeBhhLgtfz9dqQl
         EjtWNbsxPJvWdpLMdt3Ui54pVaSpRlSCPRg+sjVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1m2L2P3gdV-0094xW; Thu, 17
 Jun 2021 14:01:28 +0200
Date:   Thu, 17 Jun 2021 14:01:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: builtin add -i is enabled by feature.experimental
In-Reply-To: <20210615164522.1079951-1-tmz@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2106171400360.57@tvgsbejvaqbjf.bet>
References: <20210615164522.1079951-1-tmz@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8jaYUOZthZk8IgQv6DT+vB1fBI0lEY4flL2dDk9Q0++qkz456tm
 Q7BzVpjGGNAC6OMeMdJWnrPft1wC0Puj1u2j8ncMs/GRMczFWSOXsE2SMXyNiSQcmUZDtW2
 VfsG1mSJA635dJ82GjbLy7lkzJpVBX6rtMm0TNpMVVPLnOnX/VlZQ7VRiuf0KxagyHWLTtL
 n9iy03myhEgkc06gkFEAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lPshyoDDdZs=:KqOi3nPB4Fj/5H2j9i40E7
 x14cPkvYzWrYZrTZajbPzU73LgBrkw2YbtOhkwg3jf13EFKPNBXtf2wojQc7JPpY31dMn1AU5
 GPel30ApCFXFmXCqYYkExeV2hwC7EUoO8KdFFE06anW0WS/VPNW8ccGOdVKQk6mDOopQJmtP9
 PUyNPwyF1o1CjENShBemuaKZOd2wDo0lfZ5Y/F4PlOWdL9rFyR/x8GYvafC78UnrMiRsBCmad
 jP/kJDTwawz+XLhvxYYfBrgTPsYh3cHIXevWZIZZmJei0klm/mghOkeN0SSzoZWUn/ifVLmBX
 jqSjqrXS3vjG7dQqaNjakmvn+0djKp4dqmv2QkcTALPGY7Mjh+4qox3/UgRXv23DTfyF4Omq4
 qFTySRe5UXib/Mic20/EqDQ3g5xeS+RMooii/t6BoNjrT8/err/5c5MRBQWtfjlkOC7IVXrma
 jndtP8gWza5Wo2UsRY8509apX6737PuIAcPCAcu72kB3SQEWb2qWTpMRLAc9yij5WikU+BLxf
 +yqd1COwr+vyPc+puyKw4gao6rlm4DfoVHmSRZ4yWwUDq78Sd8s0vDn7yZpjHcZMAbsC79J6c
 luM/KCoehrSr59ntwIpatDOZO+OoaEM84CEshDyeQsu5jyYyM2UrNHQSC8pr22DR+AO71kfB/
 xI0puu58sgoencP1n462Nkqnith0XtovUM3dAv0orRu1FjCZ2YGBh6ueoC0+YJNMPT3ofd6fh
 sR0F30QXWL0p5Kd4/qtHbCBlAvSwOIGIChbHaDXqTUu+TsoA2C9Y9j3YrcgQym4mIodQtK70B
 QDAre1UWM1mL6ELL6Fd1mYa5olbaJ+nWNbmZaYw/K5Y2qI0/kr6o0g96BMhzV72U4pUh828w7
 b+o5nUHDJBk3yI9NDDZj49ePKYodAhIuHhpgZyrvhtqDZamSw3hii3q+93BYGF2TRA1XdOaPF
 mVmljtrkq0Wso6qzPdl/Afkn8AKV9XQ23Z5/pE8uv9D450nD0kd3BWqtarkQHNao64NzlK0YM
 J6Lnhq6YckfRAiWY2QjFwFodkS7Q7XHApBMfiq3gbQv/R0yovmxcQflWDVGDrvNpsFrdafzKM
 kgm36c/VtbjXnI7gmvRJKmjJfpARl9ZDK9F4/t7cnmy+bSp1HokVgUbBg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,


On Tue, 15 Jun 2021, Todd Zullinger wrote:

> Note that add.interactive.useBuiltin is enabled by feature.experimental.
> It was added in 2df2d81ddd (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08).
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I was checking my configuration to see if I still needed to have
> add.interactive.useBuiltin set and noticed that it wasn't listed in the
> settings enabled by feature.experimental.
>
> Unless it's time to take this out of the experimental phase, it seems wo=
rth
> documenting -- if for no other reason than to keep fetch.negotiationAlgo=
rithm
> from being lonely in the feature.experimental section. ;)
>
> FWIW, I've had this enabled for perhaps a year or so and I don't recall =
any
> instances where it hasn't worked well.  It has come in handy on some sys=
tems
> where I can't easily install Perl but don't want to give up `add -[ip]`.
> Thanks Dscho!
>
>  Documentation/config/add.txt     | 3 ++-
>  Documentation/config/feature.txt | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index c9f748f81c..7d6d325571 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -9,4 +9,5 @@ add.ignore-errors (deprecated)::
>  add.interactive.useBuiltin::
>  	[EXPERIMENTAL] Set to `true` to use the experimental built-in
>  	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	instead of the Perl script version.  If `feature.experimental` is

It is usually a good idea to stick to the style unless fixing it. In this
case, I would suggest to remove the extra space after the period.

Other than that, this patch looks fine to me.

Ciao,
Dscho

> +	enabled, this setting is `true`.  By default, it is `false`.
> diff --git a/Documentation/config/feature.txt b/Documentation/config/fea=
ture.txt
> index cdecd04e5b..caaa97dc61 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -12,6 +12,10 @@ feature.experimental::
>  	setting if you are interested in providing feedback on experimental
>  	features. The new default values are:
>  +
> +* `add.interactive.useBuiltin=3Dtrue` which enables the built-in implem=
entation
> +of the interactive version of linkgit:git-add[1] instead of the Perl sc=
ript
> +version.
> ++
>  * `fetch.negotiationAlgorithm=3Dskipping` may improve fetch negotiation=
 times by
>  skipping more commits at a time, reducing the number of round trips.
>
>  feature.manyFiles::
>  	Enable config options that optimize for repos with many files in the
> --
> 2.32.0
>
>
