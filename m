Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838DA1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 14:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfFROnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 10:43:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:44295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfFROnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 10:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560869008;
        bh=Zo/pJHsk81DmxZI93L47ht/46eqetJ7RWKG8z+cILQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IsE0sRx33/mVOilj2+7/DSfB03LViuoYbIFSrbJ+MlfocfJ09Ru5CkWSsJolY9Gtu
         to6F1fF2wZy4hklntFdd6JbBT+G8B+JmNMxYpLbGIrs3/ko/33Pc8rH02Ht8HXLG31
         X+FDwUwr7zwiaxVGVlCp/ubLqaa69mRRiU27SpBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1htfkZ49YC-00Kwdo; Tue, 18
 Jun 2019 16:43:28 +0200
Date:   Tue, 18 Jun 2019 16:43:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] xdiff: avoid accidental redefinition of LFS feature in
 OpenIndiana
In-Reply-To: <20190618064537.62369-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906181642000.44@tvgsbejvaqbjf.bet>
References: <20190618064537.62369-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1893583725-1560869022=:44"
X-Provags-ID: V03:K1:wPmXSyGGLCa04Znx11IThFVhpS2DE0RWq28cKLkM9tCgDpVrTcJ
 b8PXXt3HuXgLaB4h+mwreyLc9iZfJ2IHSgd5Scmw0liOva7RAVxSJzJwocvch9MPqmjFjqA
 x5JYyPjrReFLf5wISnNPcyoEHyY9Q9d6E4t8SK3C0cw0I6Pe7qFoqpmE8KLDZPgi/hpQmQa
 QTxcLXztZYngm98qtDB1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J8yoklCyqlg=:hLpGVWgERSNy5MGSdn+qjm
 D8e3w2VWz9INh3tN6cGgEW1EoiIGKv9yNUPH+Jfn2X+p+Znp6c5L6qNBkdur3ygTTp3QSo7jX
 ui+KtX1Q9UZeo5XOyCYX74TYkT1nAl3aeR2L/hlbd7p8UkAa6aVWukIdvX1HTUbCHcKMajl0g
 LPTMvbEVtluT6C++3AXl3bJHwen8Es2KXSP3pFU19qnKaa6Uf7HCW9YEWWKURDfmLHMQktLR1
 myGttJCoLuTzhR6rnYgMRSFh9NS0+hlXjZkMga8CV2mnQLobYHbxFyawRdX2LUp+Cbw9JZeHT
 MB8FnoV0hm+4wvLf2hg2KhvRit4jJO0S6W2CeDe5AzEldkU+1gBEQ9cgWuTQa9OrolHmH0n+I
 t9ODUBl5WwtLdiNN8DgbfZrdC0IyB0uSIPwOpHPHp0SQEsgKJ/JoldgQuSbcfAusVUKJYPacf
 /ERlBLXYkWRW3NFXRFwNSau4xc9DW5LOJ1OGP/Q121vJfOrfGZnJ3p+nU8yrVD+Si7jpio8yM
 9gfs5m7EFx7rcnRRb9lGGfq7ZWaI2MSQxCL5CHBOTDiChqZ3mQJBtETe4mUFm6ydWof0en+RN
 3mwd5Wb/YrE5W0odu1apkCmvHb5tc1OLISU+5/6vf8W9ZosJIT3OAuVCyzK5q5Rsrr106srw1
 AEDSdVbjPkcDild0vt3aj3ttzh1gbBCN1RCjy0ByujyMNeXsGUCN+NZUgmhia4vX1gOSSDOKN
 mLheyS7mmeInssJoqDEawnxBpnTUcuiKCCwom7z0ZJTINSrAO2e0Msm9BRLTrAaqB0lwDYafe
 XMrnAf2XjrkSRErfGSgS4w7tCPPG49BYsvDbtngKau6LW6p6mKxrybusOmUffsjdnhm9mIRIf
 DQMfGjGR/+lB1xGiYylqssUTyfBg22b246JmlqsAs7W7V2Bbh1M6dI4lzACfR9fkF9atoRKxA
 zIsHpzshCVsbJ8n/cjxcTpIAUWCQmcRulUDT/CiYBn8cRuvS+k79z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1893583725-1560869022=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

in the Git ecosystem, the abbreviation "LFS" does not mean what you think
it means... Let's not use the abbreviation for anything else.

On Mon, 17 Jun 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> after b46054b374 ("xdiff: use git-compat-util", 2019-04-11), two system
> headers added in 2012 to xutils where no longer needed and could conflic=
t

s/where/are/

Otherwise the patch looks fine to me, thanks,
Johannes

> as shown below:
>
> In file included from xdiff/xinclude.h:26:0,
>                  from xdiff/xutils.c:25:
> ./git-compat-util.h:4:0: warning: "_FILE_OFFSET_BITS" redefined
>  #define _FILE_OFFSET_BITS 64
>
> In file included from /usr/include/limits.h:37:0,
>                  from xdiff/xutils.c:23:
> /usr/include/sys/feature_tests.h:231:0: note: this is the location of th=
e previous definition
>  #define _FILE_OFFSET_BITS 32
>
> make sure git-compat-util.h is the first header (through xinclude.h)
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  xdiff/xutils.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 963e1c58b9..cfa6e2220f 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -20,13 +20,9 @@
>   *
>   */
>
> -#include <limits.h>
> -#include <assert.h>
>  #include "xinclude.h"
>
>
> -
> -
>  long xdl_bogosqrt(long n) {
>  	long i;
>
> --
> 2.22.0
>
>

--8323328-1893583725-1560869022=:44--
