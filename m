Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B03C60F6E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhJVP6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:58:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:49547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233504AbhJVP6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634918147;
        bh=Zc2EpjhxYJeso+vYs4Q85TzykGz/ILHCHuaDUvmlvKU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EtM81jfUja73qOUleWLe7jNAU8VV4famY2DCbK7+oFE1JJkBKsgT/P/zBuYSQOonl
         uKTmBTFhm6kXVqsIPla3l64v0Z1ND3cQ1akXsAwPcYERs4fFie8Zs/g+wP6BW7rbOh
         u9jP9ZuGMX1b/ufDd2xPzn2F2fXWvk+t5B2MfJRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1mbiuY3Czw-006c32; Fri, 22
 Oct 2021 17:55:46 +0200
Date:   Fri, 22 Oct 2021 17:55:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
In-Reply-To: <211022.868rylkuw7.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110221734530.62@tvgsbejvaqbjf.bet>
References: <xmqq1r4hv7bv.fsf@gitster.g> <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet> <211020.86zgr3n698.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet> <211022.868rylkuw7.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1451397759-1634918147=:62"
X-Provags-ID: V03:K1:q4hGHLG+h98RNxYMU+mpVQyuBiN4JKSx+V4n33jMr51/FzYFgm6
 lM+43ffufaVwBksa6Kznxxn4DGEyyBOHVXS+QvqYig9HahHdU8RxUxKJqsXBUzwbdQtqTeF
 W2+KlhklIUt2RdJr2iViPLpqwUB2bxnMh5FyWy6yjBSOznVtbMxVPjQHHOsiHAsQni7b7Nh
 h1tptnQoRMNIlLYBoXbnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZLHt8sjvBF4=:2e29Z+bbJvWYJ7791QGhFK
 T05nNmz1dcMIaixQpL6TbvSKUr/6So28aI7plJ6Li0mIGl19oz+w3RBoVYe/K/paCg3jumT+Q
 CpVL/MLxIdi/g+2UdiEzJeOCCfrguMtu/dNmXXB+xbYZV4kYQWtSyD8/3CkKIhqDWZeoC4OP8
 aHqYRDGsjnMh5OqWuzNfhPsYoAQEX57eUYyFyNJOWxQH+hSKKYUQ9uPwgHr75RBeokFXIfzbg
 1tXqYoraJ8sqQ/2ccZEbQyZoIyoI9FcHtDOYQq34O3ebIZtw6xdFtVXX4F9ZhSmrqP77/gpHi
 6IAoMkxaxZemlZgnsvXCv6si/dvSRv7VXd4ggxRMfW7zMW6Bl3D+Xbo0txqQAIFYvyRzivLiN
 VvlLSMa+HfsfGFSb5AiFHCt60803YmUOcSUfLS+ZckZUtYYZNnP4x/bWL1fNBzFZpWBMlnBsI
 xHqMhLKQTxyAC2e2cxGzCEtoibSYMa6dUe/d0wVHH8g4tJXjEM1HkKRMcebC/JzjHmkh+vEBG
 dXY4KZoQuFvA7o+eo1AoBuMW+5zs50TsBxHlnGBZtz29yNQQ0M6kL23c4eodXuoaKwQEkzzKw
 TnRx1N0fpHW206Ky7f/MGSZ6Yn5foOQYa5c+0qYutU2DqnMSJYTeKIsLt7nUpbGqku3prCE5X
 KK5iMedozzm6xwgthbWkvASqbLecaSmmZ3nYAWB12KuMiJYdnJDRG7xnclFDKko1qTe1HDXhz
 SFPqqIc2zPLQ+LBhQ0IHftV7ooIuGDdWeCgvIyWrFqELQn2i9+XYe3bqNksi8nHYTKdDMdbfk
 k8twiBNUGdiNeCQeHLayPhHG+rkZKbZVbZoVEn869L0c5Mz9UvPhZwJilLKs26KxNiZuxfXOp
 qPlHvwuINDqvITzSz9XHDvb5h8Drp7UZ5KY9ZGOc9d/fjgsOgji85E2o9D3eqQGsAcE4ysknk
 MguBAnOMrFElb0PYznoY8chH+HT3pO8p3yqX/wz6zA3C9wqMHHeX0kd9GCauJ67yx9DxEC7pQ
 Nl7czJpxB34Asbp0LyPd8rZiq0NNi6smaX7xCjsr7FOllgLlkK0uHUHdH/B/YTbsUcNVOJ+dM
 5NRgLrizZKF37U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1451397759-1634918147=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 22 Oct 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Oct 21 2021, Johannes Schindelin wrote:
>
> > tl;dr it isn't worth your nor my time for you to focus on the build
> > process in contrib/scalar/ at this moment.

I still stand by these words, and I think you completely glanced over this
problem. Your focus seems to lie exclusively on those "dependency
problems". But apart from you, who cares if `libgit.a` is not rebuilt in
obscure and rare circumstances _when building something in `contrib/`_?
The code in `contrib/scalar/` is transitional.

Just forget about Scalar's build process. Forget about getting its CI to
work. I have all that figured out already. It is all working as well as
needed.

> > Having said that, I do appreciate your interest in this patch series, =
and
> > I have suggestions at the end of this mail how we could collaborate on=
 it
> > in a more fruitful manner.

I would still like to invite you to think along more productive lines.
It's not about where Scalar's build mechanics are right now. It's where we
can take _Git_ to do what Scalar already does.

Ciao,
Dscho

> [... skipping a lot of talk about "fixing" the build problems that I do
> not consider problems at all at this stage, and probably also not later
> because I want Scalar _not_ to be integrated more closely into Git's
> build process as I have pointed out multiple times even while you are
> continuously trying to push for the exact opposite of that and I am
> starting to feel a bit unheard...]

--8323328-1451397759-1634918147=:62--
