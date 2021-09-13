Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31318C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175E460F24
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhIMMBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:01:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239691AbhIMMBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 08:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631534391;
        bh=w36tZ9uV/ymJee8V7uBmlzjtQzD/mp49txqPuw0LGSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gnfpls0EDnGxz61V5C1vDHl6GXx/zkhFd3Pnjh4PyfzhYBSAr4xdChp39yNabcSuN
         TwCIc7wHvO6dRhcsx4z8jUPE6rov248bTOZMLdvHBwEgCDCL0l7LAS8BgQMmBbIkDO
         uGXYsb1qQVS2OinTBaYrTU6rtqUIhWntjyQed2P4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1mJxC60OFJ-005otQ; Mon, 13
 Sep 2021 13:59:51 +0200
Date:   Mon, 13 Sep 2021 13:59:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, bagasdotme@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] git-compat-util: include declaration for unix
 sockets
In-Reply-To: <20210913085600.35506-4-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131359130.55@tvgsbejvaqbjf.bet>
References: <20210912202830.25720-1-carenas@gmail.com> <20210913085600.35506-1-carenas@gmail.com> <20210913085600.35506-4-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-13515642-1631534390=:55"
X-Provags-ID: V03:K1:JAEXruvSlGPWY8V322/2SU2Hu1MFOtRMTFHs1twBII2eTyzR1EL
 H/6cJOo3QDRZR7U7bqqo7ReW9ZDkSsKK3WRgF/Nc4DXe3+vVDgjDCBrvJasmJyUHUHO1a0v
 DyECv9IkYrmcoZt7ZAeMBx4u+gJxHnjTJiKFomXe9QrwCwtAEp7TsfB0iDSjpaiArIO5L5c
 mbAV1bNhSCPdJZflL3N+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CKfEbAIZ4WI=:EaOuh99hZbw4VxV7zFPww1
 l/yfQmd3QARYuvcMqPTbVPstuKhCgrn7B773HeRa9R2J43jSmgWP3svHCyMPgbbPtZOtZFsNO
 rS+5ABZdpIOrYSSr2lAa4hB74tVYLYAeBnMez1DXfrhJTzrfLuSti9WMU94fmzwEUAWZyooS7
 6VlTVVacksVXMmmJJetrbdA2pBmAJpoN/H1NBT7qIv8Lbfx+7P5gmsf3l33t/ZX4kMFt1y5aG
 ODH7f1KzVNGX16u5DeWUpNSdmz63FMC4Bz6yUPuQaIkIYA4yIHobshVF2+9A+l+Aj7v2MhFPO
 skTZsu90i3JMJj8KnpQgoCpThYpD8yu1OPoItaSLug3YZPYtBggRtY0u8N2/H+gDqMJnnbhKx
 3ncjTTrhvmVJm/bbSAryfXJ/PQqyL5i+nQimO7//gJbGEfr+Y56/869Hl4TicufrBH/LRTc/U
 ulbBtYnMM6fbgCkFCLjeuZsdZql5vQmftu7s+G8YHOZ/qWxGHlUhEE4/vMZ27KPadVGcnoaDw
 cPO8PzIbEJNJpWMPNxAbOhnut+Iel+ELlGarBi8ZnqKRiohtlOnEYoudhHMyWZyx9+lz9XmCB
 MfL4w6VL5AK+eV8I01NsqPS56J4cDmMpGThFS3ypYm5OzP33YXWTJdI6aUvHxtVr2SEgy3ywP
 lL0bdaV97LxptoDjyUgxnHwxUzX8Oke3FJ1DIbR0zLCnu4EiTg9piRyp/ewSG7B7F9BoZAOZM
 ifVBLdaBmu5+tsm17AAB2LY/Tz8fW1J3UvaJcT62zuuM9hz9jp0796/EXVbR2IR0/3MmEjs1x
 UUoI2ei6GzA3v4s7mEfD17vN5p6EJNiZzgImAxggmrbzQ/4nBdCV2YUVz5RaZTElDBcgAzUo0
 KrqIpOEJORKdaqt3eTDzUUd7jMgQPn5bKPOfZxFm4dJ6jF/6WpwHYD9cq0zmlITJ9xsEykIYb
 KFyFooZ2MPpOhUOKsrPowEWg8IPD9/FzJmjyeYwiizOWTtGsNa7Pi0DvIF9PSCqMPHCFwyVN5
 ah1IUMsW1kKU9buHtFV3/3YfPuv0QSSaXswXHLBK5YsnflT9Is8xVbkVNXnUXlA0ZUaStSz3y
 45vDi1jHtt87k0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-13515642-1631534390=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 13 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Available since Windows 10 release 1803, therefore only added if
> not using NO_UNIX_SOCKETS (which is not the current default).

I wouldn't mind one bit if we did not have a double negation ;-)

Other than that, looks good!

Ciao,
Dscho

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  git-compat-util.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b46605300a..6a420d104c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -160,6 +160,9 @@
>  # endif
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>  #include <winsock2.h>
> +#ifndef NO_UNIX_SOCKETS
> +#include <afunix.h>
> +#endif
>  #include <windows.h>
>  #define GIT_WINDOWS_NATIVE
>  #endif
> --
> 2.33.0.481.g26d3bed244
>
>

--8323328-13515642-1631534390=:55--
