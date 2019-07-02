Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D441F461
	for <e@80x24.org>; Tue,  2 Jul 2019 12:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGBMPY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 08:15:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:44259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfGBMPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562069716;
        bh=yTY9bZKWdDOvZ69bqhD5iZM/mAWv1o7+2e/saNHlI1Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SCVN1e8HYOqJw+6jXHwreL3Mse7MMimSry6JjXyAvLS5wxFIa+XakvGqA9I8ThWmz
         SKiicmrFw7rm8ouZ6E8tkHQiHwdyI1P+hn/wDJaAQmlGvg0DsI0+qbypm0u1FBk2BJ
         L7CZpWJuam64/C4EAkRWkLNU9hOLh1XD9akKDka0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1iXlqo33O9-00ubYV; Tue, 02
 Jul 2019 14:15:15 +0200
Date:   Tue, 2 Jul 2019 14:15:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/no-kwset, was Re: What's cooking in git.git (Jun 2019, #07;
 Fri, 28)
In-Reply-To: <87tvc578mu.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907021414540.48@tvgsbejvaqbjf.bet>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet> <87tvc578mu.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1059617838-1562069718=:48"
X-Provags-ID: V03:K1:0YnL4FhBXdZzzrS2hmzlT9LH/QH6CQazyJMFbZ2P2OpM1CEXKYt
 RijLOPfDnNG8MhVsphjpJr5VV67FhvMTlVmSFl67NzJRELNoBSTx2hYNPEzHnJ/M7p6I8WK
 lH3SH26khpt+/QSACaT5V7qHoJjxvluwHXf8tJwogYKgNbLLOXCNc32c0NI9XA9//yGLIoW
 U4aT11xWKRjTpuA6tlBrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+05CRixtbOs=:FgZepEMHyFvFHv8VtlEtT7
 RvVpKGdZvl/nkF9cr1u5jsdcBChm31bZTHUv4C8UJmMJIjYGVaBsULvO4I6zeLQ2wQ76fn5Il
 c4ZTJaKBpy+xv+UdRha3SZ6ZvHDCABl98gt5xgdyobVKZJTq88mRCGpkvndb6NHNNekvTN5JY
 7QwiPq2cs3AEwTRQb8wq7F6ctZ4/QQXnhXeJw/1GDHaBUmU4FSj7Fys/y00CSImJ+lOLwctyl
 B78VMjSaBmy9w7kxEPdV3YKM3fVgTFXiuNlX97/M/dVSIk3/jOMFojYMzBPYCLdd36yzwWHrc
 y++xdI4TyIuXigqNS7XJShqcMJlVUe9zXEojkERKP271AiNISWN1I9FFcJ/xw0G0j5DScGe+u
 eshKWMZppeKA+b4lIDz40E44bT+dgyg/ntEl0sbO4tBoQGm9L6MFatF33HkiP50zDUcCF9Xdy
 h/Dwtm5rW2RGq4fcI0s3BzGG+t6HH1BVlUb9GuzQK4ZpZw8k+vjAnTjmpMiOnZ29e0f2K9Ta1
 FEqil6wv8kIJESoXthMx68DJNocq6KHQjgw24FXjlch1NpE1t6kQUuL0dnXQWkMulovc2lQ4J
 ibzxl1qstkBAeDKE3KFfBjHd0AuwJTWYjstiuBD86Ay3XztvgHzspOMNpjLJBCRA68rfkY/Tg
 TONWKkgdGXdRrmyQfu8WCaq7vUKfPx8ZJY20+qhe7iWyw5XTRrsVBeK5ayNR6HBKEKLBinRXy
 gM0gWpWn3Bi+ExFdlvwqsz+uBpiKx5wH1AT6Z23QfW3+0OaWk0H7UjZWiOaPp/axW0M0slD4I
 dZc9xLBkSSQy0s6Q5Xaehct90z5UX8u454ngCDcXiCTBiYNBcWs18znO6gf/FEVNkM27J5WB0
 AcpbNutfffw28D6zKrwz9DGfxZjoZcaMj8e9QvjORXDnrXhmbYLtPOwfgekxozvLUvdVAVeWH
 gl36jUnxJ04eTf5BYLfOQSMUSLaHFzxTv7EuXg+6SvvCZvewtQFWqyYTz3Dj8ZJJLM14+sr+W
 qDxeXPLatWt2UDf4ODGskLX/Sw7G/rYMV2ZMv4U8EwaEcDyo3I0itjVZVnCUdYLEZJpumEFOF
 WThQTcHHZKUMgLmW3BQgxOvv9UmG359cHcC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1059617838-1562069718=:48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 1 Jul 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jul 01 2019, Johannes Schindelin wrote:
>
> > On Fri, 28 Jun 2019, Junio C Hamano wrote:
> >
> >> * ab/no-kwset (2019-06-28) 9 commits
> >>  - grep: use PCRE v2 for optimized fixed-string search
> >>  - grep: remove the kwset optimization
> >>  - grep: drop support for \0 in --fixed-strings <pattern>
> >>  - grep: make the behavior for NUL-byte in patterns sane
> >>  - grep tests: move binary pattern tests into their own file
> >>  - grep tests: move "grep binary" alongside the rest
> >>  - grep: inline the return value of a function call used only once
> >>  - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
> >>  - log tests: test regex backends in "--encode=3D<enc>" tests
> >>
> >>  Retire use of kwset library, which is an optimization for looking
> >>  for fixed strings, with use of pcre2 JIT.
> >>
> >>  Will merge to 'next'.
> >
> > There is still a test failure that I am not sure how =C3=86var wants t=
o
> > address:
> >
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&=
view=3Dms.vss-test-web.build-test-results-tab
>
> CC'd you there, but as a note here: I believe my v3 sent just now fixes
> this:
> https://public-inbox.org/git/20190701212100.27850-1-avarab@gmail.com/

Thank you!
Dscho

--8323328-1059617838-1562069718=:48--
