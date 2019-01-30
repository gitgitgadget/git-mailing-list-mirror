Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7B81F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfA3Nnk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:43:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:59775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfA3Nnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:43:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1hQ5mL39dA-00bXWP; Wed, 30
 Jan 2019 14:43:29 +0100
Date:   Wed, 30 Jan 2019 14:43:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 06/13] Set Apple Git version during build
In-Reply-To: <20190129193818.8645-7-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301439440.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-7-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y9H6lsGs2XLZAZjsJDpsfmAZGqPYBaQqGyVpgj/4sRH3ppFfSPQ
 IEB++KM8ppGc5KpBC3h6VJ+8Nkl3dnqDwrRP/HI+iMcoysDQOL1hvkZlLcfHwaGmm2oUxPK
 kWFzpDzNjRfaxqU5MEC/ywqsezhxf0V+jySQt8smNoYOcXde8FTGGlgJAn9CyD8c6ZylLxW
 8fI0++6U7dsXgYTLV1p0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KzhfcW6bFto=:Sgdd4cyvgUhuEU5rD21Y8s
 Y1QKwl73HBWtB60+LNNDjB+2wQst4KMJ0S2gRTs2g2JLUiDoddD9vdGYS85R/A/vGXWsRryip
 y59IhWIeAQpRwmvBAMVlPcarO8jmiBJzrGNmwMjFVEYxfM/BRUVMuh1NV8w6HKvw45VH7Bbqx
 LPzw2P6NIfZ4kt5jW83WjkXKRRHX+phX0mg+qHTnkIjQ2RO81r9KynjUbyGVQZG1hsvAlcaFd
 Ur58rsVC0+p8//iyfce+8vmuMIPKjhoy/id0R8i2/LNB3gaMmsYMnJHgGyZ0fBmuiFFIhlPDt
 /+iVpqqbx1GAcyoKFu/3M/VDdzXg/FklRSHrnNREm9IV6Wy96JIxsHWqsnlyb27sZ0ppvg1io
 ieBS+LDRBgZf4QM317dYR2E0mtK8edjwugptH5TsTrUb7WRRpFxzQ3R61oRgk7CXFKL85QLFL
 DiFYAOwPBzbRTN5rOR56dzDzhE0g95GKPpon6v0koWBN8kdpVesoDpBx7F27Ku+yL3vvl/RT7
 gMT8aHZGEsFNIJ+F/6ztXetICGWNNj6Ky1isDnI0FocOEJD17LFykGbnu61VDt2S2Rpvv30lR
 UfVR5uxguE2Z2Psu8mKt9nxvTUk0+0S5LTcRZUoqEwsjBd5hajQn9QQDq3Ad23WqqFZqd2jVq
 EAPoGg3qrVFF+fi8gledyeSmsI5WbnY7pE1tnMGSCS6u6qDThuepHnjN7IHtKgQnxsXXfRI/n
 W4+LvNoVN7RmAkGPU9y2v6EbDAY91vRhjCQxehIvXLARX+IL+XdNITD0mUEGo3NEFV7CT3iwU
 0bX3JovHCENd49ZS5odnVVPgbbbXQWlJ4BF9jzJmhcIIfjOap2twdQv+7Bzo4jHeJPfF3+LeR
 f62lylzyLh6Kkhleg0EEmni+TjBEo2xxdNZLzaSkZ+uOgNRSYC0yRpZqzHoUtLAuuygScv62n
 +++qIhxM7hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---
>  GIT-VERSION-GEN | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index d1a2814ec7..6fb90854b9 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -3,6 +3,10 @@
>  GVF=GIT-VERSION-FILE
>  DEF_VER=v2.20.1
>  
> +if [ -n "$RC_ProjectSourceVersion" ] ; then
> +	DEF_VER="$DEF_VER (Apple Git-$RC_ProjectSourceVersion)"
> +fi

This seems awfully specific to a very specific setup. It won't work when
building from a Git checkout, either, as `DEF_VER` is not even used then.

And the existing facility is the `version` file. Since you want to build
this in some sort of automated fashion anyway, you should probably execute

	sed -n "s/^DEF_VER=\\(.*\\)/\\1 (Apple Git-$RC_ProjectSourceVersion)/p" \
		<GIT-VERSION-GEN >version

in your automation script. As a bonus, this will work with any unpatched
Git source code, too!

Ciao,
Johannes

> +
>  LF='
>  '
>  
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
