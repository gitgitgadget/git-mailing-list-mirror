Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82401F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfFXSAM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:00:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:43633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFXSAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561399202;
        bh=85s0+7kyvh7wGtpGnajDDfISMH4iUTaPhR5nDpYns9w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BK4BGhxFtrMsXYpBYmP7dYInzdKEo5aIm73LF3/Km9eseD+80entGvmfoinDhENm5
         cODCffXFz7rF+CkTiJDfhJXVGBI1A7cKvaZyqmm54J3du9qOIEUYtdoScjMXHO5e6v
         /vVBrwxhobbBjde4e5vtlRNK4hMoiyzWCaEWHsmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxu7U-1ic1K93JNk-015MmD; Mon, 24
 Jun 2019 20:00:01 +0200
Date:   Mon, 24 Jun 2019 20:00:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index
 in json
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-379455855-1561399222=:44"
X-Provags-ID: V03:K1:7bXQrmEkW7kpZk6TYdKqCxREQ1kBUZeN7RS+kysvVcSl8os9dXV
 Cd7RvymmlJwbb+ZS5/mGhloDunhQXp0HyNJIBcSNbxhlJIYnQuPajSVOYOPQMbvFo76TZXU
 IcnHIlrUwu6pTn11Mg+xt2glNpXaSAzNs8PYcNVOP7Str00RHqfmXiERGc7h/48M7lNyQbc
 DYdmoLbGkT3jF+Jvb5uyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lTTNdwNS34I=:fGYQOHCsq0Wf6e//Xy2uyo
 zHe8SaJ1LwsP3RUeIlcQwGPAfDAmNW7W0RFUM/aCxzBM6ygMAvWYJ8xpGPENi9Fd+JlisuW2A
 lVUnFUZaDspC9eF/Y/NGs5yEBFTto1o/iUcyaV9cMIqCHHDVYBUUl3p9XPn3wsJjNHz5LSpsF
 PHOeJulNb/eknMQk8rCThDH5M6fb9R6YHYFm6ObcqrK47ci8OABIosD33SLgnAXHpwewtgSvB
 kuieZClpad+CxxHdiGkv90QGmWAoHDJHi6dQjZAL55Du1URY/UWRwECpWX2K5L+Q7xbBC/Ode
 /NB/T7qtgwNQwzRzzKCRT9d6KefrtkwoDF/CcK9vD9vh4EY6ZzY15ibPjpBHU4rmSZjJx6tJx
 q9v9D11yQywz7jXTYYpmSIJEwpYsiSrYnoLAWYZ+edg4h/lQjIy9P21Pw5xusUim5skq+G/9I
 T42rsNFe7RS4TjNLxwts1iWMneFND5uL6OIOQ1i2DtmxaGrQ3/ubY520SxCxaMHygXhbuiyAL
 XgZKenZlWLZsrYX5A4eekGzLknkCSqV6xrYR3NGQVPWIb3PT76V4InQtJnLIyI61hn8I+142D
 p0o8e5LN8LFmxWes2cmJlw5KXoR9AMvokx4AByGnZ6Wy6KMl4mTca2ypfglY7HnBcfVIv4U5g
 3Hkshdt084PeMCLjg23niX27VQaSY8u39q+it4mm8V9d53fsZMyOlY04igUgJc3yFLCEp6a2d
 JOys7cmyFyOksMej9DizOzKiRum+1dPS0ZHprxm/VZIaDVd6Usv7qsXTBwshp9oRHAIthIbk2
 hukFbAXLDRF+Y0nZeBCUMLCXnbtgWt0SrQs5jfDh+xaW7+jAJAqx6maK/G0LDtGqEoVxYkNnE
 iYcux0UuR3ekOFGQJ976u4wl3niKhgG03Jd7W0C0qs6Y830iEqZo2jVnVlUL++lUqgh4l6RQl
 vduB56vYxcMQJdMMGAYFOHXS+lVo2jzEXiXbhhCq9IcfQbBywG/zObmVKYRe1efYOG65sxVeu
 gfiBrAbRoUp/zO3ofRDwCGVrfpNPWY6aqTs2CUj+UCNHdUHOEayzUtXsWRbrLU2aPs4xdAXJM
 ufLONLwxrj2c8o8dJCxE8kkC5cuTiD19tLS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-379455855-1561399222=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> - json field names now use '_' instead of '.' to be friendlier to some
>   languages. I stick to underscore_name instead of camelCase because
>   the former is closer to what we use

This is not a good reason. People who are used to read JSON will stumble
over this all the time because it is so uncommon.

> - extension location is printed, in case you need to decode the
>   extension by yourself (previously only the size is printed)
> - all extensions are printed in the same order they appear in the file
>   (previously eoie and ieot are printed first because that's how we
>   parse)
> - resolve undo extension is reorganized a bit to be easier to read
> - tests added. Example json files are in t/t3011

It might actually make sense to optionally disable showing extensions.

You also forgot to mention that you explicitly disable handling
`<pathspec>`, which I find a bit odd, personally, as that would probably
come in real handy at times, especially when we offer this as a better way
for 3rd-party applications to interact with Git (which I think will be the
use case for this feature that will be _far_ more common than using it for
debugging).

Ciao,
Dscho

--8323328-379455855-1561399222=:44--
