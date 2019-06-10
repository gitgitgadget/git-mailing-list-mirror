Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67491F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfFJRJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:09:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:34465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbfFJRJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560186580;
        bh=Tk/NMtQRNWmy4AldLb4YpD6zngkjv7bWkEYbBgUKq+8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eXz1wyW4bfxOIywOEVzNP4AXwgKkl8Qt03wIEaoQDjTB23g5on8FPDdMg7m1Q/sZY
         pD/0jaZOaJbbKq9Wn3lgK0obNR/+1AkNYb4LHFX9fUvK6PJkP06Bb7Ap/8ItzYogDe
         l1ge6DddQwfyDE9WwieaiS5BFg9N1ZEPS0J/Jm6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.215.76.8] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXIov-1h4sQD1PL3-00WCfR; Mon, 10
 Jun 2019 19:09:40 +0200
Date:   Mon, 10 Jun 2019 19:09:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, timcharper@gmail.com,
        "avila.jn" <avila.jn@gmail.com>
Subject: Re: Inclusion of translated git manpages into the packaging
 systems
In-Reply-To: <1979608.xhrAu3A07H@cayenne>
Message-ID: <nycvar.QRO.7.76.6.1906101906140.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <1979608.xhrAu3A07H@cayenne>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1115639801-1560186595=:789"
X-Provags-ID: V03:K1:km6nlJV1krMcGvBlAbwQGe6PGkfcKrCBk9lrvRWuUSkZjt1uooB
 laIY8jj8VDP2vJ3XxlHf3rsw1dLn/2RRNOnq/pzlYbKqz+BvVOPiNpq4M/KGghSiF4Qq7sF
 O4Scz6/cUgow3l21CYgHcqVxZPwclerx7CslREdq7mPYjXHLpwQrUM+QQbqnl+w89nIJvpn
 HO/KBdSyHr0f9duECNBCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OUJBDeVp054=:wZg3tAm5a0V1nc1/DAK42k
 bSsqim5lPdCEXYu8PlXtwcNnii6HWYmA/kK3un36PweJWsxb4Q9SNYJXr6Tjqw+BKwJz+NpPr
 olNnYt4ZxKS7FW028NTYt0MiuOoDJtv9AwC0RyFj3bznfVjmV8g+nyz0i2+jCtR3jpZKXxsqB
 ycTepiWk1fulymSzkIWMSmca6ur88rUbthXHCLhGTehFTWNeC1lCD1ttY+DArFnGAvGq3wCQQ
 6waL1ONr/TymkrPmimJC5c9wziPPKEARCLC4owbi/KB4x4n6a8Pwjc9QK7hhCcSQ2rsBbd2aC
 3nLDejXh6mZwBuHNQ9ibIYIede6IH/aFWNafgRh5oYuJnbec5fMNaBd/xWOoHNUFlXmd4qcSE
 YLzeMYooW7oqFRw5JwYNDnlrpVZb8jn8VzWumf5dfx9HHv8n6cJNu+LY3FL6AFWb42sfsXdBL
 gV/eUp8ZLMWDHQkzikhPXz5TzrQzgaa+2AYzUCBxDwdD2ZHRyaVr1cA/bxfWUy5DUcRCztxW2
 lzOwPmOQqz41Nbrg6+mCf9IPfxAsAECLXJwPL7TsRtMIKYZTimpjrjtvkGqIexcnpvm6vV6lq
 0stWHIt2mH9VZtNj8MaYCstPWhs8+BwZa6/c4smn1Paf92OJWQW3amR2AS90hlgkQKhAdUlZa
 3bJEE74BdeKArm07tvO3wsq+JUBFtalIJDm+Tkmt3q9LizRzrusnWeB5xlyKqkfE6xDUajVV8
 6ZtWmAlRRMhkiKR0hWof4QTxgR7+oENUK2kwUmDZpsBLXppZ45vfCGfaAyKhTCGgWbd6Jsv9h
 Zrgl0xYj+oz3HUtFZfPvyCZ6UFYqOObICmaHIZAW0YvO9wzQmVPk+1rfK7oIIxCngcQrA8x8W
 iEbaC/ds7ilijDRAUaaTH7ImRVFsabbn5lW1Ncs51qFMgB0IsBIAdrCm7DcunS4DGj9I27PC5
 HcCRg3oNiuAUZqBhfjAm2Vj5arKiV9s/SGof1yRY5ayT+jyMtvi6u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1115639801-1560186595=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jean-No=C3=ABl,

On Sun, 9 Jun 2019, Jean-No=C3=ABl AVILA wrote:

> I took on the task of creating a project for the translation of man-page=
s at
> https://github.com/jnavila/git-manpages-l10n
>
> Up to now, the translations have started for 3 languages:
>
> * German (2 pages)
> * Brazilian Portuguese (6 pages)
> * French (11pages)

Nice!!!

> In order to provide feedback to translators, it's time to have these
> pages included with the distributions of git. Right now the process of
> compilation of the man-pages is still a bit off-tree, because it relies
> on a recent version of po4a (v0.56) which has not yet reached most
> distros.

Maybe there is a way to skip the Makefile task when a too-old po4a is
detected, with a warning?

> I miss expertise in the process of packaging. Depending on the type of
> distribution, the route to packaging might differ (for Mac OS and
> Windows, maybe a direct inclusion, for Linux dists sister packages).
> That's why I need your help to correctly perform this integration.

Historically, Git for Windows punts on translations, excluding any
non-en-US documentation (to save on bandwidth for the installer, which did
grow from <30MB to 44MB in the last four years alone).

There were a couple of motions to change that (maybe in the form of add-on
packages/installers, maybe in the form of a "full" installer), but nothing
came of it so far.

Therefore, as far as Windows is concerned, I hate to admit that my answer
is "don't worry for now, we only include US-English documentation
anyway"... :-(

Ciao,
Dscho

--8323329-1115639801-1560186595=:789--
