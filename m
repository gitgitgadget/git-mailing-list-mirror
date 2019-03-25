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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8309420248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfCYVkz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:40:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:35711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553550049;
        bh=Jg/QsywXlNX6rl5fAj/fa2i2xuHMK3PxiOh/IymmHDQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TsjMpl8PY7ORUepZO8IhuqbzpNU2YK16zFSUDmEPc9FnWwl/ftMZ+hSXU1yttp/hf
         +YRbu1oE1EtmPSAzRRnZChhXwRlGb0uTWMr9GnWAfkvR8z2EtVohvLntn1e/1R3fa3
         Hfi8NkPx5KRgfe1GtEvfx2f2Y5IqqLPqjjoLm4OY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmOLO-1ga1X10JoQ-00ZtCt; Mon, 25
 Mar 2019 22:40:49 +0100
Date:   Mon, 25 Mar 2019 22:40:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jason.karns@gmail.com,
        me@ttaylorr.com
Subject: Re: [PATCH v2] config: correct '**' matching in includeIf patterns
In-Reply-To: <20190324131755.26821-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903252233580.41@tvgsbejvaqbjf.bet>
References: <20190323034535.23364-1-pclouds@gmail.com> <20190324131755.26821-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1565330329-1553550049=:41"
X-Provags-ID: V03:K1:e0kCNljf7/5zH+Lg18qfMM/p+txjmLnTaHwMpht7DDz7wr0kgeY
 TUDLuAFawCUS02ovoOrZz6yX/W8nfAE+25q/q7W9CWEFwE77Co4F9bKkIQ3H24b7n4UD6Hx
 0xdukyx/mPQ8jHWxBU12c2bxrqFZRwnGpSyot8LbKN12j8foD3DBscbn/ulBux3dniy6mgi
 5lBHVzHk+bUZtugV6zc9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Usx1hBwHP8=:IZfE4UpElqyr7D/hcOBosJ
 CQYUZP9CAF9Pl4ldv7tI4aj2Y4LA/Oegsa/XFYX4sWIt/ECQAlLgDxx9TH2hKmxikrpBNeRwh
 uSSmdTiupOYtEks7UylcY6/ZFUDkO5Y0O7tSdf+ZVCxVP3mYIPY24WYz63ZvVUnf0bcugnYS3
 LwT8wPUFiKPFpuSiPmV1FreGlcM/T/uRtZoDiZWdRloCaaBVKcK03YZMmZNwZE1T+wp6a7qs/
 oB+0SxKiyb0xAsZnv0opRzaNBd1hKtMInsOwuejBaU6B/15KP0vKi32uA2SHCOOCinM2jyURn
 GHuV6BftaDDMA2HsT6GkdEp6YKWZwGBSr87DIiJGBV0Gck6NZ0V8oiRzWxQZCKZ7HnOhwjE61
 S5XkZcLfgnD3nwFMJx5nS6GRRhjB3xIs2Ql2V+1wmVxOeuC/C9bP6BLgx+7HrCP/cAwNzzNpV
 2JWXLxQTD+tv5DsB2dibjmuzeETvGCsmOc+lRCz//zUTG61WB6zn/JxR+fyB1PNz3Myx3sl3b
 dSy+f0W/7nc+39B/rDewur5pcu6RLZqymutCnLoqNIPyXIFnSVvUjD/wFrkKFgZkgLmAIJGUS
 1dPKm+kAgF0b7W4srSKEq73gIL4zyCnfnv/LMZz51dGzKdpoVjyP5AJ5ab6v7D7jGvIL3A5xe
 zvHPZE1XL/W6SfzstmmP4JDgjSnIurgstCeSAn4Thm9axAp2tNr1VFvTlKJChOhsFgy+r6vlx
 EyDOkmpwHNAMXIDPpz/ilci7mqQl+4MfUQnSWeOns77j+UfoIHM6l2Zky7j7cQ2sVxW4r+HlD
 9uwGGCwbWGmxz/0Ox0G/LFn5WOvLqpqa855bkhUxuDWZVXfnYTP+zjJ0HYGLDB8W1oR3S/lcM
 OgqYCyVnGXozOXpizi+P5iWwgnV2QSabvybk/8BuymRoCksNV3Ox1Vl9B7b9InV9TLJ4puw4B
 iADmif17ZfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1565330329-1553550049=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sun, 24 Mar 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 635918505d..4d6e70c11d 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -229,6 +229,19 @@ test_expect_success 'conditional include, early con=
fig reading' '
>  	)
>  '
>
> +test_expect_success 'conditional include with /**/' '
> +	mkdir foo/bar &&

This does assume that no previous test case created `bar`, but that `foo`
was created (which makes it harder to use `--run=3D<N>` for quicker
testing/debugging). It would be better to use

	mkdir -p foo/bar &&

here. Or *even* better...

> +	git init foo/bar/repo &&

... just drop the `mkdir foo/bar`, as `git init foo/bar/repo` has not the
slightest problem creating the intermediate directories.

> +	(
> +		cd foo/bar/repo &&
> +		echo "[includeIf \"gitdir:**/foo/**/bar/**\"]path=3Dbar7" >>.git/conf=
ig &&

This line is longer than the 80 columns asked for in SubmittingPatches,
and while you have to wrap the line anyway, why not avoid the `cd`, too?

	echo "[includeIf \"gitdir:**/foo/**/bar/**\"]path=3Dbar7" \
		>>foo/bar/repo/.git/config &&
	echo "[test]seven=3D7" >foo/bar/repo/.git/bar7 &&
	echo 7 >expect &&
	git -C foo/bar/repo config test.seven >actual &&
	test_cmp expect actual

Ciao,
Johannes

> +		echo "[test]seven=3D7" >.git/bar7 &&
> +		echo 7 >expect &&
> +		git config test.seven >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success SYMLINKS 'conditional include, set up symlinked $HO=
ME' '
>  	mkdir real-home &&
>  	ln -s real-home home &&
> --
> 2.21.0.479.g47ac719cd3
>
>

--8323328-1565330329-1553550049=:41--
