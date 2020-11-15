Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD54EC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3B221F8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BSnYvNqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgKPKZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:25:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:60973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgKPKZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605522315;
        bh=TWgoqFsW6qPp9zA0Zxzav1d0JBxyZy0nnGSfI6uiTmI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BSnYvNqGGJbEayzmG8kjWWWhhxsCgJfmzSJWkBt3Yn0gRpzY2peSJx9CTnGc0DNZA
         8UZXeqKk/65H8KrTy8xFXKme5QIibd2BVw1WJ5HIUHUVRX4NiRgP35n6THleZZGAHa
         /iV/5M90WD6fN7FwBH/8mXEYklzorlgOOCP6DVRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1kwgoP2qEY-00JJXy; Mon, 16
 Nov 2020 11:25:15 +0100
Date:   Sun, 15 Nov 2020 23:08:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
In-Reply-To: <20201113215307.20855-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1867396044-1605478122=:18437"
X-Provags-ID: V03:K1:Ma4YZqV7rZitCmmyqeGdWolrhMFedP5xx49YwAuKVaxjNt0Hdrp
 7A2ygF1LMax0pBh7sXpZiinyzW2zWv2FSiaOZ3E4kaeEj54N99FSL9qp2/BsC4uZOmF8fFD
 xUQvimHg7OOqpp/oXhjtBzvp/vdwO1Fm6qXBWvnEXG+++Uq1UICO/QptoAXb+8lG9Chvaqk
 xZaeL9Jg0LjFG1Cmofmbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L+V2E64xQeM=:JLHU/pqzSuP8BdejEIWrpP
 p5gEkQUZVHxaOwgIVsIGHBOuh624C6X4fPYqF1RouUNZL41y9+e6g27i2b9a5f7NL1lajZpu8
 82qv4EkxbbabOzYY4Fx+r/saXvmi4MusU5HAiQNZAHJnIo0k57XcfjDsg2Bs1ilx072MuaesY
 l9yDDUln+mGyHu+2hJ2s+ZWU/9IgjhXeWSFmd/xde/U3CwBe5/BXsMsyuuz9FK6f7omEMdfZK
 +bEMky9dYLH/k3LOnDpARX6sIVT77yXCL0ID/16jliYIi9T8B2+n0cG2IC5iYU9WhCeIceENG
 vFg27mWnVJMo/ohjFuS80XIGx6L44Ew/bf+tOlRaAZ5Hwzx7djhOMYHfSROhoC3HgeAInUGJ/
 1idTxlsesXY8Xg//HcVpvaul8cmBBjANq1Ve9ftxoR3AKZ3WSs4Z9H84V8asnoOLN63scJBaS
 aJuvB0CQnUQqs1P9slwCwwpmqt0tdjZtJKqsmdKKPADdsQW16ncYTx+ajnWC77ZP8+Ls+uPfh
 r6YAdEdRNqakCi1TgzfphSfJ3sjPKdVtfxRh2+ixvFyAtLTl6I5vfiv6kl3ov0lNIVaayysrH
 xU0t2XA51qQ0Uvz/N02iCLzuoopmsihxQDnu+DsidZtKdspYbF1j/z1e84qPAz2X7gKLWNlCR
 WgUlDTb7h9D9ntMIulqMtW4o59Pg8MvN6g0GT7Gf5dmehR/HSZAL2sFqNvZH/O/xOXdWsxHNT
 TRh9R0yPcJnM2kZNWfu16t3jRqeQTFfLarG4+1ZCy/y7TEzPIv3hXFV53xgsnm/O/kNsrJFnH
 /JKSc8Gil7TD0qTTPlep/S4u7nwbAJaIazhbVhiOju2EshWt6k/ZGOE30bGhF2NQc888V8iEY
 tSTLk2GiWBg7ciDBEa7UHrMWgRxxMFBQuyq8yirrg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1867396044-1605478122=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 13 Nov 2020, SZEDER G=C3=A1bor wrote:

> In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
> are compatible with JGit's bitmaps.  Alas, not even the most recent
> JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
> test script is run with GIT_TEST_DEFAULT_HASH=3Dsha256 on a setup with
> JGit installed in PATH, then these two tests fail.

I wonder whether there is a way to change the `JGIT` prereq in a way
that automagically will recognize a (future) SHA256-enabled JGit?
Something like

test_lazy_prereq JGIT '
	jgit --version &&
        test_have_prereq !SHA1 ||
	test "$(git rev-list -n 1 HEAD)" =3D "$(jgit rev-list -n 1 HEAD)"
'

What do you think?

Ciao,
Dscho

>
> Protect these two tests with the SHA1 prereq in order to skip them
> when testing with SHA256.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t5310-pack-bitmaps.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 8318781d2b..1d40fcad39 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -277,7 +277,7 @@ test_expect_success 'pack with missing parent' '
>  	git pack-objects --stdout --revs <revs >/dev/null
>  '
>
> -test_expect_success JGIT 'we can read jgit bitmaps' '
> +test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
>  	git clone --bare . compat-jgit.git &&
>  	(
>  		cd compat-jgit.git &&
> @@ -287,7 +287,7 @@ test_expect_success JGIT 'we can read jgit bitmaps' =
'
>  	)
>  '
>
> -test_expect_success JGIT 'jgit can read our bitmaps' '
> +test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
>  	git clone --bare . compat-us.git &&
>  	(
>  		cd compat-us.git &&
> --
> 2.29.2.612.g41c40d3f73
>
>

--8323328-1867396044-1605478122=:18437--
