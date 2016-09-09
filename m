Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0ED41F859
	for <e@80x24.org>; Fri,  9 Sep 2016 09:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbcIIJ6d (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 05:58:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:53386 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbcIIJ6c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 05:58:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFtf4-1bnIEq1Jva-00EwWZ; Fri, 09 Sep 2016 11:58:22
 +0200
Date:   Fri, 9 Sep 2016 11:58:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
In-Reply-To: <20160908082713.sgzp2evbvzuthdb4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091158060.129229@virtualbox>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org> <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net> <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com> <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net> <alpine.DEB.2.20.1609081002490.129229@virtualbox>
 <20160908082713.sgzp2evbvzuthdb4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:86PIOHT8oKmzDSF+MkLghxOTvkt2IXboyB35N3JwInbqbj7JCCG
 /I1RmOzEebWsG7gWh5l+5nxDnfg+0tEdCefPZ3BAskKJc7QTxjubvHih+wLSCPGJ6iCRR33
 NzbbcLalNFDjVSFTsJXqaw6Hv2rQwu8O33JTEQwhcPbNIYkizoQIX0zqFwp9fAQHS64C+0O
 g8DmR5a3120SeX53DxYww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GQzzglskUD4=:N+exvfWJyGIzLFYx8pO84E
 osyt9NwfFc1DYgSeCfwajuKH0BGNMeIjGiKbbd+Vby9yCp6fuxanO31VecdYGtNv7hun5VmPA
 Cv6WD31cN5PFz+QZ4sWBaS0uiuyUhzjb9bAEtcDxSo/JEGR25DRvG/7PK5IIqeYBjsFf3KV8h
 pcQK1jMaorzQ7xB0T0/rCy/kaSiTS4AIWxIkK0tcG4PYuIVGzbGrSlHfH9SIQQpqLj04X8gXq
 7t9R+B+yDIuWlmp8y3+HxhUJnYqgj3xuzonNjQONyb/W67LL0Xa4q/sxFpVMz2rc94AuAPjnc
 GHEcxzQOOZEsc/ES8j0IFZ5dv6CEslVhtFA4yMnco6rUmBvlB3C2LSeSc4XJussklPgRdZoEP
 3/LYtTSKlKB2egxEjU9OE/h9MgOG1p2QN1rYwDGO+SPG7BCY6a6KPlkF1GMyHgrNh+Y4YLg0D
 sgtw9APruZeQ5A7gt6WwtSBE4ld7oo0LuifemhF7hy2MO5mc0qXs2USMUQmahCaxulJHHApkR
 cQRUE/1y8NsZMqnii0VuKz0PCh4uJUqdEx2eRBaentaB+sED9Xp8Lziv0ULMzRDko4fX2vNEu
 xoez/uv/URsoCfikmt07XetYYv1pvKsPaiBfvj0Y4ZAL1eoNpw22PsjbjDfCqKiWW2VQO1vir
 JBxmuQELIAvCNDmDVbHWHewUFJUryisKJfS0HpIPV8XoAzoyh9Bhn9Qe+jc6UxgVTz9wU5GQc
 28rvX9aAbjRs/Ta3KXpzCDq+wgskT/24O/VrgCK2ZgK26Q8OlxSIHv+nFas8XNYcb20Jq2VoI
 8WldlMH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 8 Sep 2016, Jeff King wrote:

> On Thu, Sep 08, 2016 at 10:05:58AM +0200, Johannes Schindelin wrote:
> 
> > > > Is fifo safe on Windows, though?
> > > 
> > > No clue. We seem to use mkfifo unconditionally in lib-daemon, but
> > > perhaps people do not run that test on Windows. Other invocations seem
> > > to be protected by the PIPE prerequisite. But...
> > 
> > AFAICT we do not use mkfifo on Windows. Let's see what t/test-lib.sh has
> > to say about the matter:
> > 
> > 	test_lazy_prereq PIPE '
> > 		# test whether the filesystem supports FIFOs
> > 		case $(uname -s) in
> > 		CYGWIN*|MINGW*)
> > 			false
> > 			;;
> > 		*)
> > 			rm -f testfifo && mkfifo testfifo
> > 			;;
> > 		esac
> > 	'
> > 
> > So there you go.
> > 
> > The reason it is disabled is that Cygwin/MSYS2 do have a concept of a
> > FIFO. But `git.exe` won't be able to access such a FIFO because it is
> > emulated by the POSIX emulation layer, which Git cannot access.
> 
> Regarding my "unconditionally" above: coincidentally, I happened to be
> looking in lib-git-daemon.sh about an hour ago and noticed that we do
> indeed check "test_have_prereq PIPE" (just not near the mkfifo, of
> course, because we are not in a test block).
> 
> It seems to have been added by a "Johannes Schindelin". Any relation?

Maybe ;-)
Dscho
