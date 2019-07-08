Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9231F461
	for <e@80x24.org>; Mon,  8 Jul 2019 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfGHJ7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 05:59:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:52635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfGHJ7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 05:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562579975;
        bh=iFw6JNxfIJXsqpCvJz2Oewp/gYY+Pza4daKi1ty7WMc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GW+YJNIDh4McEF/9msN5lB/TmWZfn2hKmXl8z30+6PWJbwzlkCmGV1nmdtgVGF76s
         0iWULCZfXa3W5lRSf78ZQKREG7mVFdDLCH4c/kuLAORNK3JtGMFtRCoz8GhSG0B3ti
         36F0vtgtXsMPiy7CkkE1zad+GDwdOHAvZUi1PyJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1i6CZz3Js9-00MJ8L; Mon, 08
 Jul 2019 11:59:34 +0200
Date:   Mon, 8 Jul 2019 12:00:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v1.1] ci/lib.sh: update a comment about installed P4 and
 Git-LFS versions
In-Reply-To: <20190706162114.21169-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907081159520.44@tvgsbejvaqbjf.bet>
References: <20190706161648.20836-1-szeder.dev@gmail.com> <20190706162114.21169-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1757722204-1562580009=:44"
X-Provags-ID: V03:K1:HjaF+um6W+ASjbCdkoNqazAvBhstwzBSr5/Tyr7SvX+cQrWufTM
 vpY2QFZ+etbYE7Cs2D2XCQa8/+LIhuPFiIk4HEenNz7Nwik3y/bUaiAMYCpOwFkRYKjw0HK
 NWflHkY4pRzlVIQMsH3Nz3F0wMSEJVu86/dZSCME7wTPy0GcNCNNewTjb9eLCYo4vC+lf7M
 hRgpUlVwanVnIrbVZrphw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXsgDlr+e6g=:1smhQ+Hxw9M0Oq4WoX4xp8
 jYH95NTeebX1To5BN+pj+oe3g7H7hGQiPK/4byD7Cfu5b2iMUL2GOduKn2UIawUZGmcdWH4j2
 rc5SpA9S8FSFwLriL8hIj4OtCTV3q14/gpGXhqIVOYq6KRfYbn02VgkmSnxFF/LMBA8xxh/h/
 WdHZPtBbJX4y9AwmloznL/pC3g8G4IP1kCcizS5Jf7jPJ9ZgYDJhqGbNgZ6I7D9x82UxIEkm+
 18iFL0x/EFWVc0ZsGN/8ImAVEojDQmNSAMweO57MapyUgwZPlrshZeGaTbn4u362nu6SxfsLY
 3iNfoPOxfmgTl25fyGLskUyjwTEElClFHMcGrEuvnw2Q6eN0y/OYsTHWO0cQ1/HsgLcO38dmC
 4xWK8vP9XeuUWwXV+YZ5LknIOJ+BuTTQCiqkYt1Pv3AegH5tpaQN7Ym6QxJEsQjX3Yno3b06B
 J/k9lRazbK0003fNXGmlJb5wm1yi+Y0WXwlE8KlV2ufm8oKCWwMHe2FBkxZV12wvXKBKUscrl
 QJP2coAXZALwdd0bopFg/lFTsp+G+CFgc41sKpf+WKtDETboELPECRzv8/tefI6BWyWyG+jmB
 0LzUaDJjh7AyJnT9wMmADoGiu5+2UlOL9Qk4Wq7IB8BsRQgP9XEgP4N6vYl4oA4ugyDIyu8Wj
 gccC2B9sE+8k4X2vK7tsQd0KZYCVI5+De5rGI7ABeIH5Bpmd4rGe68kelCsPzUooxaBv4f1T+
 YIaVNro7ZY+l8FIzW/yDCIdTdyhuuHC0LDhAfis6l8BlhCTM7BGMPpmg4upUJOyp36+UC97G9
 W6hwRMsk/nP21DznvVE/Fpvdu0+ubMqGo/tL9UENaygFVXGpnZ5G8UOKU8MSOWourAKEIwa7n
 uzaUy5SkkroK/mk9QrN3e6KkOG6ARzVd3jArOdvfPv5J6bbA+Y56u4AjbY5t5QYn1P57ET4xA
 R97IuR2KWVUN+bO4POIH/c2A+qnWAy8y/HRIIHDpENd3ami9qkRQU1JCL/yBBiuCmClnF5RTr
 v2bjTo7+1hHlxX9kHqGHK+7E/+Qs4JntnOc1HmDm2SC+YPgDJA8jMaKcRk00QNsKh89UwrO6C
 pZcFG/e5S7G7bGOyPENrNlV46hJk/3A2u5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1757722204-1562580009=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 6 Jul 2019, SZEDER G=C3=A1bor wrote:

> A comment in 'ci/lib.sh' claims that the "OS X build installs the
> latest available versions" of P4 and Git-LFS, but since 02373e56bd
> (ci: don't update Homebrew, 2019-07-03) that's no longer the case, as
> it will install the versions which were recorded in the image's
> Homebrew database when the image was created.
>
> Update this comment accordingly.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

ACK,
Dscho

> ---
>
> Sigh...  Same patch as before, but corrected a grammar error in the
> commit message.
>
>  ci/lib.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 288a5b3884..0c7171a173 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -163,8 +163,10 @@ linux-clang|linux-gcc)
>  	export GIT_TEST_HTTPD=3DYesPlease
>
>  	# The Linux build installs the defined dependency versions below.
> -	# The OS X build installs the latest available versions. Keep that
> -	# in mind when you encounter a broken OS X build!
> +	# The OS X build installs much more recent versions, whichever
> +	# were recorded in the Homebrew database upon creating the OS X
> +	# image.
> +	# Keep that in mind when you encounter a broken OS X build!
>  	export LINUX_P4_VERSION=3D"16.2"
>  	export LINUX_GIT_LFS_VERSION=3D"1.5.2"
>
> --
> 2.22.0.667.g5c3548c1fe
>
>

--8323328-1757722204-1562580009=:44--
