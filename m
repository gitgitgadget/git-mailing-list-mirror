Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A801920954
	for <e@80x24.org>; Fri,  1 Dec 2017 13:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbdLANjF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 08:39:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:61093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdLANjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 08:39:04 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEsXW-1eJ7cs44gU-00FxBr; Fri, 01
 Dec 2017 14:39:01 +0100
Date:   Fri, 1 Dec 2017 14:38:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: cc/require-tcl-tk-for-build, was Re: What's cooking in git.git (Nov
 2017, #08; Tue, 28)
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712011436360.98586@virtualbox>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+XYaLTPASKoVznXw2GOLl9cZMf5XWeGvwKJrzpGTV9aLFBA9qEE
 h7ZxeFLBIe7tRJnW9SAE7r1G9iQ5EhonFZLJsdjyzZpmbOclyFtBliKgs9rKRMnHzCXahEa
 O/nUL3PMeIxKCH211EQqJPtTNTUe4g2T36mDp2cofgjKXgljC+jDLaXPr5B6cky4T2GU4sF
 58/fD3AoGYnrfyBxsCUcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AX3Hr026ZSE=:zsX5Bpx78hWCyWkWRzsNbk
 qCnJfqGj4aG5T3PZMneBSR6Cz3/g7aZXml6uqbzXOghGtTkx6+iEOwtBrmfD1GkL4aV9oVmJG
 zwHgr5ScCLABrCGbwrrkPQgo0b9WnJgnquIMIzkfvgrt6xGrAm6wOJ7Plk3tN2XHIoptPP9mw
 ZKnfsD+yrTnphdQhzCnrVKjouwXnpmfZH33GvVB9f6dUExm2ZxaLPvX5FPBBTCehyHWfrAvNA
 sj/T8xbbqmUDqmoNFrAWU+gi/OTXz72sF74F5hTfuVjogalUF+kStBJhZDVhBOPyr0aZortIg
 qRq1JPVa4s8dq/l60Asb+V+6+fp4d9d3g9HdX4H4C6ZsVwmGPk5msKfD+iU57vgQfbAReuIti
 G8Zu9v1TQi1lEHPP3FgsqvNyCyNAh6ujoOii9CKr3Pk3wgdJdWEPAwHLUbspUsXdVbk7XHlGP
 MDbWsY5xm0yVPmCkcw3V++J9E7f+OyhOcL6J94QJsZetG0MMEscuoUSOZPXA9HWWOhuIad62p
 kUR+B92acthfsXxp+7vfYbz94nYOuACV2rpNCIaR7900xPH2+cCTZY41b0BgrAGo7gsdD6Oit
 CQFnIItSKZLuAnYy17kL3QBCUTPaksgD/dLvrgKEZj/cYY3FFmHECMb9PjkgYRMsehVgEkOmk
 kwrHLLCAKXEV1qupql3BLE9WJkiqbio3GpkGLAtv0vQIAdeC/g4ZV/K5ZX1eeZjcEHSL/OeeI
 pP5+npDiSpzKJPE21CPUmDSo9ysDaBxkKcPEEWLfY2qrIx3L242tTkSSnjFvN99BrDGw6/CPY
 esnvm6NPd565vrL47n5Cj73Zl1iXdV7MliZlpPMDeIRipNw+UY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Nov 2017, Junio C Hamano wrote:

> * cc/require-tcl-tk-for-build (2017-11-27) 1 commit
>  - Makefile: check that tcl/tk is installed
> 
>  A first-time builder of Git may have installed neither tclsh nor
>  msgfmt, in which case git-gui and gitk part will fail and break the
>  build.  As a workaround, refuse to run a build when tclsh is not
>  installed and NO_TCLTK is not set.
> 
>  Undecided.
>  I still feel that requring tclsh to be installed, with or without
>  "escape hatch" for experts, may be too heavy-handed.

FWIW I agree, from a maintainer's point of view (even if Git for Windows
always had a working Tcl/Tk, I remember the times when I did not have the
luxury of tclsh being there, and my quota was not enough to allow for
compiling *both* emacs and Tcl/Tk on that box).

Ciao,
Dscho
