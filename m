Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7491F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJWRAz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 13:00:55 -0400
Received: from mout.web.de ([212.227.15.3]:41755 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfJWRAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 13:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571850050;
        bh=KG6OtXqW2qXBm9xG2uSzYDNkWvNkxuujchoWIwtIhXI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eDc1cjfMPvMyPMP5UFZpVsRkJJbWw4nBkO23tze3MUwn7EsfOZLeClHmYWI2wlqqh
         vLXcVJVSJ1qo9dnE4mJ4UO2t1HwybLtp/qruff74i0+7NKDg1Oc22qF2SRxWhq/1WP
         uHdpa7G/4bUrAkR6jtPsOiXE4ennGqvft+26xwmU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIYT-1iEpYe3UiP-0098vz; Wed, 23
 Oct 2019 19:00:49 +0200
Date:   Wed, 23 Oct 2019 19:00:49 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Git Test Coverage Report (October 11)
Message-ID: <20191023170049.hnzb22iiflrigyfs@tb-raspi4>
References: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:IvAPKB4eCMFvN5yY4hFco20ARVCZtjBC2T/McK1ZD7nxFZx9uC1
 TTq9Vg+B0isFxcqyRaNNJhH5+HFYk9Ce33uFwCsIcAP7Eu7lrQZhWKxcR9PIBIteld90QF7
 HaLXpZo6c0aUjyzulwg5zWf92TF6Y/ZyikXgc2aNs1DeVexw4fBnT3qGfNg4lyv2OU2/Pl1
 5SdzFI52hzd7kTngBMqdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rcBDZJjR0V0=:8wZB/k7mtbgng8pE6jZFsL
 omPauOxtyBE3Aegk6mksxJmcPpaEd7AcNV+o9L7KlmSbJ1ZltPWKlxB9FpHy2nXGwWW85d/o1
 abncazkTk+krXnmQCk9/rZjtgEZD+V0Zeo96+d776wrdxEjJr9n/4/Ol6nQ9+RgbXekM++jj+
 F5dwEhw8VpZblKbeDVmgHQasRygdVs3D5Z76maRoKgLDstcrPQpNItWQWZEGHLdG23yQU9r4s
 EuB2mQuCsnTNmUKvU4A1kbfx7rLTMJjKuqdsPJP/Sw2bj0JVNhTuhEwmfRFITBStfMW9qJzHi
 b8NHzBOXmUjCy3ZNFyJX7c131WeV6uZjZu7E9UVhw4Cy8pDYdfIkT3lfFq5m3rfX8HHywK5H3
 9bI1DcoLzKBNCtYbrrmM/w7A5+hIbabkt+go5bKNG1esgkT4Q6Co2MgiOAX8qDv8lamxOPCCf
 0/KGv32KrN7WdFRo/adyJk5NnccMObg8MxqdpIQCrjDJ2vUOisGuptqbJfFW0PWN93KeWNNL0
 tIIexagLNm3uu6dixPV8od06ez9otiXDN9mW/5rO8HCczOjKzwwXb1KjvQ6BI1bnIxhLgzyhA
 SjAcMmtcuFjeAbtU9thjQQ52n+RfT4iaQU81AQaOuIxiqjWG4e/C0sFajpECqVnRSG1xb52CH
 PZs5yPYGX21srXueUz1lGgJYicHPaY6xJc0rr/4UH5T+HQ/DGRJwjK9RYJnTiYVvk8t8xLxgJ
 1JNpezUHV1l/lrD+b1t+xHXwZOWAGTwVyM4r6Eq101JwRTKGw0jvf60RUKUReEu/zYXS0m6Ly
 VOxHlBgBvYOYwSi5sRNEPixlUmwhBnUXRlQm2jnj+fxumpVEHY8lYn2ElV5c0ZIGnIgtqOJ0d
 N9ay8wGLdZ7sBBUMO0Q4EQxOmDX7NUYv+PJGDRx1WZCVwd4nMRRCeqp+nZ8o2sEnXp+zLnXo3
 5wzTkue4CrVMbCglsLdqtPu1yH4XYIjpyOJt0MWBZ7jWMYSDHEbFp14kGaqVoct4kJi4LN/C7
 pHMYNJPepQyKAZ7imlX96IO4OvCyuBmU3/TqoDs5G1Y5fD8Qkvgyk+txIpNeQyfjLThv2mIpN
 J9kgZuvPpmgCLkL8fVP1Gj2N5SPsSp8bqG3ve7Ihq6iDdVY1+q/pMIkX/oNFVj+5ZcYWq3zyh
 HoaL/Y5GLADC8NOZM6p/1JAb+FZ/hUUfDyIP0IPmups/80EkNYL2wksAFJeuUbj1cQmX98jhn
 bgX4Yi/2FdvhXNzlcqFMhTcTEncaFukdu+a2kOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 09:33:11AM -0400, Derrick Stolee wrote:
> Here is today's test coverage report. The usual report format is
> available online [1], [2]. The report listed below is a new format
> that groups lines by the commit that introduced them [3]. Thanks
> Peff for the feedback on that idea.
>

[]
>
> Torsten B=F6gershausen	ebb8d2c9 mingw: support UNC in git clone file://s=
erver/share/repo
> connect.c
> ebb8d2c9 921) path =3D host - 2; /* include the leading "//" */
>

I actually looked into this one, and my understanding is that the code pat=
h
makes only sense for windows and is only tested on Windows in t5500.
(Linux/Unix/POSIX don't use UNC path names starting with "//" )

How can we avoid those "not covered by test" warnings?

One solution could be to use

#ifndef has_dos_drive_prefix
#define has_dos_drive_prefix(a) 0
#endif

in git-compat-util.h and hope that the compiler is smart enough
to optimize away that line of code.

Another way could be to have #ifdefs in connect.c, so that it
is clear "this is Windows only".

Or make a comment for the "cover report" saying "not covered".

Are there any good or better thoughts on this ?




