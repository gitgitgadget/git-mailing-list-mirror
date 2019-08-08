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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3FB1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403994AbfHHUM3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:12:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:38789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbfHHUM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565295143;
        bh=iL/naZzrtbmZxVwgLnL/trYE2ZQyadWQxR6idr1iWQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ltLGFFetVU2/fwTEl/Xs+zhvQxguiunPtsl33ss2AotOfsN6hhIm5VNfllrortKFe
         guhXxcSPV8ybqs/t8/pQ1sgspDyVmPIGoZOIU98tuthX2+jEqlipxAL+/hxswY82+N
         NLgm6Nl9s4OpAZKE6wR3gbEX149aArs3wRCAMVOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1iIacW1yOR-00wHlr; Thu, 08
 Aug 2019 22:12:23 +0200
Date:   Thu, 8 Aug 2019 22:12:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tests: show the test name and number at the start
 of verbose output
In-Reply-To: <20190805210447.7169-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908082211550.46@tvgsbejvaqbjf.bet>
References: <20190803080126.29488-1-szeder.dev@gmail.com> <20190805210447.7169-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1902135892-1565295144=:46"
X-Provags-ID: V03:K1:PP5EQCY678WWfV7WEhod6A4Ef0MLASMvgunhI/8RWlk0SB5EYvH
 zvIwbKnIMLbwIHPwY5s233YsADPi9rQEkpsaBlxJD3V0/+FPRbFxmmw65lkejVqI4+kESXT
 c06P3ACSqzqMGJHnimKhCEl+LvvLjazlrC2Zkhv4Lk2u+63ymoJYtdkCOpuURZdjAdxl5Iq
 sdxjgaLDAwuffN6FOX+5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Swc/XjZqfZM=:hqqlbormLRKiABMflY0RBt
 170Yr2F9u3HZq8ES+klg0W3wOaYchwucCONLwU2r6v4VOY2fZECZ150i3uTMIuGirjHVixrKw
 2zOAOhwFija6lFkZA3JedWm8Li+31fhE2diyPGHi8aAQt2FhTQdAR4MfodqLPEOmlZJwRfcaa
 Jo3tlAL9pduqkiMlvQ791mMyyWqSBeCLewOowD3003cxCUuv/lMZVC3tw4OodrfCFBPRbcEzS
 ceA9/MwkrWpQ2ZOqi+X2J1/oiL63vVHGQbkM4YQt14vq/e4CEksUMGGkNAKzCuaOirX3JTCPs
 vDPsvmHYQGpp/gFp8IIg63vAUN/Kuc6JNM0ioG8gnd6tHxWQAWcXwO0h/vW8s6uEojt7o1iF7
 W2lCO/a3Xw87QB39E6S3dqRHvZFIMQTvXuAqxI9QRtOjVBSTfGd5LJ3uZbzJRHdLeIqqJvkEJ
 PA7IIpN9AvzzkO8+24IG1PIN/h3U5/ayxbAWeMFxOAi8coKtAlTrhur4B8WgIt9FnrIAp8qaA
 rYblV2E38UZ8cqytcYpy1jfcMSbSkNW8/DmwPGq71sCdo5f13TSSmCPwgfj6gJWoy799HNEKn
 cKHQVUZvVFGb/vHCkaz6ZnnHo7HQI2GlBAfh9RLNvv0I4XYqZal9N3RpKCyD6ozwx0w972oHH
 ZIiUyHOfb2GDcE4n74iG7NVn7mziB6WK9McU/TN1tZT+S/3oAuItLU0PNNEPO9OxtVVtCVioH
 MMKYUK1zI1cHGD5oDgLgDwIwjqW1PU0MEedSy/oEM04TJRxG0+U2NpxnOerMWlkrwg+WTZFVE
 iS9wvfAQfPewtCsR5frpjE9Ff6uVb7OnyPBa1FZCmX+SFEDEDmibKzLMKQgLDqwRORINtSoXu
 sVOaL4Krpgv6rduOVQIwouSC7IEqbfW0gmGWeGawEZFH+QKBJ64rHkVR6BsNnLb5X/DH7biWz
 QJyq5c7lyMQb6Mam4ELS4ZK05PiFbJPhysGPfv0Gub5fGCz+ydPSBlmOfJpFz7y5KSkiaELxp
 XeF3oCah/Mkr3v42M9hYLHUjhIDymq77NqLOJGhKfhiq8OmWx2yETSGhWv4o0LX2NNEYs756j
 rz75O0oZ7lWvPwjoY9TFe91jf1uQLbrbgv6E75558Dxh7aOx3BmpBsDxKhqIauWz08HzMU6SG
 DiduU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1902135892-1565295144=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 5 Aug 2019, SZEDER G=C3=A1bor wrote:

> Include the test script number, test number, and the test name at the
> start of the verbose output of each test, to help navigating the
> tests' logs.
>
> Changes since v1:
>
>   - Include not only the test name, but the test script number and
>     test number as well.
>
>   - An additional small adjustment was necessary to 't0000-basic.sh',
>     which I thought is better as a separate preparatory patch, to ease
>     review a bit.

Looks good to me!

Thanks,
Dscho

>
> SZEDER G=C3=A1bor (2):
>   t0000-basic: use realistic test script names in the verbose tests
>   tests: show the test name and number at the start of verbose output
>
>  t/t0000-basic.sh        | 20 ++++++++++----------
>  t/test-lib-functions.sh |  4 ++--
>  t/test-lib.sh           |  2 ++
>  3 files changed, 14 insertions(+), 12 deletions(-)
>
> --
> 2.23.0.rc1.309.g896d8c5f5f
>
>

--8323328-1902135892-1565295144=:46--
