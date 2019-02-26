Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF53A20248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfBZUDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:03:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:42611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfBZUDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:03:07 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTTKZ-1gXbX72T03-00SM0q; Tue, 26
 Feb 2019 21:03:02 +0100
Date:   Tue, 26 Feb 2019 21:02:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t3600: use test_path_is_dir and
 test_path_is_file
In-Reply-To: <CAL7ArXocrtCBpEoCM6_aSWcKgaVDwBADMZ9WEBzxpwOfHKuHGQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902262101180.41@tvgsbejvaqbjf.bet>
References: <pull.152.git.gitgitgadget@gmail.com> <pull.152.v2.git.gitgitgadget@gmail.com> <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com> <20190226163737.GB19739@szeder.dev>
 <CAL7ArXocrtCBpEoCM6_aSWcKgaVDwBADMZ9WEBzxpwOfHKuHGQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-613778193-1551211382=:41"
X-Provags-ID: V03:K1:TVE2BD9CwgU2uGKlTI54ZLc4X23SFLqUTTDPrXQW7sR+ocXJJhG
 PkHCkZEhP3znMU8okAujNj1LL5qNw/a0hGukos6U3QE3jyyMWdqU5ldflgR/GYvPxYj1RTZ
 j6ij0sfmtN1UeqwrkeDMu6eLrgb8yEzDrqq6DuoLr4TkX4bt4NVYaIUO7vs32cGXa0548Hq
 drPGyO78bt2KTSEdnYdTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/EbBc2D5mn8=:2SWiUwBVTijPBQKZy08yTd
 xebMpkp7gT/Pb5HCQ8jJsTbz9SPaw73uI9Y8FXBY/Y3L6kW6cu+OGJuvlD7VyjaDJPwOYzRL8
 gp78Lye9hhbJTXJaqQkzdtWoMxjMLl7U2B6Lo8rkfAyj/5NwdBSZQG+C/aovyO6ue7jMjBdJm
 o/FFWs73/Rqj5sPrqUTaRW4poWjECC0jlQKEg/PdQO0mWN+4kP2Wp+N/j3+RqL+NuA9fqEhcX
 9S2BUUytMFEyIQleBE7Y2XY/dMq6wSa/cdRJi8sd2PbCsslz+UvOV5RHhI1wyULS9MuHzeOFW
 L/vpuNi9BTNWL0OMhleZvffN7f/imnqjro0pOqu2A5xMYawQQqoe02ic04kglg5fPHOTnxCC3
 PwclVewOw4ejdOfU9+NpgwbxA5c0PpvuXtdZya8QcEy8WFjSzkQzYKpdxmjR/ifZXfYZZKDfk
 EuNY/ntHa0SoYcFR7QYTBc6T/2+zqWV9onev23PNQfPWLO2rCoZZsgZZx+bimGvL0hLelJtwQ
 Z5NuaD+7Mz/p18N+343fbRu0ZqdpZ6KkCCkIcI3tUY84V5YSavwVBWaTXa+dhj4cpDxuEtNvD
 AZciUEYt0vj34kMgDCdETe/d8ucrxBMI1WhgYDHvxkchBxDRVtRXxWVsWj1fmAEyo9e2S+/cV
 aLXsbZTaryVoo0TxKzsjoPMhplP6jz7NI8uxrgzFySrO1+Sc9yuX6td8F1BWAbqp22XVNPAsb
 ytXAGAwbrCB0oOoHOMcZrKinzWRxMPw4otopaPtn6HYNMiQMm3U2/gSm71JbuYBwXiyw85dVU
 UOfNeOQ62dkqzyh0fOtsu3z+4f3M+ci08DVkyJqZV4gsok8a6+KCodKiy1bieXdlSvZj6TPGh
 cGZkk44Xy04VZX3R1IO7az5pY0sXukjNuTAhlo7AAWxQbbimwn0z8c92lUNuMiXHJWmT7gqiu
 2A7Lcjsbi7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-613778193-1551211382=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Rohit,

On Wed, 27 Feb 2019, Rohit Ashiwal wrote:

> On Tue, Feb 26, 2019 at 10:07 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>
> > Furthermore, there are a couple of place where the '!' is not in front
> > of the whole 'test' command but is given as an argument, e.g.:
> >
> >   test ! -f file
> >
> > Please convert those cases as well.
> 
> I think since I'm modifying `test_path_is_{dir|file}` functions to
> handle calls like `! test_path_is_dir` well as mentioned in this
> thread[1]. I think we should replace `! test` calls with `test !`, so
> that the changes are in agreement with each other. What do you say?

I think what Gábor meant was that both `test ! -f file` and `! test -f
file` should be converted to `test_path_is_missing file`.

Ciao,
Johannes
--8323328-613778193-1551211382=:41--
