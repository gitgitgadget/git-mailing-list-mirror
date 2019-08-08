Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610C81F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404708AbfHHUVV (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:21:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:58069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404467AbfHHUVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565295676;
        bh=jhfnTcBcqKWAhRHtVJrOmC2dozQipWFVC+aOJCBnp18=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hV5wqDxO//Ve6ZPC/7RSAjsLMst7aQzRi3edRS8T5Y66cYtvXydSnpM/22Tkayvh8
         QD6LJ2oaggf6Sx8nZLDElzuJv/6v1GHDKSzG0iLIIbx4GYFO5QBFT68dDr9tFf6IiG
         G0oW1Wn7L+jjuFNR9z8OUuSyaDZwxoHfI52+HMDM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1hyb7m28T4-007Frp; Thu, 08
 Aug 2019 22:21:16 +0200
Date:   Thu, 8 Aug 2019 22:21:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v3 0/3] grep: no leaks or crashes (windows testing
 needed)
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908082219160.46@tvgsbejvaqbjf.bet>
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1467302872-1565295677=:46"
X-Provags-ID: V03:K1:sdYRKYTffRz6X4KmTeBAXfljNjvlFrgcnlLTpsAEW773AoNwIlO
 h7fsUJmZgfeRUOftX1uou41bHFLfA033JEZ2jC5Kwkk9h2pNr7U9fuUjJ1NRRtFZMGB+fzB
 f7dH3ZUr3advGhahNLjDm1SrCt0qKgbVbvaXL+ogj4P8wqGC3VUVioUgQx6IY4laIcYlVwC
 HFCwa28/JBh+UEl8hiJaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:62CNRKdyvA8=:Cr1ptyD+9JjumpZabQtIC1
 lpvWiMTROyYNrr2zYsx1hSWMvkz5NXFBRsy5XXU888fLXUluPmyAA5ee8tYpBrq79KY7hshvU
 ZFWEtVxhRQqgTZVcXeao2iviAp5PGceMdJWRTVWuEBrOXzlbQnrbxJpPW3UK/EEr5OWW74I4F
 4xu3Ieh5xVgD/StKyyYUDuUnHod7Swr6+4orE/Oa+jPm7OTPPc249wu9qHWDI386XhYQDewPn
 b2nlkxw21e/XSuNAkpps+l/CiEVSKJ+OAlcXq/HZmAmm32uRwMz4/kmzxw7vz+c8Mhpoznqw4
 f3YCAhJQbeztb6ln6xs50d4zO6EFCiWDamW01GwZE3mIW0zZ6KTKz1jcudQvnZos9F2dBflOF
 u4g1FYRIJCE9Pe1JqZVagNa6MYEgYehVS4NcC+sxeVHPvhECaRo2oGQSyNyiaoZnhP6rK/gwK
 X2kJPbjxNPliE8S3xMIV0IRyAcCdga+hoXwyQCh4hKK+7iM91fMu5YvhibLD5es7vRmsdGqvn
 hPSCGwNNfRZbjI0CZJ9YMAygtmDFPd2HWlvz2ZAp9/5qDBd5fO8BhWiaFT1/8k8Bjova6i2z5
 Lyrx0b6HeHU3cUec1c+5OBxDbIwW8lOJvXFCu1W9Psnb+JCyBSqtqJe+aZoFsshviBBJ2MZrd
 HQZLN3IGsrAdq9HVrCaYS25mOf3DYN9oz1m/sxeFtHE5abwOYosMqTipvhdaK8q90q/3r/3Eh
 dFXzM+OCaC0VzDGphFXsfYKRlBWrr+4hx2M+p20lypLUlyjfwxI+8hx5Z6k221Obp5An12piJ
 gD+Mru+pwf5gD5cLATPWgp1zhce9GBZzmnaK9mneXitgpv4+npapBwXa+bCVDbtuRl3t5ZRWX
 lJQ4gsXpt/WAVMG68pfT2EAxyxstuzOmISDHp4RVb1Y9MhJ/v9T1vq0Y9+TU+V3AzG1iBpm+J
 UKyZZB3bn3dV0ZQRI6kvO/3/8zus4a4PDXLnd+XCQfEg1TskRy+U1VEg553bNkjfZl2NYhL0A
 mqxz4zkJLR6Zvlp/lsHZ+gefqQB9myERDBiN4mivKREQkYBDJrhEZ0o2YtZet5BJ4Kzwir7pu
 B20EbQaVRduZZKK6HZ+W+wd5EpsfQ0E8wRuzgBHhIwSyLhCtgt4qbe9uLEQmEluhIZgijsZ1r
 GQKfU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1467302872-1565295677=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Eitherway, since I am unable to replicate the original bug or take
> performance numbers in a representative environment without Windows
> this is only published as an RFC, eventhough it has been tested and
> considered mostly complete.

Well, this is disappointing.

I worked several weeks on getting Azure Pipelines support in shape, so
that you can now open PRs against:

- https://github.com/git/git

- https://github.com/gitgitgadget/git

- https://github.com/git-for-windows/git

to get Windows/macOS/Linux testing for free.

So I guess you'd like fries with that, extra large ones, with extra
pepperoni seasoning?

Ciao,
Dscho

--8323328-1467302872-1565295677=:46--
