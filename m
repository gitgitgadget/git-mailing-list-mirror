Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1861F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 20:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfHOUIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 16:08:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:32795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfHOUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 16:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565899693;
        bh=vDnvrCp1ePD7ppoVyv1NW2Q19zkwQf9B7sPanyiBHx8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G6n7hJuz4lBJBBv9YrkjKvo1t+h92O4LngJlYKqlOdQu1e4tvrwL0WOEwotKS9FKs
         j2B+uk8NJkb7RxEfhn5Nb3i9Q2hmEa5KGnGaHXo4wwmq8K2U4LxyHjTz+UAf9I+fFD
         x/0sOsVq7b+j1IB78kSYwfUYsEj+aMHD/SrdE+28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1i61XM3eyK-009trl; Thu, 15
 Aug 2019 22:08:12 +0200
Date:   Thu, 15 Aug 2019 22:07:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
In-Reply-To: <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908152205390.46@tvgsbejvaqbjf.bet>
References: <20190815023418.33407-1-emilyshaffer@google.com> <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ao8HKCJHmn4f8hgSwP4GCUIS46+dSH3E27VVIHB6UPziaQW9Nkx
 OZ1zyhmvyGUrZN2Zgp8gbA0CuFffezbZxhLVcEn23k55LdJTMGZUBoqNFKeOZA2DaVAJMZ6
 jfn0U1YjNGTQ24qFQDIsOccM9abWZPgsc9Th+UZgVbV/iGElR5MtBTQME+QOwkZa2FVMv6L
 2SuWv375DVU5UCkEt+ZKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSYVpzwgPl0=:y6PgvQam14Q+QpPG/2R/+j
 qeLuTcdrB/AUpf02hWLMk6/s3J64k6iV4eKAtFxsG5AkZmJOImU1Q3nLTW4AGOgv4+nhM24Bw
 Ny8S08X41YYMiuOK+GepZ+nGPWVdWhOOlIC3WdadLDcGnxtpH94x8oqc/9GByXFYdxomsB+nk
 WQidTwdSgr3wPf0A/Bf0YTlkQ+AtFPv2sdCr5SG9eTag4UuMIX5y4qQy6ux0iyXrViM2HhmM5
 87Dpb/y4bG7wWay0CetaO7+Bs1ouCuW0xOZYJM5P3k/prYVKOx9QF1/U0opAjk5BeHGcbNqtl
 aPiwFuUf6PSMT21IQP0VUhBuoycBiMgHPUj2T9SU9S4wPxsM9r0gOxUEl6VUaiDCuWz1KmmBq
 DOsmj6ihWQaQ8LfTVI61iMNQbmqDHP9uLNs7f3x+OPGif22Mrw4zZ8hVQMrx6abUg9VDGOcSk
 hbj+TgwQf8e4QOx0U2FgKS2LJ/W2Q6Us0SWdh+RsdR22cl5brDabJd3f48E4sZ0iqUu2nsxDd
 fPbXQabiFamWvZmTC3JkQR/p/kdNsPswdY/hQMKgfOBZTSgargfESv8nAAogWqxg8JPtdQQor
 zS6ihMPfuqbHYiX5AL2MkAa4IPshsfsEQUW2wOVp9IHlJMyosszrynC6Qtd2/SSsXxuwkvWUh
 KAq24LYtXZe9eZt52Lr3SBCsXdpB8Yh+KMw+R+Qi7q0TjhG1MHyGu6kijjfS9fwE+vc3nsBo3
 poMr7Xp0T3UDP1LhPVBkq2CyV21aHzTfo1qimAkTQBK9qv/dVftiNDBnPyc9+MDRdZdJRiHbH
 WX8ZGpfEu0BFz+iamaYdgVSxEqLQYLI7U8SVWo7YXIkmsmbCuDWTDs/YxFu1hsprJf+Gd6/68
 L47s0GOZIiC2+zvAM6FsLc38etERPh08AER+E0PV14QgMYMF7IZQe1PE0rkIOCo5qeYi+PVvq
 KxoL0cDhrp0yz7KViyXV/e7jydsCiMwoxf56XtVWampfJtoaVcLBHoTeaHDVzqEjXCqvlibKK
 +6M5HrPWGnQbzkv+zJ+OYPjbo69xy/AXQKBk8pWTXquMNObAuCcAgh9RYieBAZQ5xNq8Vxdtj
 Bh19rTX8oU3nuF2Qr7MdC5Ac5V+83fv04pYYAu8uhdM75yC8FFavDk93u1ga4hKXECXoSyzJM
 MFFJ0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 15 Aug 2019, Derrick Stolee wrote:

> On 8/14/2019 10:34 PM, Emily Shaffer wrote:
> > diff --git a/git-bugreport.sh b/git-bugreport.sh
> > new file mode 100755
> > index 0000000000..2200703a51
> > --- /dev/null
> > +++ b/git-bugreport.sh
>
> At first I was alarmed by "What? another shell script?" but this
> command should prioritize flexibility and extensibility over speed.
> Running multiple processes shouldn't be too taxing for what we are
> trying to do here.

Git for Windows sometimes receives bug reports about Bash not being able
to start (usually it is a DLL base address problem, related to the way
Cygwin and MSYS2 emulate `fork()`).

In such a case, `git bugreport` would only be able to offer a reason for
yet another bug report instead of adding useful metadata.

Something to keep in mind when deciding how to implement this command.

Ciao,
Dscho
