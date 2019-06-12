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
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FDF1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfFLUAs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 16:00:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:56989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbfFLUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 16:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560369641;
        bh=U84VquVYmG8Gm9ty6DY5RDK4glsyspMVk2uVvXbaYgo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cp8IfjicdwMgn9+jSD+cCwjxSmZRRrRM+3M013gpiPiZmXuM3LyRt/s68+i0rSgtV
         ES761OrIenKprl8vhgHpd1kMYyyf3JrdJa7gvhtS5RYytRt2AXqfE1GDXVd7qG4RTJ
         EvNk32+TjTJmUeO2nEFTSa2ueAQFyOJdizYDI8Z8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8OH-1ih9Av3zGz-016g3R; Wed, 12
 Jun 2019 22:00:41 +0200
Date:   Wed, 12 Jun 2019 22:00:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] progress: use term_clear_line()
In-Reply-To: <20190611130320.18499-5-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906122158500.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <20190611130320.18499-1-szeder.dev@gmail.com> <20190611130320.18499-5-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1899841153-1560369641=:789"
X-Provags-ID: V03:K1:+3U+KP/iFlwbIQALUH9wSIKkUCWzVAKlhTPDDQdNYqON4xZoTmt
 2zcsJHcWKbkBAkyfgm96+yBgQ7U9TcCy/FBoAWKTtkZCr9JPAFgBD8VFembJGoDzaky75OV
 rQo6hab9RWxNo5cBcAGbpKk41sXAVE9Z4YogypMS/rLm8Oxf8NOs41BMWaf1I9aJZP3XOKf
 vg2x/niBn5hOiuZI7G7Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0q73BzlDlOo=:BioP9X0VWd8kZ1Z+9wYqhO
 ihN8bCUhwaY6muDY55ueG1Sz0bgzuYc+4CItvcUuveOF2ipz0i6UwY49xl4y7Gx4c/HcnDe+C
 5AHyaq6o3AiLJW50jqmz6Z1H8CX/IXiVUPuxSO2rvHtEmKZlYcOf78bm0MfTBAeB7M09p0omd
 fK+aRivefZLw+o58UDglLFruJlnlP1pgjfMxIk659gUiVJ1230UBmeuPSk8LB4C8IfbFLddpQ
 r/OHKumyVY3b2HCY34QqrBi9uSiLCWqOfC7FB7VU0lVTLH9SVSK9WH1Y6qZ4xW1PlQMAsBjsr
 aRGOOHae9pHgNG8bqWje5MhUKurPRayhWB3zXucC/jeq84ANuSJ5R3WStmCFK4hudnza4MsIM
 hDgxF6OnWjPmMEB7Zw6nPJoTJ/I/r4zR8BnzpuJb0kpVBQ9ad6D2G71r/9zESgh2L3ymXyfTy
 jC+aTOz73pm4UdA5QdwvCn9jDcx1kHbvBgi0xyJW1Vag8aRJ5MBYsUDdwRPQJojVYSTeOCE3P
 ObIe3Z7/maPC0RcO5mCZ3HkZp3Z1pOXWLvXhhxLOoCNvn186V0/94SCG61bx8O3KOF3EYPRXy
 OqhPrXdaNGvMfWozlfF33ux9nDDRd4QAvjtlNn7BxiqwCVMSU8y9+dCwLCpQ9pYzNSrmv8qGp
 /MTCjXgUzPIQIsGkkh8qjUypzF3lCR5q21prre9005QUUE8z6XGFaJANMNi6uxWtbxkQhkIS4
 fGWy12vSsRBYywcAGGOFpdq4Zb+d6HDy8QjaVmf8XqcrpziQjDqneemKhC033rKuVQydoBvdW
 LdEmjWq1o1rUejfKO337VuB1ZNbEXmuMYWSIzQV6pnSgXeGK2pu3ol9i+/q1XFJs1O4z46ap5
 m8N01Df3KJN9RlMcKHoTSfDI8xyfoUNCjkYvpBn3RuTXdjd24nutjUbZDsYR00wU2ksCn0AC3
 c1dLGnWOLn/6mPCH7/kYuzf4nSx9ZBu6mcfaj8q2gYGp6yp62tC66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1899841153-1560369641=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 11 Jun 2019, SZEDER G=C3=A1bor wrote:

> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 8ef8763e06..2e4802e206 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -213,7 +213,7 @@ test_expect_success TTY 'push shows progress when st=
derr is a tty' '
>  	cd "$ROOT_PATH"/test_repo_clone &&
>  	test_commit noisy &&
>  	test_terminal git push >output 2>&1 &&
> -	test_i18ngrep "^Writing objects" output
> +	test_i18ngrep "Writing objects" output

I guess the problem is that now the "Writing objects" is preceded by a CR
instead of a NL? If so, maybe the `cr_to_nl` function could be introduced
into `test-lib-functions.sh` and be used here and in the subsequent test
cases?

(Just an idea, as you seemed unhappy about these adjustments according to
the cover letter.)

Ciao,
Dscho

>  '
>
>  test_expect_success TTY 'push --quiet silences status and progress' '
> @@ -228,7 +228,7 @@ test_expect_success TTY 'push --no-progress silences=
 progress but not status' '
>  	test_commit no-progress &&
>  	test_terminal git push --no-progress >output 2>&1 &&
>  	test_i18ngrep "^To http" output &&
> -	test_i18ngrep ! "^Writing objects" output
> +	test_i18ngrep ! "Writing objects" output
>  '
>
>  test_expect_success 'push --progress shows progress to non-tty' '
> @@ -236,7 +236,7 @@ test_expect_success 'push --progress shows progress =
to non-tty' '
>  	test_commit progress &&
>  	git push --progress >output 2>&1 &&
>  	test_i18ngrep "^To http" output &&
> -	test_i18ngrep "^Writing objects" output
> +	test_i18ngrep "Writing objects" output
>  '
>
>  test_expect_success 'http push gives sane defaults to reflog' '
> --
> 2.22.0.566.g58873a45ff
>
>

--8323329-1899841153-1560369641=:789--
