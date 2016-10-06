Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B99207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942032AbcJFNmH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 09:42:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:64616 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941990AbcJFNmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 09:42:04 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsxuQ-1auJJn0qL4-012Xp9; Thu, 06 Oct 2016 15:41:49
 +0200
Date:   Thu, 6 Oct 2016 15:41:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 24/25] sequencer: quote filenames in error messages
In-Reply-To: <xmqq60q26mfw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610061541300.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <db1816339ba9e259e929a45d644c33160f57c5bb.1473590966.git.johannes.schindelin@gmx.de> <xmqq60q26mfw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WjY0fRb/Cbv1t8iA/z4zR9TJdpOigaxfXPrpndch3HhXq91woom
 fRWUZKeOYmSLQR2p76Ir68pWiMMYdnsLI0rEnMOHXPP5vc5Pcm1LmcLBtHpLj745zqXyYHn
 dJ62i5TSh+0vXeT3lp0FXAf/PVDziGa6Lwe4UcTkFsDbCeBe5xVZbCR5Nb1/ZZMFW84syeL
 M/YECZUxqMwmpLrvVJr4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B7vCS4Cw728=:+9x6fhK8jPSjmVQ+tq87ud
 G9MMKq1ZDryWpDfxtRm89VGXqi2CpneAdc9HDWQeBcQNwF61Xym410nGa0QVQ5EMq0QDP3sPf
 lSWwqK0IjGZVlDUO4F97fggWcZH8KX8iayUhXYYWXKjNpT0Xlmg9hWzEBJSovyQBUG0WMDxCX
 L4ITR4ZDBySrT3wHmvd+EGUQEF/y8lGrIB9NqSYYUQyRa/9ZJjseSsbiW8PvbVsj37U0rS4hL
 o9dGS2HeNU5KifshjTToTqb6CYpdetlFBwjccDrHhdByOYU34Fze0/Z63K4gUTvxSBV32Eud3
 LGSoh5eYs3tE9jOSMcJ3wlEGOjGA37XDUgsRIEgIOB5bHS3mp9y5tJiwIN7bsskwKcLUOv5dw
 rzudZT+DRHoZJDpgRe05iEZ7wDtmoaZcI3rolcRahuhEJTSn/zOmelF4ZPMFl6Ej+cPr2W59O
 aRkpdllb94k8QszzYD8BLX86IrRM8WQLqIVgG5ccAstxflnQKFT7okml/UsuvgvWoVU8uc37l
 7ZDn6FCX4umJFy08fxN2oL+4dPHZnmhB/1nog8G3housQ3EMVlL/JlxAZYydGNkGCt2f58EJS
 6x8oBbL8iIdQIepPURO2C/cy15haBIPJLWVtuOwTk66nYjUKGoYXbl47gKoJe/ZpP8mUZDgPd
 ebVVBwcPskBiaHjG2E+qHwGgHQxpNAppF/pQQPH8jAaovI0XEqPZBsKoNKMVJQhmK5L++H+T/
 raGg89Vm0sV0WvPUtrBzftVjpHuNDTkHKkE/qF+CEcYe3fc1Q6dD4bdyRGoZ80Y4VughSmMdf
 9CsyLNb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 11 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This makes the code consistent by fixing quite a couple of error messages.
> 
> Looks OK.  While at it, we may want another one to downcase the
> first word, perhaps?
> 
> These may not be messages added by your series and can be left
> outside this series, but I have to point out that
> 
>     if (commit_lock_file(&msg_file) < 0)
>         return error(_("Error wrapping up '%s'."), filename);
> 
> results in "error: Error wrapping up", which sounds quite funny.
> 
> "failed to finalize" or something would flow a bit better, I'd say.

Fair enough. I added a patch to make it so.

Thanks,
Dscho
