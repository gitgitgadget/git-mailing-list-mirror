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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7C21F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfGDJf7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:35:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:43201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfGDJf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562232955;
        bh=lSaN39rzzydH+jn1fCdm2tX8cEOAzwTwZ7jiSHmVAag=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N+0MiKG8OMVqfSeCdWavDiIyz010N5UwH8lVRfJ9A7AWrL+6uSQk3lPdKxwpmalLs
         Yxz0YhzzNiKsyZZqwsZ2FI46rC6Vz3EqQsiDw9Bfa+dgGRq5zEHk8wrI8TBesy7GSC
         DorCRHEYNHg5n/YCEOVH0PtyUbgrLH6vyGqgdVjA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPlMc-1hf8fJ2s5K-004xuH; Thu, 04
 Jul 2019 11:35:55 +0200
Date:   Thu, 4 Jul 2019 11:36:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ab/no-kwset, was Re: What's cooking in git.git (Jul 2019, #01; Wed,
 3)
In-Reply-To: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907041135020.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cpx8bS5RVcY9xSibMdw5E2ebQdYvBRQhB2dlnU66EiAXUTyPHeg
 bh0fPE49huoNRlHr4VKlDIiRL1WfjUnBMn0xq/fhcXJWjBzSeKTE6CoXAPA06TJKQh+5fsR
 btCD2AuZn7Gomr7jFt4TNbZqyJLAbdLeRoOyDiXa34ob/DUajLjLyzcUnbhVw+JmO6TOXec
 YP2YA/sBbk+3GCsx2kHEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:17rQ8QgCXtQ=:H0KFz3vBQIG2PEZvV0T3Nh
 wp3GmCOrTOFtyUO5WxZp/6R3XUTsbnUMVelsVaZZ6Xps1sSIo6W11H506TOrEweftkrl19lv+
 3K0cZNLdiZX5DyvSj0Rmj8nW8gpmajuQxa3NfFDc9PolNnm4c3Q8uaQBFgkI88tZiKSqdXboU
 ZVI/Tn9O/dM8B9zh0qlroinNCqNfh3ME7DFoG9fm9FrqA7ozADG6daipozYFDtd+PmFqtL6Ol
 BCtQ41pMsgYaGcF4F0b7a2oIKLq7Uvot+UogfJG837SGd9MI1Cn8TNQ1JWvEk8zvvbNvEtnBv
 tHrxZJT3NBckefVWYUYtxQMxz2Imwjtc8Bn5CT6zZmHzo/JASUS2ZE2WuX2KLWJlwqpfHlPa+
 yEX4ioEuoot22hZ6d7NZh2/NaNROBVAz1ogWKHnsdu1qY1I5ugfu4vwvciU/uiuSqvoRFnYZH
 DrQO3JARPZjKi6QQbhraPOS/JHTyFULkd4VMp/0gVTVjDldtWGRAC5d7Jq4ZRoJwN8YOIz/Qd
 XFkaqrr2Ys8VvopfqHWI285cZ9cWCOvvXgpL/WyJNAdelYhZPvw+SmcB9E2y/os+FilArQp9k
 Fg+YLi/c7IdWE/BohAlsMMlh+w10YDXYgkZZHkiEdkOhpdesXsfPjJJ2hgGRNRX8EvDo//JTI
 Lc9C1tJnQgioi5d6bLEn99/eYPCLkhE3KqsA6AZfaiFeZy6Yd8aSPNBH+3bHkGJISpm+w+Owj
 raJz8ZtSgEB6jevgYPyKuo2tV1HjyRrWh/AZV71pICiaocdqc4ShF9KOtDEPE0AaXsSw63FMN
 oC+FuQ/igOO5GnaxWPN/RLGHzw0dEN8yqXUbAgNYwxGeOz2VxCQcr8KJjbQwtY6Tk0uHgcVL1
 kmNmbZgeCtcoev2etlJ3uwuoPUpSCO+ztfdVnWtTfiVfMkcsQG4IbqhyVaAoV9XvRdP7Cl5it
 CiEncK66vbAhmr2PEbpx3sqZNYDxAnFYy67jTFnpdDo2PVRBuFg98reLmwJduclrfmY0WE4Fh
 Gw4N7VkDTQWJNcXVIr7ebvHxFwgNpW5gd9r96SYOls80VikqII5oixFeiRlG0TvRM7gVnTFrv
 xLqyArLGzU1G0ppdHLs7D2Sq56bmGnJE5YX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Jul 2019, Junio C Hamano wrote:

> * ab/no-kwset (2019-07-01) 10 commits
>  - grep: use PCRE v2 for optimized fixed-string search
>  - grep: remove the kwset optimization
>  - grep: drop support for \0 in --fixed-strings <pattern>
>  - grep: make the behavior for NUL-byte in patterns sane
>  - grep tests: move binary pattern tests into their own file
>  - grep tests: move "grep binary" alongside the rest
>  - grep: inline the return value of a function call used only once
>  - t4210: skip more command-line encoding tests on MinGW
>  - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
>  - log tests: test regex backends in "--encode=3D<enc>" tests
>
>  Retire use of kwset library, which is an optimization for looking
>  for fixed strings, with use of pcre2 JIT.
>
>  On hold.
>  cf. <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet>

Sorry for the confusion. This patch series is fine, it only exposed a
problem in one of the Git for Windows patches I am trying to upstream.

=46rom my side, this is good to go into `next` for some nice cooking.

Ciao,
Dscho
