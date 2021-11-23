Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCBCC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhKWQPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:15:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:50087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237455AbhKWQPY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637683925;
        bh=SkZvNnvdEpJ1N05PEYHtC05bQJRmQRZ0sjU4HwSgpA4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RmNtHKUZls3k7bCoT38szqoZffgiHnqnYb2NAvj/EbHuj9EoEdSQA1QfOe4cIxpNA
         2khAiqggkD50hFFoFVDKUabR0hE8wUItoHhKEljh9LGFW7t5BnAybjLDi/Vpj51EJ2
         XEUSZ0npnuvUjJRYQ5bKfaQFHumrGn91Be+/676Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1mhGh53yvz-010bO9; Tue, 23
 Nov 2021 17:12:05 +0100
Date:   Tue, 23 Nov 2021 17:12:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>
Subject: Re: [PATCH v11 1/2] doc: git-format-patch: describe the option
 --always
In-Reply-To: <3d7e96ce2b32096a6b900abe825b9df7b0ec3831.1637681215.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231710500.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com> <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com> <3d7e96ce2b32096a6b900abe825b9df7b0ec3831.1637681215.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2146207588-1637683925=:63"
X-Provags-ID: V03:K1:9upfY06chxbBwRcBMzrWknEjhZPHxylKZUWP1kBBgNACfuPP8TF
 oqb4YlnOSRGp311tfMwmUYVPBvIkw8Z+FHX0kIG/KzqsD89Wb2yd61dvsGUMuRpxb9t/v8X
 91Ky0aK3swHmVoX+jNQM7UOvuCBDetAzCcLFY7hQMXyfZDNLCLZzYeBCaCm2B26txX7cAcK
 K5QO3w4WjPZS1wSLb3lQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KN8T/MTCzl8=:KdlL9DOk1YI+Hbwqem9yDU
 otyEgePuYXH9bLNR+clu2cYeaqR3DthMitVn+gdr2pnoUrpRJmvCgMUZt92utueoTQbJ6/Rcm
 2LMOWlQl+Z3wWcRlPQPIjScSQ6GE7Is5McRHY20+tFFnuan6X9+kInJWNhhPTUGjUOBJWjRBG
 GExn394f/YQAT03k3nnydfB00rZ6vYjrlyGDkQeoacZqEIOHa/rdSEwgWiwSbnPqbiB7jmicR
 ftHj51E+hM5orlNaWOQpJ0XO0SGNFIsb9FKzkzdQER/mp3zLWsCEeieheBh3R3OjsTqaaD9L6
 SAbxmedd5aXqPRDcjSZyQ13kqcHd2InQmJWn66eQjwOh9JIF+hQfSOSuYz4aCrV9JZqRM9JZG
 gHg6q3qn/CIFjKQyEI1iVWp3uSp1HyvLLIbHCVsvzwcz4M5XKfOuBbMGX9a/l6nMgXXazswRa
 PlNZKGHj2uCutFkayajUs8yze9jxS5Mj59ga8+L+PqkJXGb+/FEjgXfNYHA2j8iJCSqzAYy33
 Jki3k94dMU/zajE7zFwb615eOwFk3KLrp1xGWaQOCqy+mZZZkNgpJx5G1BfWEQi4qudQjixdi
 umK7sWiIhKWyGpEMLo7lA0oupqsA/6G9raWx5ekyq7daJbs4QukfB6qxBy4blpm7rzt6bVjVW
 lvxtwOhIbyWcEXtcH2/uDI0xQYDhG35hzHouF6vSn4gQ3r42E9pf+trfK1ZkVdcjNW0ryXDiW
 UBvojeKw49YC4eadeVKRiHf9CkW+kit/cEim4daM9LrK7dMcYzkWtFFJ4fTcI2ZR0NR5Hj9BI
 gMRE8lOTqFx55YvYAyiL1ligf2k6UkpsRyK+qMEzBHGvWMTEf1LxuI/Xjnv0+mveahkcUNJCu
 anlQgsXQYpjlYv+h9t7XxcWKkuhk1mI/Ua8Yt508H57rXWlh8+G1TsnqcpWOT+n24CS7y43dN
 tH3Flb3nkCTs0UtBT4CLMhhAq3f9l32hHG5ixDC0PApfqwFBEEOEBR60D+IDJR76wEBMbmua2
 kG2vBzUIn3iAuMY2n6UTEMM4zdb0jvjuyFwoGHytHcLSKGr3rKFQ1lOyIVYZcu7xQzhgLeww9
 FLfp0iD1OKtZGM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2146207588-1637683925=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 23 Nov 2021, =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) via GitGitGadget =
wrote:

> From: =3D?UTF-8?q?=3DE5=3DBE=3D90=3DE6=3DB2=3D9B=3DE6=3D96=3D87=3D20=3D2=
8Aleen=3D29?=3D
>  <aleen42@vip.qq.com>

I triggered the Azure Pipeline to submit this patch series after merging
the PR that fixed parsing of the `From:` line.

It looks a bit funny that this is in two lines, so I downloaded the mail
from https://lore.kernel.org/git/ and fed it to `git am`, which was just
fine with it.

Ciao,
Dscho

--8323328-2146207588-1637683925=:63--
