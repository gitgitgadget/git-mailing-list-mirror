Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E6EC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3D21741
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E70hxaJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgLAU7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:59:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:38407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgLAU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606856290;
        bh=+yI0M5bDcFWbc7JuyZU7iaMKMiyWbGWVUEejyDfTafk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E70hxaJi+S8Xzy3wkBxn3hjnxRlKxD3ptL81ezVCTfqOpsoS7EntLKqx01EWgqPbL
         xbPdjIuFypiF1V2qC+MPLKvST8kZnxHHS1+kuLnK6a03KG7B40rCZNiN5WSSdeqo+i
         F+fqZEkyskvYG38XKOTgMsVOqvRw+zB+maw2wpWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1kbRGU2tZQ-00QR0N; Tue, 01
 Dec 2020 21:58:10 +0100
Date:   Tue, 1 Dec 2020 21:58:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Zaoshi <kabazaoshi@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git mergetool does not work since 2.29.0
In-Reply-To: <a284dc99-7da3-a313-6d9b-1dd40cbc5b22@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012012153310.54@tvgsbejvaqbjf.bet>
References: <a284dc99-7da3-a313-6d9b-1dd40cbc5b22@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-673543811-1606856290=:54"
X-Provags-ID: V03:K1:M2fu2UL8Dd598JpvZl7gHMWrllbSijtZokI/0HxSRtIDj7e5N+X
 9Kos2O1JX1RBWl1uYyKcGMVIf4OuCgMqqD97C0v3X7v3A7W5Fe8uAHcN1w1ZfeGdbZVZ6ZG
 rWV5ImDkhB51VItIjVf+B70ela9S6RZNh6PanBDTNxBBVtZPNhgrzuN0FHEMamXm9hZ5Hb2
 jrG8tvLzfGPMneX4nd7ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rFny7+OdM+Q=:ULuYcYXlz/VEQ0R1rFqvpF
 4A2P8WCMiIJUY4VnfKCBY0f5/13N3v/4cqEwDBM1bVOkgZPQY+yW4a7W0SvxGiU5fbOYwSTEr
 L2xzLftIfHHypO+gaQqFCT5m1w567Mu7lXEpuIEEtyH1cQmX0U0qFuhKFsr57ImIcNLXh3zXT
 iQV67YoFfSzB2Uh0FfcH4RUeB1IPSgGBTy9WUDQyueSHzvad1rzmK9mibA/MaePzs71bCSMtp
 Gr1nEzPj5dvvxDBN4h4u1OSNbb/dEzUUGD4Wm1TFf/yITeBYNMNcWdvq68MW11Wd+UBESP0Sk
 lR+I/RPqERrt/xbqYVKlxrcwlS24AqmUMo4CA+0gaPhteracVmtoYMjdgKCCY7DdSNh9wsqEp
 UpAcodyO8YFSDHaVovEPvwJlq5Ti/iIAWgHBZzPS0uRzaglTUMivcYnnkoSVphha5XCnGS2rt
 8h+cgkLcFUGEvO1OVsBoNqHyjzF0uvARYjDeyLajDGubgWZeBTejt6sfLO0eCEpArlruBKDvp
 XxV3+eU78azgy9Lihc/9pFbuwLpeRF/sFpDDDlfUZe76KGC6QU+EkFLADix6y9yWX5HYXsTh1
 oJCS9oxPjHmPAfO00YTG7omdRlgB39nHWnYTm5+6xa0snnFZlKItHWI9OK2vSGBjAaQdTKkhV
 XDhg76HXoPiRAGFKOh1R5YaJdzBplEZSSYC5eeWnv7EMz4pDtwFDZDMR+NdM6eG8MTRrT1lzZ
 t2d9liEh7eYvHz+g7C1lQNwafNtS2x/WOYZ7TRyCs+AV8d/OIwOjkD7ZMN5lyNrb7w4pdTVVK
 qsTef0zB9gK6ze7pkx5ZVnodmXP+A9jGDl/QHRQlZuu0/TDYVXvmNRwp3YzizcOc4bsryiMSp
 GjYrrUj/+Xm0A8NFefNuq4KufsUnTszAcJ9buGK2k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-673543811-1606856290=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 28 Oct 2020, Zaoshi wrote:

> [difftool "bc4"]
> =C2=A0=C2=A0=C2=A0 cmd =3D \"c:\\Program Files\\Beyond Compare 4\\bcomp.=
exe\" $LOCAL $REMOTE
> =C2=A0=C2=A0=C2=A0 trustExitCode =3D true

I believe that this is fixed as per
https://github.com/gitgitgadget/git/pull/787. It has also been merged into
Git for Windows' `main` branch via
https://github.com/git-for-windows/git/pull/2899. This means that it
should be fixed in the latest snapshot:
https://wingit.blob.core.windows.net/files/index.html

Ciao,
Johannes

--8323328-673543811-1606856290=:54--
