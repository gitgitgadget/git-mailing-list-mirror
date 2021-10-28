Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E23C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED1E610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJ1Vsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:48:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:60163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhJ1Vsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 17:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635457561;
        bh=vUcTvE59V7d7kKDVMpCPyA30nEhV64eKn+JHXNFr468=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hFLEL3ORqZY5iKyFOWW7IlVmvtUM63qy9P1Sx2Eo3SFGNZFqZ8uv//Dum7+F7niWs
         LyFBjs9h4op7wcQEVMkNoPnV44nEkRKT/5EAgOVIeBwJbRiUAIzMY0xQ7HTJmCstxY
         FioVj4hXnzhjSDXNNSeeFBF+c24CWezA5NEpm85U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.185]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1mLvDH06kE-00KNqu; Thu, 28
 Oct 2021 23:46:01 +0200
Date:   Thu, 28 Oct 2021 23:45:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, vtbassmatt@gmail.com
Subject: Re: [PATCH 1/3] test-lib: add prerequisite for 64-bit platforms
In-Reply-To: <20211028205649.84036-2-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110282344330.56@tvgsbejvaqbjf.bet>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com> <20211028205649.84036-1-carenas@gmail.com> <20211028205649.84036-2-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1414792787-1635457561=:56"
X-Provags-ID: V03:K1:O0zL4AICMTRC+n64QHcvjCU81KIN49twtaIC9GHTMuLooGf0HGV
 1Wl/wW2yNgueGZTNZuGw0bFS9zzMX2YkQzl+5CALOAtAI0BRxKX3vIpAAmo0MPmp9AHaWup
 jv5CK8Z6M591PS9K2tkFwd8J0tQ12xpqdlmw7tYztCoKSDOO842MqvDvQ0F8RNsln/FevAq
 LhyzHp1Jxif6E/EIo+5Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VaOA5loBbXg=:FPYkYSnwg3gsBIdb9r8UJu
 FTW7hXLVW0+2Uwt0QZV22MKHNGbapG0DcqzKrLvW2wNxImtAuhEKVHxHr7JQFy9KT0bB4yus1
 +Y+9XdAN1ua+h76joIHmzEoUZetEElCSR0wwcTPlIBUgkMLljaBpWV5hRZljn2dmnpe5HNH0N
 JMXHGS5gwd25WOznU2mIALRnQQn1Ix2fTxYJpAuRIlp0NlVHfnDI/ZrzVmC68nqdGMfyahPMp
 1rEaQy3fQkWD8XY8SsdVt1SGWg90StkF4jqHeIA0Z9Sr1dBLXOGBMHYtrrLnXJxTpEUebWMSk
 fu0BzyG/4w6kK0BdfuwrDC3pHBaC37kwJwNc87ohepy3IISE+BJlf2op0u+eaUHyVYk2lO1ev
 S58Wfm8WF0iCNC7wuNDWKT0u7mgANsnQsHRodneAFJ3xppELnD01lbIzWir88Ei5m+dPWXmAI
 qdmg2cbmTR3Pn+iS70E5w1zlk2x4N9fbgnadjLqCq8SJEZM9wYqrTgOEpqTjzDpULZC8oUeAw
 LqCWUAcpx6lD+eXUpo4+DlX/THI9Fl6CfA4tndwVbfYRRHOr3+zdWCL/+9o7Pu8eIEJJSeiCK
 QUgQbDBR0hmA0O46JvJWiZsYdnjCbX+YdrpZxmCAUWQ+C0sray21n4XU6Se+NFGPnSxYunEeA
 ubT8yKtcD+biIMMp2eZ63WRwJVeg37AZde/SfVshqhphydl1It7iWFXpDzZNimKt/8CZgOvv+
 m81rrfvAygYEY68lp4W2xQPccBC5rl1mSkUrz+ZhJ3UexsReDU3dhMCA4f+lFrfDwwsiIZCTp
 IsqHOOl47Y7I4T4C78n8PsMqA5ExjxOoqSfMGow4OiRdJsbR4s7l9s36n/k1uMDXHARm3f8ZB
 6d69JQw9NXkqZno1fzu0RqiaMCaRjLndhy1wjZ7HvsCLBKBm4DDPzvZT1dEiixyf+77o+I32H
 PiRoHuVeGumJrUvtQHIH4hc2R6BIdCvMuULxgQHPtUNPHoR3LUl32gaXztCWyOujqFaSqpvpI
 dal/lmtqJRWTirm62kEDnLJ5W5mHBQdfr97865IuWkdnawNbVh84xeoJ4IHflv0DcKhWYUGbj
 mcXpBdL2uAwB4M=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1414792787-1635457561=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 28 Oct 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Allow tests that assume a 64-bit size_t to be skipped in 32-bit platform=
s
> and regardless of the size of long.

Makes sense, but...

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/test-lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index fc1e521519..5fa7fb5719 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1687,6 +1687,10 @@ build_option () {
>  	sed -ne "s/^$1: //p"
>  }
>
> +test_lazy_prereq IS_64BIT '

This should be `SIZE_T_IS_64BIT`.

> +	test 8 -eq "$(build_option sizeof-size_t)"

Since this is clearly copied from `LONG_IS_64BIT`, why the change from
`-le` to `-eq`? It is at least inconsistent to use anything different
here.

Ciao,
Dscho

> +'
> +
>  test_lazy_prereq LONG_IS_64BIT '
>  	test 8 -le "$(build_option sizeof-long)"
>  '
> --
> 2.33.0.1155.gbdb71ac078
>
>
>

--8323328-1414792787-1635457561=:56--
