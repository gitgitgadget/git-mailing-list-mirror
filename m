Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E0FC433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbiCJN0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiCJN0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:26:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA32BD4C85
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646918702;
        bh=/lmQiWvsFbjG/xpcwYIp1uCjBvFX6DvHLEBFDsLESQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=idc/f5RimDfZsjionTVIgyBVheHULq13HIEd1PJPUp6vdhR0us7UF9bAN7HAuA76I
         icJRTvYPQCq+TC9Wllfk58QISBwrHRRwqhJhoE6OoB64+EWP6q2yaE2taPYYiiu5hX
         yVQQmbMAuxcdMRKYog5AFpbUjry9mAtcVB+XUgZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1nJkKb1X2h-009et7; Thu, 10
 Mar 2022 14:25:02 +0100
Date:   Thu, 10 Mar 2022 14:25:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
In-Reply-To: <20220309110325.36917-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203101422500.357@tvgsbejvaqbjf.bet>
References: <20220304131126.8293-1-phillip.wood123@gmail.com> <20220309110325.36917-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2003438750-1646918585=:357"
Content-ID: <nycvar.QRO.7.76.6.2203101423570.357@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:qwjW2QvJrlb5fYrJ6E9fXbY4YheOVwAohr9nCO6Sn00VCGUgDsD
 mAB4eBgovg5aCmDTnet3m1JV9RCaW6z/0rTCK/4GVwJzpFY7D/flgTDpnSaQEdTshV0LE7W
 1XY84apl62CZnpKAH8DGLiyMJXmf19eyRWYpA/fGf7KtpsSR6UuvH1AppkUwxJmLUAi+Y14
 zq9t8GHbP1z98tqQ04/BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MndvqeKwOSI=:cK0TgjnWRnNmhcI427xIsF
 tJMJtriNvH6oEVUMF+QjpR1iT07rCg8TtyVZ2BPkb0YPMWqz4IAw540+i96D+14O8yX1BmuQt
 WDD5DRLvTJictSpwaslBas97+zSCmNQQ8WJ2fLaoZAibqdWmIfOGFnF7Dl1WMCICfvL70d9tD
 zUywH/4FUd8A9jAxHk1azcQWOlltW1cGf2IQgxL5lUIbuq5+IhW9SfiaD33/Vbk+rwKeKSSng
 cCK7CUV4zKC5xSY7g5aFxG4mPbG8hhEvJKFZiyDvAfFcHRtgX+UDW5oVoPg+G8lu/t5mAoOBl
 NnM/QJxDrcPcC0r2095zLTwcuQrCcc5cySaCMYYwwRg7dVY8zY6lRdTEnET3zf7zVnwBw4UDq
 JA1UqNQ/5i0xTpvJQh+bIZvgsyfaZ8OBGrM/8jvMmVjRNVo3gweiWoXVLXTEQrY1h4HA8vaJe
 iEL8/mtsYUcSAhgHJNqoYuR7fclUA3rkzkoLQ0wl7jVon8Kt2kolBGXe4oqHrX+98UdjmSuxX
 PFnAA84LkZq/L6i6sIlBoaXD/UriCykYglhSr4JI9A4DwdnLBQsch0Ko2mCbuxw4rwao7Mcqh
 Suh+opnLM0kAyrT1yVxYluIkrKIOd8MOE1rRSksiQyBWi7ySoXZdDSTK4ewqgwd334LPDuQk3
 zRdSCS5o/v/HVCMWlmxNbMKGMmNoZC/q/30timYxcxQCvXF6CPJBx/eyyG4m25fpKFbpnjXBM
 nKJevkxGdPHc0HbrW68na2OgdkS/A7ZHFXPgBGjQjYI9ufb0Z7670y23vtMd1BuYfQs63YklV
 z+wL/1i0ziD3Tf49wV0yvVSAEpMmf0yDI5pS/zkTdpxI7othyyd44JdCTInBwg3k2Wlz3TzLe
 o8yOwVdDv+SB58zxD9OV5nkRTExp0o3z4hRsnWR1Yl3HPhSnmkYEplQyRgrXe17lg88/XnnyC
 WnRH6is0sXYHAvVY48RKzjjG4MrYpUfN9TY0Lteb3iRO8aF3XXRC9tgJ/xXnhi1gMeERqISMM
 MeamKsY2d5wgT8KJqCxC0coZ0Wn4E+cPT1bbDrYSQPvzMngA2cOkoRAwuHpflT8zp1rooD/9n
 0Jg4BeXT16wmUQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2003438750-1646918585=:357
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2203101423571.357@tvgsbejvaqbjf.bet>

Hi Phillip,

On Wed, 9 Mar 2022, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks to Ramsay and =C3=86var for their comments on V1.
> Changes since V1:
>  * Patch 1
>    - use an enum for save_term()'s flags (suggested by =C3=86var)
>    - fixed argument order in the windows code (thanks to Ramsay)
>  * Patch 2
>    - fixed a typo in a comment (thanks to Ramsay)
>  * Patch 4
>    - stopped duplicating the strings returned by gettext() (suggested by
>      =C3=86var)
>    - reworked error message handling in the signal handler to add an
>      "error: " prefix (suggested by =C3=86var)
>    - tweaked the background resume error message

While I did not ask for any of these changes, they look good to me. I had
a look over the range-diff and found it reasonable.

Onwards to a bright built-in `add -p` future!

Thanks,
Dscho

--8323328-2003438750-1646918585=:357--
