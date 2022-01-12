Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F7C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 14:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiALOV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 09:21:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:41625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbiALOV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 09:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641997309;
        bh=H5gRXv2jxufnDCflLhubdJqbeB9IltCQaxDcxB1k/yo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bldR6hAj94tgDX7NLMpfblN+jqE1IkSKaRc22TUtrben6iK923rrMqO3gC4WSWWoy
         B20m42s48/rqn7m3X7SVKYdm47402accz6tsXIEdQ0+6Om34ULryFSrDX226dRlKvY
         EcNl/IEBuwNnlJ9yB8NY9kpOakH7S869NjKs/4sI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.215.56]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1mO2Wp3zbL-011fzM; Wed, 12
 Jan 2022 15:21:49 +0100
Date:   Wed, 12 Jan 2022 15:21:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
In-Reply-To: <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com> <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-371589879-1641997309=:2121"
X-Provags-ID: V03:K1:O+2TysWG2J3rz6gnHS8icFzdOAYJ2PCobspRWa6Cp2UhEb+MwCj
 N95yvkDvF/CL349Y4xCMqCymBYPmikrIl9akevmTPdqRSi55K+iT4HoIyHZJmr644F48YKN
 bm1L1aKUvX1vywQFO2wqs4ycdgFMoOvGl3vEwBVpD2YyuL14TjnRVhU5wrmwErj3xB0lkzb
 NKcIfBMw/+77Xs+3R8OTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F54D6N1edJo=:wQGWCBA5wxJJi7+HDsi9sT
 ZSr8964ZZtLlBVB/XQy2gJEOUGsZsAkcSIk2CQDRQp0QulEZx2XkESdS4jLh5gAHhUeh1Dslp
 DtUuHPwJ5buqM1/uLxQ/IN/zqKlP1OwkUs0yF1UXXIo8tnsRAkf1i2iesijb2njQet7MnEEUR
 1n6vgiaAQkZODmy2aZVVDd0c60a0xT/yklQgZ9R5ihDK8GKefdmwGYB7u/QoCTCG7aBiyXfJF
 bCh4t5ntAnhkKKmEZ/G4wxlbduuVa3rFr9pK1uHfqyPFf3BbT58amocudik/Zwc9ALxNvmgMD
 z78vczYo/MOgkSB4auXYDWOdrhdZdoQoHyy8IqpK8zJ/k03DkWmw9KiB3a3FS00SscBrKQX5M
 aH9ztKSkf6tNMo+87BpVNve5LXFPisU5/OTJumdFBL+nutehkEBg/9dOIRX7LUrYswpEzJvAX
 ZappMt5AH8OmYsj0twdDZwItWh1VDOdxlePgfI5epDCeZkvWDX1GrKPBKDEPfRZm3hMHptYoa
 QScaHC5nGmNaq/QJyM2ATTKBsW+Y5hUZMj0reSKQh3Uq+WJGqr29lQrFmvYdCPJZ/076bXaE9
 CFZJohKjJRUVUPWsylf/vulQTthX2dx+gxOESeW2l9z+sGpc0Cv8PLNoS1QdPYrWJwdgjOIMO
 DA4DRXTN5c/x4GCE1kmKrCo7DHSDNY8IsFOQQgUCkaNi/5dGdLAcHIvqqE8ssCru0NLjTnPwm
 fMoYO/nA0ersXV2itY1LpdCvh+iltHDZZmJ6WI4332wDj27UAYP2gTtvHdwcPup2DBDS1rnEt
 oJ/XVmdPZfDYYqfFIldcyqFaMVZ2WSiSOMXjo/tYZclc4lTezS/q52BOfHLO/0XAYZdwLAcq8
 VEDdfdIfvSCFo86p7Cb28NQnklFGrnFAG7vlH1Zy/4TNOPs4dufw6JSGCyux3OXVFDEI4DbxA
 ZcLI2m2e1EFPOFSwG5rVwaDOxsndNeMBfReL8QGujlPBwStobAYX2UVK+gGHRwQBTY4l9VqLv
 n6FvGA7A917tuNyd83lb8KKbOn6ULY/PwRDRAJFPnJL6v4aF6hl0RWvS+ZvSTayYePFcNKTQr
 DXtbDu1cfHXmIU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-371589879-1641997309=:2121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 11 Jan 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It isn't important for optimization to have this be "static", so let's
> just initialize it and avoid this warning on Sun Studio 12.5:
>
>     "t/helper/test-genzeros.c", line 7: warning: const object should hav=
e initializer: zeros
>
> This amends code added in df7000cd910 (test-tool genzeros: generate
> large amounts of data more efficiently, 2021-11-02), and first tagged
> with v2.35.0-rc0.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/helper/test-genzeros.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> index 8ca988d6216..5dc89eda0cb 100644
> --- a/t/helper/test-genzeros.c
> +++ b/t/helper/test-genzeros.c
> @@ -3,8 +3,7 @@
>
>  int cmd__genzeros(int argc, const char **argv)
>  {
> -	/* static, so that it is NUL-initialized */
> -	static const char zeros[256 * 1024];
> +	const char zeros[256 * 1024] =3D { 0 };

This diff does two things: add an initializer, and turn the variable into
a `static`. The former is the actual fix that is required. The latter is
not. During the -rc phase, we do not want to see any of the latter. It is
unnecessarily controversial and distracting, and can easily be postponed
until January 25th, 2022.

Ciao,
Johannes

>  	intmax_t count;
>  	ssize_t n;
>
> --
> 2.35.0.rc0.844.gb5945183dcf
>
>

--8323328-371589879-1641997309=:2121--
