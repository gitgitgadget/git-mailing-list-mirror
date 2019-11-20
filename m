Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26EC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638922444
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UavPSf+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfKTLtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:49:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:37495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727619AbfKTLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 06:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574250544;
        bh=egtaCtQ7E5VGKNDThhW0XPi2erUFZAELnoOrg9Ba/bQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UavPSf+Ryu22GMGgBKJgn7j9a7dyh149zjMQFyVfsOw95W2Sble0MVzNxbynBnPPR
         wEwCA/7CRsOgrdQ7eEnbwIz5ikscsuZq4ZEbrrNhVl3wH8tzTrc+nKCMgFjlsrxYUv
         8JHrswhS4VxaPUKJb04AG1oTMH2GWS8Cmzi8dgA8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1iGxYq1USK-00KwNK; Wed, 20
 Nov 2019 12:49:04 +0100
Date:   Wed, 20 Nov 2019 12:48:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Reftable format implementation in C and Go
In-Reply-To: <CAFQ2z_Pe1Pdjy22VmCMzf4Gvx3wte1eQRn_PjSisJbr9_y7bbg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911201247410.15956@tvgsbejvaqbjf.bet>
References: <CAFQ2z_Pe1Pdjy22VmCMzf4Gvx3wte1eQRn_PjSisJbr9_y7bbg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-789586917-1574250545=:15956"
X-Provags-ID: V03:K1:rJPSCVX6OH5Em/feZj6WEE53VEBGRK37cViCN2DRMPweK3PUOW0
 4KjrzKZ9RJ97UNI75/G0zTB53zPPXIF5nm3ahF+3l6qfseZTFcpVt0eqLRvrtAqML8CjPU/
 F+sd74XdN65LgSSIA5UWaM6XqcSZFFsnA3Iaulo5ayFtoe9OnZ4iShd0laMj1sWUmgnrVsU
 3Spq31ZILZLoV04h7jQOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9qQl8CSUos=:xZb0niU5RRF72Rqo1374IY
 eh/4g/VTTEV1+Uw2zfjTTts10w42b8x/17U6h8F+yo0Pg5TZpqV0NnBIVGijggQVaB8DZCu5c
 pfgol9tye8JBiaFHSZTWIuuo8h0PfwWbGbpUxnT9H1ORj39T/mWVbctomkrqCVbCRh+ZfGdH5
 ukwMaWuyA9Rq8iaE7ZVWO+/h5N6aKShVAQiusg40uJeXKFoyE3YGqiJ4BgJaeqsl+BmZbxhHU
 2KTGYK6jL8QHocKGOag8DtqSd5mH1FQaZnNegPcfUlCZhejlterFdfEvxdgyMDZYs8NxVcy/I
 FOzdBGLGH2rfOjHgm/tC7cso3mDtm9GN3+EM6p6rQvxpgMC8AhVUNKS7MhZLG2kc59f7V9o/6
 tMdZMA3L2Xdx6I5bT3O3l5hbeqj4h0JJs6tlNJ3jMv6L4iBH1Joxq4dNfJ8usbjThPzaYN3pU
 kgP+/vMOXYRWDsWVxoXEw8m65cQaMNV+5qHx+GH+KM06Fq9DJNDAMWJnNq5tRr/S8lKYgCZ1z
 xDuQ2/xiyvjwhTFHB+PJOe7p/yUyT1DyNmBgbJYfPKe4ZDpgia8pMm069JojGO+8C2WQPcF1W
 EQ2/JDawl54PK9+FRWghtn8b0LI9p9VTzWSuMSK4y2fx4zLL/8tg2KQUAar3TP+zyB8BI6VZk
 N4z7SO/Atfhwov+kZTtA72hNJ1hga5X80tCcyuAF98CRP+crd0PLIEr+a59SwYjyMnjAIEveK
 flFnySDBeE+fT4W7xC/pu8JmCYcDF7nfT4IeyH6WPeJVTe+Fd1SjGqhaSIFiRqOBl7pPUw/vD
 HG1+gAClOv5XT7V/4VCnZK23O01M10pJuY7/VxncgiSndbWHIH7K9msiPZ/Gzw4uY/ON6RW59
 WBbTCTAwaBLh315c2Y1nUzFjdqMLy5seqkLt6SdNIsU161V28WDOo28dpPe9Rh7SyRPvrRCgu
 GGqiQ6FkHbbdlXpuu1FGNIYsxiiL8rc5jcfNQbhvkDpJhc6AZTzDiSb3OxsdwEh7FslIwArGh
 7L5tSDRV892QBsGq3j6osbDMznlmuSW3MtVr+p+SXSQgJBRcRS+YUy+qQwsUR0PPqhgTEh8Fz
 MeW6Xgdo7TzY/a/iL5qA39XO0q2MnHjXGLNTQR5GZwtRIIBEd6GM/Bdx/0iSRn1fo8UK3JKM1
 iAJ9pHLaalUA20bNYaORMX5FxHGnvmQVfrjbAOIgndz7DTIyZfLySU2UasVP1sjS5bD3xewip
 K1Vo/d09k7ZMQLtWjotSVGK2GjKgLJa6LAOivpPtEoEK4tWT7GhnNJAZIq4M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-789586917-1574250545=:15956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Han-Wen,

On Tue, 19 Nov 2019, Han-Wen Nienhuys wrote:

> I spent the last few weeks cobbling together an implementation of the
> reftable format in C and in Go. I thought this would be cool to add to
> git-core, but I doubt whether I will have enough time to see such an eff=
ort
> through. Maybe some of you would want to  try integrating it into the
> Git-core code base?  Example code is here:
>
>   https://github.com/google/reftable/blob/master/c/api.h#L153

Awesome!

Would you mind, however, to relicense the code under a license compatible
with GPLv2? Currently your code is under the Apache License (which I heard
somewhere is probably incompatible with the GPLv2 used by the Git
project):
https://github.com/google/reftable/blob/6cd8dbb4106d18627f442d3148de71d7db=
43d4b6/c/api.h#L1-L13

Thanks,
Dscho

>
> cheers!
> --
> Han-Wen Nienhuys - Google Munich
> *I work 80%. Don't expect answers from me on Fridays.*
> --
>
> Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
>
> Registergericht und -nummer: Hamburg, HRB 86891
>
> Sitz der Gesellschaft: Hamburg
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
>

--8323328-789586917-1574250545=:15956--
