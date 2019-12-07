Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96844C2D0BE
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A0217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bZTCCW7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLGQYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 11:24:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:53979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfLGQYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 11:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575735885;
        bh=aZZPRiTO0hPGox1NAKG9VKA9ViAucHkfFTWxKTOWoQA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bZTCCW7FF/emDdYVO4sQXXG+SBFYLUPU4/JdjyL0lJOet9r+Dp7SPmqflOt+XL9Da
         WscwMIwfEHAKRq0Gr/Cww0FocAyOGBYPqOiCZYyz20A7hvqoIfEv9p7cJd+1mLY5/w
         TOr9pldPOmqjMY3VK2kaotZomfMoHh7dSNjX26Bo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1iDC3B1RGS-00QTx8; Sat, 07
 Dec 2019 17:24:45 +0100
Date:   Sat, 7 Dec 2019 17:24:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
In-Reply-To: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EaqgaPDNt/etbUAoNvqMyy7iOO8btrRqLQkwThH1/us3HrB/oO2
 nyWWUdaQjCgxCDmAcmk0PMSUxlAWb6ItxPrHsAoSeRsLIRQryypOhLyoy6f4piSUdpnPi3v
 aupSKQdKt95X5Dv4g8SCJK78fi6ZrIkbcOkquj1btRZHShszy9Bav1Dm7CpZFQkESZ2DUSb
 1jy1KHlar4kQVaBRS1pow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DkGiWe5bBeg=:5FXqEVEUdzhwTn4ibxBDfI
 EamkXihwMa8vPyLgyNl/0zVpFfhiFr4iNNSY+wl4eCepZgixnALGUBVvlemAWwm/tbJCn562T
 Cx9r58ib++VtMlFbA+al2YxE+hH4MVQanzLqbT4xSYz9Wr7yWVgsOKfgxwcMUDxNNMHKI+mc9
 1qk4T8ICMbtnN3c01AtlwGN2nwOqphta6JBMqNeJbeIt1lgff0Tm+o9Tk1nhqbrNyo/Pp/0XG
 aJQlLaemOwf/dRupYhWsliTWycOlbKYpRzVZwi+xneWD0upwn2QCbatpdxFOKe8DDt4PSz4Tt
 kthhF+Giw+ctLGoTl+7cXgDQWhg3rzQqGbVffMU50h/DIS2zV8Mth0k3EY8grsZzKdDSEfZo5
 VnqDYheVxVMNXuRt9U6nNX+EDcX0pdYBozJiyrrjwWhMBgun2FlKatpLabT0u0SlPkNY8Pd9L
 TByYUjY7FfKsQkdJJEZiyGAXpwEvmhMIYvTh2BkyNFvYzqxKKcnNuX5AvrmJWyOB5q6NywxJL
 uISsjDaT3jMptOdd4qBM0BjibHkLoYm7uLMroaj1VkP6K02W5VT+NP0xCBcxYEPTOJGQ2ga3B
 kgxZiJl9klhP7HdEXo0z2g2fyoauXznesJVHewfRvt+GiD9FlqVh35XowJpL3bn+bFyz8VcaF
 Gq8/YCU7qchZquf5D9VJyoy42KWT3h1kY2XlTXhhHxL5tJYvO9cvkFxLSIg186sKUK4mcdy4l
 gPExcVAnAnz3em2DuG+moUi0L1MCielquhbhtoblEV4kbvARWbdY6x+HPLWgdLaxpjli4Beg/
 A121pc742HEfJAzp2CRAUo5fOPwSP3C7M26bES918o0SyNOJl2U6wQwgPrUzz8sRVCZ+AAyfX
 NL+aF32xvPzqK/gOJC4CChuX62WtqYYzWnUcKvv3lWFGP1tmrZmTLmPPhUmLVlKP4zVH9mX06
 mouallo0m92oBbhFPEUPPda/1Fadeg4vHfeiwwFOVmjmBy0XYqyDBnWv5iLjr9gYvnJZz2Rco
 IE7mYlpZH7rRA0ptdB8KxlriuMOobRsD0yvtMuCrkRk5ZHPq3fa5KTb5ijAcLq3oorooBpl/1
 DZ3BIvV86UfHM+4LmfOp/HT056Jl08BjjGXYOWoVPZUhsHIjKnffJbru2qNmYF1byL65mF6y1
 oTFDlIINbqB/1Zw627AdegzxbQydcLV4VasROUsH9cuNnhWMuVH26Z7FkjPf49KdhP97Y9GbC
 tFJby36e8vdy13j9lXktI6JDsBsC4HbF5zJn91XEmQzSt/yjQld/eKwt8liw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 7 Dec 2019, Pratyush Yadav wrote:

> It is often expected that popup windows like the console window be
> close-able with Esc.

Seeing as the console windows is not your regular popup window with an
"OK" button, I could see how it would be all too easy to close the window
via the Esc button all too easily, annoying users.

For windows like the console one, I would expect Ctrl+W a much more
natural keyboard shortcut to close it.

Ciao,
Dscho

>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> This was requested by https://github.com/prati0100/git-gui/issues/17
>
>  lib/console.tcl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/console.tcl b/lib/console.tcl
> index 1f3248f..8828f6f 100644
> --- a/lib/console.tcl
> +++ b/lib/console.tcl
> @@ -88,6 +88,7 @@ method _init {} {
>  	bind_button3 $w_t "tk_popup $w.ctxm %X %Y"
>  	bind $w_t <$M1B-Key-a> "$w_t tag add sel 0.0 end;break"
>  	bind $w_t <$M1B-Key-A> "$w_t tag add sel 0.0 end;break"
> +	bind $w <Key-Escape> [list destroy $w]
>  }
>
>  method exec {cmd {after {}}} {
> --
> 2.24.0
>
>
