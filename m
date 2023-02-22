Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3BDC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 13:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBVNpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 08:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjBVNo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 08:44:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B92FCE9
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677073485; i=johannes.schindelin@gmx.de;
        bh=NN0tmmyXBhq5ws9rpnRaKazOjhYg7oeOO/0nDGCWHMU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f9VFyGpKPcyG2keAw3HOeO0z0KZVmMzwBbuIGxxT0tq9kYLU+7Mw4/COCuz/CeiET
         8IDbfMV1G+5rjsMTopaGBSuV8JUNh5Zd2/0mf6uPkz/2TUAMzmg5AKq9IZAX0aIDaD
         hEfr7LU+u4S5Bc9Ot7XY8DuEQFMWHUcRDtYp/MTOUKgbRh+uCs91G+3qF6H7iQB7s4
         R+39Xvmlh2ZTH9W0T2JTUWVElcJM+bzOfsfM9Lk90bcpp66WP6kk91oOabT95OtJgg
         ExTatHxUXFfC3Z4aoR8CAqK4HfLhHSGFfj4A/nkFxgWbC9ojczX2Jj0wX8HojRz+4h
         AkFlYOusT4drw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1oiaS51mb2-00mcMQ; Wed, 22
 Feb 2023 14:44:45 +0100
Date:   Wed, 22 Feb 2023 14:44:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Sora.Ueno.bp@nttdata.com
cc:     git-security@googlegroups.com, Yuichi.Watanabe@nttdata.com,
        git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=E3=80=90inquiry=E3=80=91ECCN?=
In-Reply-To: <OSBPR01MB5223CD2469D1F8A8A5DE2E3CF3A59@OSBPR01MB5223.jpnprd01.prod.outlook.com>
Message-ID: <5377cd67-3191-3758-69a9-ff39fbddac12@gmx.de>
References: <OSBPR01MB5223CD2469D1F8A8A5DE2E3CF3A59@OSBPR01MB5223.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-52452188-1677073485=:24320"
X-Provags-ID: V03:K1:a+wK77mN8+wQtcMt2dL9MhDx1ssTQwLtGj4yxA6MqctJDjGlm6y
 3wQZHEksHwLqPJCmfU2zFmX26xzTv4nB96m79JSGCgWHLl6ce+CTqsFAKVsf1yiyLnbrrIe
 aN9Uy328GRgFDtQJLojXfZLe3wFSBRd+l6Ok+2AX8+cUWXZEp5Ks1pjsxV3Fr0Jgt7xlle9
 A2cjFOJ6uzitYDs8Fjymw==
UI-OutboundReport: notjunk:1;M01:P0:Q6WW6Mluxhg=;tlDMSzSZa/Crs//s2VsS1OUQZKm
 izu6w70XeFnEavh0BsilpbHGw6xzqqpTE0ZzT+Wt8TyypMN0L0M/LsyB2x5fBvd6blctvoSRH
 QC+vcutZ81LjYhicLha5KGaOOcXihdq0pY/OqaQqBaI4w2wJVOqMiFW2bHQzNMjB4nkofLRy+
 WalBVhq5IFhU7JMaEOO69c1AsnBZXAGvLuiVcCafLqiFlC6w1ODNxrhWcvcmVHr5dpKrDOQ9s
 G/aRE/f1u/k68gweiiTzh8qd33O2Gl7IX5ptrFG6RlBWSQZC6ZfcRrjDRWgqKXmKeZMvLD66J
 aomC36sBQFoNP/WQ21ib4uLUXsjwZNEZgygGaIRLu9DLc6H6bu8Jg/5/WZFxucPNhC/eC7v6J
 RQt3JoVBx3dsejYDz6y8jwZgnUNYVXcQTPSC+MDc5eII+KQw1LMYsUp5FBN+HGasFnICcCR+c
 0QO3gkvVJ9kD7WHvvAnHDSQzLAKGJPYVEpauKGU16dpkqWiv6pQDpQtxol/rl2NEv3gB9KieB
 prJtpLg8lqlS+KSwAWKpknsStMxm4AijsYdndpVhY5jL7uJuKzLaM04FHm9i9FfrJ7VonQllb
 6A9KR2G9Q8yhYB2N4yP9vOqzhhyjzLquFmIxXyfxJGY3q8FoPhKvWTe6EVLlF9TRx+T6YI53D
 Lm2VqamABoG6gNJSxXm/GUPH56IvZ02H5VwrZLIE0vWeFZfJWWPI2h2VeEj746e7sURN46dZY
 SBxcYnIsc2FbvW/IPkOiGVdcsWrOTMEjj/p3rfeQ0lK2V/Xqs5v9NEeoKA/cLmyD4ZRx4TCc1
 66BJyV+cTl8zp5AHY7f0GmQSUdronzc36Z+Er6tBbmLGmJ0+qu3urfIGCxDWVp74oVm8W4WwN
 es3KtEdHojBkRm0ic3e8tmTsT3G1hae5IOpC43aZQevBOoacz/WgxyuLis1FOUFFBkdPikHdv
 PkX+gmX/ufkLjqyFlHJCb2H9SJg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52452188-1677073485=:24320
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Git is not a product, and the Git project is not a company. You won't find
any joy in trying to get anybody in this project to provide you with such
a Classification Number. It is highly unlikely that you will get this kind
of support from volunteers who are not paid to provide that kind of
support.

Also, insisting on a reply on the same day seems to have the adverse
effect of what you intended. This is an Open Source project, not a
contractor you offer money in return for such immediate demands.

To top it off, sending such a request that has nothing to do with security
or vulnerabilities to the git-security mailing list can only elicit
responses that you don't want, trust me on that.

I hope you can find what you need elsewhere.

Ciao,
Johannes

On Tue, 21 Feb 2023, Sora.Ueno.bp@nttdata.com wrote:

> (=E5=A4=96=E9=83=A8=E9=80=81=E4=BF=A1=E3=81=AE=E3=81=9F=E3=82=81=E6=B8=
=A1=E8=BE=BA=E8=AA=B2=E9=95=B7=E3=82=92CC=E3=81=AB=E5=85=A5=E3=82=8C=E3=81=
=A6=E3=81=84=E3=81=BE=E3=81=99(=E5=A4=96=E9=83=A8=E9=80=81=E4=BF=A1=E3=81=
=99=E3=82=8B=E7=90=86=E7=94=B1=EF=BC=9A=E8=BC=B8=E5=87=BA=E7=94=B3=E8=AB=
=8B=E3=81=AB=E5=BF=85=E8=A6=81=E3=81=AA=E6=83=85=E5=A0=B1=E3=82=92=E5=BE=
=97=E3=82=8B=E3=81=9F=E3=82=81))
>
> In order to complete the necessary export process,
> I need the ECCN(Export Control Classifcation Number) of
>
> =E3=83=BBGit version 2.17.1.2
>
> Please tell me.
>
> Please reply today.
>
> =E4=B8=8A=E9=87=8E=E3=80=80=E7=A9=BA | =E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=
=BENTT=E3=83=87=E3=83=BC=E3=82=BF=E4=B8=AD=E5=9B=BD
> Sora.Ueno.bp@jp.nttdata.com<mailto:Sora.Ueno.bp@jp.nttdata.com> | 050-55=
46-8996
> 108=EF=BC=8D8505=E3=80=80=E6=9D=B1=E4=BA=AC=E9=83=BD=E6=B8=AF=E5=8C=BA=
=E6=B8=AF=E5=8D=971-9-1=EF=BC=88B=EF=BC=89 =EF=BC=AE=EF=BC=B4=EF=BC=B4=E5=
=93=81=E5=B7=9DTWINS=E3=82=A2=E3=83=8D=E3=83=83=E3=82=AF=E3=82=B93=EF=BC=
=A6
> www.nttdata-chugoku.com/jp/ja/<http://www.nttdata-chugoku.com/jp/ja/>
>
> --
> You received this message because you are subscribed to the Google Group=
s "Git Security" group.
> To unsubscribe from this group and stop receiving emails from it, send a=
n email to git-security+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msg=
id/git-security/OSBPR01MB5223CD2469D1F8A8A5DE2E3CF3A59%40OSBPR01MB5223.jpn=
prd01.prod.outlook.com.
>

--8323328-52452188-1677073485=:24320--
