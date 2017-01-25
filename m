Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CF31F794
	for <e@80x24.org>; Wed, 25 Jan 2017 12:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdAYMed (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:34:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:53232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdAYMed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:34:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1c3vnE2BIn-00kgOK; Wed, 25
 Jan 2017 13:34:25 +0100
Date:   Wed, 25 Jan 2017 13:34:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701251327090.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com> <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701090825510.3469@virtualbox>
 <xmqqh958y44c.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701091207480.3469@virtualbox> <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:faFUGdC8LaECBVyiXQGheMzqCdcR6a84PSwaW/9L2CxRPy0n83T
 WTWN2V84AgABmuLMxKtY5ZBe3VHv4llpheGnzb8SLx2t2v5z9wCxgxVObUiUVWKYcYo2VSI
 ycLPWjwcoRc8evDzv6Jd7//PGa2PcHLlMLElVV1GNl17TYi3zuR/mNRKtEyDIxVhOsIdTyM
 0rAScx54IfRSuzzlhGyKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TGoC6XJe3MQ=:hY8TmzV696FkGr8Qh0orcC
 193U8qEUxbVEdPZA9MTY8p8PU0o/bM5Jnp/2ISi/mrPslzQ1J+Un+M5tKtaSqJsFitKsyDKkE
 QExjr6FYwVplUL+WrrtJ0W+WuSHtaG9ZU/m+pdYtkpfUq4e6PElCFnF5X514w7v3CoqGoRULa
 ELiip3wLdV9dGLNk2YVSQ0aoMxIyuv9C2xZV3heiWgNfOyWqdgxCEm9lfCJhdTtcKL5d2REw0
 O/RyAzXS9hCcrG0U2DaUg1LmXTVuqOdo+gRnLx112xYGFp0aAuFPnFxfugyedEMPiY0VWN4SO
 RtZdQEyITJrLHNWJoSPbe5e4Mgb8p5Z3syyytLtzxMqPweOozWHABXJUuADJqD2O84QIzNcqi
 8ekO89ka53Jh6NW0ZntdVrqfLQxj9b60Q0pwP7K3l6B+S7ygvUAYtC2KNB4MPFZnhWXgS1JEg
 aap0qbzW3cglEtd1cC72qwyBMQtxDDzxs2P4/r6XZ1h1+X17odewoxD57Xe9Zi2U7JRNOZlyQ
 5MuaJUaFjNwnZu4YU4+2UNpXzeBmJHasFSkaJQKtOXer7RA5jHoY8JTo5F7KwbENUeOXUmOTl
 A5ZQcTJeDeh9DKt36+MauCb+XTxVYGuCYCOU5D7KJmAYnD4VW5gxdvXEwN8J33Rv6/0r4Fd1H
 jFV3SpkEroe5vRg9lyMG8b8ZUuOQtoQ3QvMTiwqaVsnfajU+73CIc26CX3Ewyak05fOe/ACUg
 OPTThvDqyZp1n3zrug7qf/prZO2KsgMvpuB5Gr8g4v6g1m3+5UZCrzdG0sU1jSXji9W/+t2F3
 CAiKm41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jan 2017, Junio C Hamano wrote:

> IOW, "give an escape hatch to override auto-detected tortoiseplink and
> plink variables" suggestion should be taken as an "in addition to"
> suggestion (as opposed to an "instead of" suggestion).  I was not clear
> in my very first message, and I thought in my second and my third
> message I clarified it as such, but probably I wasn't explicit enough.

While you may not have been explicit enough, I was not smart enough.

That escape-hatch exists *already*. And it is exactly the thing that you
mentioned earlier as a potential source of mis-identification.

Let's assume that you want to use a script for the GIT_SSH_COMMAND that
eventually uses PuTTY, and you call this script "junio-is-a-superstar.sh".
All plausible so far ;-)

Now, with the patch in question (without the follow-up, which I would like
to ask you to ignore, just like you did so far), Git would not figure out
that your script calls PuTTY eventually. The work-around? Easy:

	DUMMY=/plink.exe /path/to/junio-is-a-superstar.sh

In other words: the thing that we thought may be a problem is actually a
feature.

Likewise, if your GIT_SSH_COMMAND looks like this:

	THIS_IS_NOT_ACTUALLY_PUTTY=/my/window/needs/putty my-ssh.sh

... you can easily change Git's mind by prefixing

	DUMMY=blubber

If you want to use a script that decides itself whether to call OpenSSH or
PuTTY, Git should "stay dumb" about it, as it will not be able to tell
beforehand whether a port argument should be passed via `-p` or `-P`
anyway.

Of course, given our discussion I think all of this should be documented
in the commit message as well as in the man page.

Do you agree this is a good direction to take?

Ciao,
Johannes
