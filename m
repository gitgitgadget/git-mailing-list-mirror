Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6708720248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfCYV2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:28:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:51833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfCYV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553549318;
        bh=qp979Ax6sbnkWQ9TCsBKIx0AFMsIyTxUnqyGksVQJxc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QMkIDN3ZbANlDHiBWDlGiChrHudb8DEzgyBhDpFtGOtpOsvdF8BncxaiClARGtjHt
         k1dS7fW/DCbyL+SSNVJBrwhAiNtUmIZW9u+rABCHWA32y0Aa0ian8UihQddOUfwHgo
         iP6oeYPuzFoTLssy6wXUVkQwNHefw6AF1DlmF9tM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1hLgJi1DPM-00M2k7; Mon, 25
 Mar 2019 22:28:38 +0100
Date:   Mon, 25 Mar 2019 22:28:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] ci: install Asciidoctor in
 'ci/install-dependencies.sh'
In-Reply-To: <20190324215534.9495-5-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903252221300.41@tvgsbejvaqbjf.bet>
References: <20190324155219.2284-1-szeder.dev@gmail.com> <20190324215534.9495-1-szeder.dev@gmail.com> <20190324215534.9495-5-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1283931657-1553548921=:41"
Content-ID: <nycvar.QRO.7.76.6.1903252225480.41@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:ib3NfWVYK9rdNIUrhyiqqEM0iOjabxIjG749EeHnXBcJlbp0NZ/
 2svKaq6l+7xrcy4zVkAineueCEA2Y88KFCZlbN5dakNskAaX0EfsLm2kS1uYdz6E5ta+oCq
 V3IIC8VFWxTe5PUgPNUv5ygwU30R2OLTloQ2bdM+G3OL3j2dTqq/0YUG3k+YKWMXZ0WCjyh
 jtlbZbihCikwkNvSK8K+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g83NL9k+s/0=:tcnBewnBFc0UVrxlU3QK+S
 KATJ7loVYB2BmJA1bz2kxSEVXzvwASZ9dxthAgEmuIrSFmBXnpdWf/3ZMZmxVmbncKb0TWJTG
 A2SNh7bPkPzwui+wyCf//qbl1MWsCII+g1vcm7QtOq6zC19qNcH/aeUL5DXHZJLaagRYfe6ot
 tgUdm0hMmYvUC2R0daIcNqdLOr4oRDZX3rtL9fMVTq8qB0YoumS8IeQyoVCQtnZZ4TYP4gQmc
 iTpMDCmOuE4Qk9BeBT8f8sAK2c4atguXNsRMYuE4yDos03XAsvnDpzykcwXVR6PM1JiKv0AYg
 ijvcitnBRIzlveyM6t8jIy1ffwSi2h3V/UwFkHHAaFCj+0Ojqr0dV1z4nj9G6Rv2dS7wmReQS
 ZKI/kiCbkNs8JhbWQx5P1cJfuYViVmtao3pZizYSWNdMnvvjd1Rr1JrNZiXqT3otLGJ7bepXt
 SM8Smdqa4Wgj+CVVYpPeSZvaeDs7eKz34gLE4Wd+10ea3LXzYTo1uyV5+Use2pSodKVPDUjiz
 w8+ybacYg/S8wD6q4Yv0jWIZnfwEHh5yguZiWDm+4YRRYJKxe3XU5EHGOyioZJP4ZFMnfANio
 YCjx2OxBbYNxOz9waQZ7z11pD9JyOPifs4x1+7E7GDqNUyOAoYrsQwOsEONUdZXBGFRgeenTx
 WmL5xxQHzNOPrFfl2/R5znlucTG0NACiQdhfoHLET2hSsFNJdMw7ONKwt5HdoqPbwd39exFv3
 EBPcu4wOHkJGD28XX16hOgduXk41nIA0SeELB1VahSxqltVwZTdHXCyaVBcHCXGZU+9Mw9h26
 hVRh2tgv5ZGmjicJwCIaIvtHsRLjb50y1aj8v5F0kMN3Dli+JGTH6NtpWJpw3lfmSEXHOhegT
 qPZMZg9ruVjfcnX7wGAafKGzy2Te0GL85fV9Qfny1sRddocqatstL5ED0F1/wA2dAkalg/7Xe
 kHbcm978kMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1283931657-1553548921=:41
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1903252225481.41@tvgsbejvaqbjf.bet>

Hi,

I like the rest of the patch series, but this patch, I am not so sure
about...

On Sun, 24 Mar 2019, SZEDER G=C3=A1bor wrote:

> When our '.travis.yml' was split into several 'ci/*' scripts [1], the
> installation of the 'asciidoctor' gem somehow ended up in
> 'ci/test-documentation.sh'.
>
> Install it in 'ci/install-dependencies.sh', where we install
> everything else.

The big difference you introduce is that asciidoctor is now installed
with every job, not only with the Documentation job that actually uses it.

Even if it affects me very little (because I don't pay much attention to
Travis, it's been too flakey for me, and it does not test our Windows
side, and it is too slow), I'd rather install asciidoctor really only when
needed.

So I'd like to recommend to drop this patch from the series.

Thanks,
Dscho

>
> [1] 657343a602 (travis-ci: move Travis CI code into dedicated scripts,
>     2017-09-10)
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  ci/install-dependencies.sh | 3 +++
>  ci/test-documentation.sh   | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index d64667fcbf..76ec308965 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -54,6 +54,9 @@ StaticAnalysis)
>  Documentation)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install asciidoc xmlto
> +
> +	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> +	gem install asciidoctor
>  	;;
>  esac
>
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index be3b7d376a..8f91f48c81 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -5,9 +5,6 @@
>
>  . ${0%/*}/lib.sh
>
> -test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> -gem install asciidoctor
> -
>  make check-builtins
>  make check-docs
>
> --
> 2.21.0.539.g07239c3a71.dirty
>
>

--8323328-1283931657-1553548921=:41--
