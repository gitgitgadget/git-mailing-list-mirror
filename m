Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F871F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfGPSjA (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:39:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:38699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfGPSjA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563302326;
        bh=9dPTrpDKW0dahq9VVPCQcXSnNdF7ovemlmHtfNh5qkk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BprSMWtdrlJl/WFtwF8dWx83QmsxQQK/DG8zrLx10lo4yrR5ekErCOJ0NYh9+NBDg
         bFOCFmNmIKfwW7CvKGwAvNkp5z6DHzs7wyvqhbop26csSQE+CX0xqh62mUo8+tHMn4
         yPtGqc5L/65emU860E5aEH6HRv0r+4ANwUv9CaBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1iEYYK12ys-00qSjx; Tue, 16
 Jul 2019 20:38:46 +0200
Date:   Tue, 16 Jul 2019 20:38:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] git add -i: add a rudimentary version in C
 (supporting only status and help  so far)
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907162037430.47@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com> <pull.170.v3.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-788669485-1563302326=:47"
X-Provags-ID: V03:K1:QY6Ai+WSqBBsCoemDMtzU9OKroHp/yinOtqEolhTSXfpbi1i3tT
 doRkmFF5iqXyRfNEiuK440445dIzkEvNEx3fUrpaAACuhcSDp3WGyjGtoD7KsWLi2i7A3tD
 fUbDadFzun7z6S4utxGWolH4bsXC+I+OgLUC8ltwrNUEmap4zpgWU+YhNiTRfBWptiFnX4F
 FP/VMXD+sJM6neJAKXIqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0d/htQzONKU=:M/Llxc/scM/TzlFiD8kwYQ
 1EO01tQr+XZr9j0fBPlQ87/mCjhdKYSb4bHiavRK4l6heI3wfwnilGM0JWtUOy2r0o1VEW1NS
 CWSIbL0Ef/U7VdpMx/cMijPfGFfeGTgvMpnbm3ASxcmS++P7hXOEJwHWUQxlsllmRWmioGyKR
 HdD3dqo20lzMBlGUETs95zAyAOYzjBLB5Qr8FQm+w/usjDR2o1j00lQ8vA/dOCKBwraoIABvq
 4T+Ofl6KChTonx9JSIKWtcmPtV8EYbSE4mrablYiYx88fpNPqZAy/5RmeoNQ169189Jl2bgjh
 15G13JwI+1N44cZYedZqymAKBJxH0jGRl7QedqR5q/Hf+/BSWsqDJru3bxkRg/MR5ZkRaHSy1
 tBedgYO3JtH40QemrFwO386ODn9F4GR3pP2OvWzdU1u3QsRAOHsg8fWRGqC0xCp++JdL+uoGi
 GxEVUi6+KNeLsFX90HrUyI6XTEUTKc/m4OvugDqjbGTkbvJz6z87F2D5ZcRLoVy518bwopiAR
 TnKGUHZtJbipRXwKCTkSizJ6asjWT3bx0B1wZFJfGqIJMQjLDhU+QyMMSeoa8Jv4S+WiroyDm
 J5FBmwXevug22h3aCLOSWyZ1uz+l6VgfzNkisJFph6y8eT7mZgSLc1jcYXWucszbM1QHxm3Za
 amyZn3orKbs32f9obkrYEZAaS+SppjeiRbgXFowMMhA8vSw1y5V8ir1ay3nAL9Icb3TtZhuAY
 aW9IJ7WtJtJ0DMmlrT5MdaSy6DYT032GFheLADrsqC/eQzaLy+Ds9MP59EdSbQ38QF0XpnnzS
 0/WqcjshGvyqMU3fifrztRKV2nYLmxiMj3XkexSAcFNGajj0F+5+WDviIzH7dwmv+0HZeiZ87
 d3tT9X5uUjOOZtQNzesNKmxS3HOFY3Uje93650vUPyDv+n6hF4Q52MGvNr30TeUYDO5GP+Z0x
 sVKWq47bc46eHz4xruLQr1x6lwqIbAovId9VKJvFJ6DQ1cSJg/kd//08gcwxAsXI32rhaBNoo
 Cgvd7UNcdTgk5ns3Xlw02KtFGJ9xfrrtWTHSA8Z3Vk3Vaxsj1m4wAz6has7hCmCYAo/GV0qnz
 ei3bCA9j/Gu9gqg3KhvojprMc0tyrPOWT/F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-788669485-1563302326=:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,


On Tue, 16 Jul 2019, Johannes Schindelin via GitGitGadget wrote:

> This is the first leg on the long journey to a fully built-in git add -i
> (next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
> [https://github.com/gitgitgadget/git/pull/172], 4
> [https://github.com/gitgitgadget/git/pull/173], 5
> [https://github.com/gitgitgadget/git/pull/174], and 6
> [https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs ar=
e
> not necessarily up to date, and will be re-targeted to the appropriate
> branches in https://github.com/gitster/git as soon as Junio picks them u=
p.
>
> This here patch series reflects the part that was submitted a couple of
> times (see https://github.com/gitgitgadget/git/pull/103) during the
> Outreachy project by Slavica =C3=90ukic that continued the journey based=
 on an
> initial patch series by Daniel Ferreira.
>
> It only implements the status and the help part, in the interest of maki=
ng
> the review remotely more reviewable.
>
> As I am a heavy user of git add -p myself and use a patched version for
> weeks already (it is so nice to not suffer over one second startup until=
 the
> MSYS2 Perl finally shows me anything, instead it feels instantaneous), I
> integrated these patch series into Git for Windows' master already, as a=
n
> opt-in feature guarded by the config variable add.interactive.useBuiltin
> (and Git for Windows' installer is prepared to detect this version and o=
ffer
> the option in the graphical user interface).
>
> I had planned on submitting this before v2.22.0-rc0, but there was such =
a
> backlog of builds from a big pushout that I had to wait ;-)

FWIW the v2 round has not seen any objections...

Maybe pick it up in `pu` this time round?

Thanks,
Dscho

--8323328-788669485-1563302326=:47--
