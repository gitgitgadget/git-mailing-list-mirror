Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20801C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbhLCWeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:34:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:59141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238444AbhLCWeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638570647;
        bh=M+m0SBhjANDI9jrfxMfi5ga4iEaS1/N6IqMWS2juZN8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SjJdIul2mryOo/hjWdFajkQpEbZsBvx+24n/IEhpO4HEhyIK6cZtY2nkkyCt+wCl/
         BOfRi7OFsawkUunTbCzvpUoDeYb7bVOcsYziLGWiBV/8j6M97vgBxnlTj3cR0hep0A
         Nfdk7qOnozFvgQ5HqhqcQaK8pMrn8uE5y2PNkqd8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1mhkUv2WFO-00Bebm; Fri, 03
 Dec 2021 23:30:47 +0100
Date:   Fri, 3 Dec 2021 23:30:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>
Subject: Re: [PATCH v14 2/3] am: support --empty=<option> to handle empty
 patches
In-Reply-To: <b6a04fc12dfd1680b81bc946b09d4519edf3555e.1638329848.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112032327180.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>        <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com> <b6a04fc12dfd1680b81bc946b09d4519edf3555e.1638329848.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1974447232-1638570647=:63"
X-Provags-ID: V03:K1:FaiDJAkm8CIBF0Vj0+vvuAtbyamY/jffXEDsnAv5XorGLGPKaoX
 zdDyvJX70vqYvMnQ1jVSn+haJqdejX5BkfpjMn7pTJUgJelMas5hMtOP+7JR7feKZchMMuS
 bSgTr7F/nD28IiWsmto6g6X8GkCjJd1OU6pMWJvWTIY4u3z5Q1LtNKzjHtt+IiviOwABtoU
 RRLI30mFG1iart7an+pKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:43v1WVA3yNQ=:xg4G+Wh9/GAHX+OwBEimIZ
 Hr4D6jJtEnusPn3NorIOrlFMsapJ1+0wE1tKRQKtHjUuUp/OHDEUOsYL5dxMArjvZULfesllK
 rq9O6BXBhbGGMkeZondd6J2zPA6+HFy3Z4IvL7kZOk/fp328WPjnasPz0jo+17OjCWbD4EdUx
 GzO/7GKoK7vcspfpXMASbvZ4fzJTM+RYnr9MAyV/OohdnoaToNTBClHIP23SfIoS3jp+w8Y/g
 Z+0Q4wAO/UvnXmjOhJsCjApo/5aLg/3J6pLprULlKnZTu9ZCLzXVColmAErNqNOYnVCc70KVp
 qOAQ9XzhaKnK6pyYqGZzhbR1W4cybbCgsOH701Qg+47tNPVsbuUako06c+ce2cHx9nERywSeF
 umXQwxCMkJBKzH2NKNOLmAZLTGgD+Q0DOrgFhvdh09Y3ALektoQ6AmhW0365cNvUdwW4J5w4p
 2VRA4qyw8Yv1RSPGSDeW3YXlEZQYxrU+2G9ZKirTqM679/clf2Hlf2QredZN2na0lNMr+wa1F
 HAK86nnRwRzP7V5+V6ROr2h6655MKVuHsZu0UYctfgKnsDqnfhqrsFtls0nETDFJGyTPOOnmE
 VnVAGysiaIIeRC7grU6DO/G+aXbF+3Hf/oxU1OrMTNVBRdY+Kur3Asl6WVjOFecV/JZKYlHQr
 D8EZiH0U3HCT1PG+Og+nPr1h4gJ7GKWs0KApnrPtMTKyxxpsnfniUTX8btlbLxVTLTORqTAK8
 tyX9UYiefN9M5RP/FwtTEoGCTlnKHelplTnmaQXs15zMFWMJG/Gmb1KiBr2HhMd3Fxi2R2qFK
 ie7etQF5CHkpbDcRU+MVZyhRZjDlMCcj7hKWWDkOZFc1aYlrpWv8PA6uzH+iX3QhY0bzGSIgr
 NY7MunOm1iIZKZtumi7TZWdF1aXhuTlBJcvA+K+7/9BmJP9/A5lKA3B3kRi3oHbcN7fZkOO1n
 i2TTf6SI9pAegVlEu3etTDqIcjzhwtybh6Vdnq1pdlV4ZVeqq8YcXBiCPtiCV+lWC2R5YdRih
 PyD7gXCkp0t4dSco2T1oYdg+u/ND7zqCD77tUAniZ54Q/Kl/zY1/YrZdL+IVqPgTQ+/3MsZgr
 9l9RCWxltG4Q1Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1974447232-1638570647=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aleen,

On Wed, 1 Dec 2021, =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) via GitGitGadget w=
rote:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0a4a984dfde..cf9cace9678 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	 [--exclude=3D<path>] [--include=3D<path>] [--reject] [-q | --quiet]
>  	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=3D<format>]
>  	 [--quoted-cr=3D<action>]
> +	 [--empty=3D(die|drop|keep)]

I have to agree with Elijah that "to die" is used differently in Git's
context. This should probably be called "stop" instead. Or "error". But
not "die".

Ciao,
Dscho

P.S.: The enum value should probably have an `_ON_` in it, i.e.
`STOP_ON_EMPTY_COMMIT` or `ERROR_ON_EMPTY_COMMIT`.

--8323328-1974447232-1638570647=:63--
