Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E29CC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D8660F0F
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhJYNOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:14:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:33959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhJYNN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 09:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635167496;
        bh=JDbu1P0KYOOOuQqW33i0KuufrtaRIS0coMnIXWBO8OA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dho4mFCX8OEaTkYzr3J6fMlrMJAnezUlOZYXzSphY4TYFGQGxnsuJmfdf1CRky2fw
         8HoFUZ0dMx9zqiwDYsBMW8+zVylqqwBpRTimRIiGdyosPPNAOlToSy18Y6MFACLNsd
         PjzYc66ZRq980mfSlEOQspbupVX8JaEu58SULUTM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1milJV3OZm-014jCK; Mon, 25
 Oct 2021 15:11:35 +0200
Date:   Mon, 25 Oct 2021 15:11:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.txt: fix typo
In-Reply-To: <20211024170743.9647-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110251511140.62@tvgsbejvaqbjf.bet>
References: <20211024170743.9647-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-668522719-1635167496=:62"
X-Provags-ID: V03:K1:RGD0jfzQzHedEfX5P10+FWHO68VvVOq2BRiac3RfI4iDpM9/nFJ
 GhRuc5SlttN/hzr5N3uT4m629+NTgJs2zsfP/eLzcsbfhSkkWhKJ14JrtyHYXSdOqlxD+1U
 XNOe9ZpltoKYtWIcygxUEeeAUsJ1fibRAlO+ZWznw6Xv5erVSbfkhCHh4mVk3grx/76fHRX
 c4hwiI11BBwdhaoRglg7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ATo0NxQ9dS4=:J+WSLCtlQic3nAhMU6daIl
 TaYIfteq0frxscg20+0qpecLEwAam/ljGbqVFq2XnJMIF1YaWYz3EmV2n1wPzB661lqumTwsB
 vRD6ayExtxTmsGDhm2iF1iSYD4kuClkMHjGVJUXd1wvNxujG31Acl0vpkvqrjNxTg2W7Oonyd
 rCgnbMoNBoWUCiazzlfGl6xD2KByWOLHr2LKAhuebbQlen6VZJCvWhd2yU3z5JhZZHv0dH7mz
 073JfdLqjYmbdNlgD3Sm2fWml4kGfqsl4njGuID21Wc1NSolivSyEkGopuv0pBP48ZWdYN5BN
 fizVbEu8ms44tyZdrN3lpWwQS3ECx7cL1gKkGk/8RfAypO55OsEkneWBvDur8NTwTteL2Ohay
 owYSdlMLsjP7HSLk+SpIyVdI6oZfte4XiihUCigKVZ1YlMl1meNFcbBf+1GbTDHZ7gVHOSFjR
 Ywy5DxrfjLRr67W5JveSKATxzicAI6rWBKFUnok8Xh+bqoEgXbOEd3E0sOMgiXD6K3yZCPVzp
 mgVn0l7hxqg9isIjR6XWhffd5M531xxh1LHcj8N3DlhuG1L5Ld011xp2iWaOTvtLOdAChGM+V
 oHci+/saPetWw+AxJO/i4rLZAyEBWF4YoZd7CYgRewbOqBs95RYrxx2dwwTSiVFJZFvoVkTGP
 9KHZ71pVWtVRJdybSUqNmK4OLJcAOaxVyVyj2qxrA8eITxXQR+H5/bDP+C9YOqIpXkrWtYNQv
 2cZjiefLuzwzCGMg3BUldngWG8hgiBrhbzlPl9tNULYxzgET3greV3psZ04aqtDowxCwu56hs
 bAln7/cTG72bnljMvGzXn4HtFQ8MnzHtRkw1A8U7nH++R3Tw5PL7ERzhxwMoUsYYvTo0MfVSU
 RjV9NlPXfygKpv+01KWuef91apPaBIz4b2X7W/IJTqLUss62WY0cASWV/g3FPvm3WjL3SNlpQ
 5WUfz0j1UmH+0tRbsEOf9pn2PR7lT5g1eSswm6jXCssYeAUQIz4l8nZG5RQ+lHe4ELNvbddOZ
 B6jnOexbfVQqDp6H4CrCm/gw9jdCXFBn+C5dmt6fF/V1HRjk6ufE6Moew8u/Mv+z4afJR4fRt
 yHbssQJaWzfvlA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-668522719-1635167496=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sun, 24 Oct 2021, Martin =C3=85gren wrote:

> Fix the spelling of "substituted".

Thank you, the fix is obviously correct.

Ciao,
Dscho

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  I spotted this one going through the doc-diff between v2.33.0 and
>  9d530dc002 ("The fourteenth batch", 2021-10-18),
>
>  The original topic is js/expand-runtime-prefix.
>
>  Documentation/config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0c0e6b859f..1167e88e34 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -304,7 +304,7 @@ path relative to Git's "runtime prefix", i.e. relati=
ve to the location
>  where Git itself was installed. For example, `%(prefix)/bin/` refers to
>  the directory in which the Git executable itself lives. If Git was
>  compiled without runtime prefix support, the compiled-in prefix will be
> -subsituted instead. In the unlikely event that a literal path needs to
> +substituted instead. In the unlikely event that a literal path needs to
>  be specified that should _not_ be expanded, it needs to be prefixed by
>  `./`, like so: `./%(prefix)/bin`.
>
> --
> 2.33.1.711.g9d530dc002
>
>

--8323328-668522719-1635167496=:62--
