Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46B71F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 08:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbcIHIG0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:06:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:49559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936176AbcIHIGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:06:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LikyX-1bBrmU31J7-00czBd; Thu, 08 Sep 2016 10:05:59
 +0200
Date:   Thu, 8 Sep 2016 10:05:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
In-Reply-To: <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609081002490.129229@virtualbox>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org> <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net> <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com> <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JyGmxlRq34Jm6yO0m0CXzmz6yxKivCUSMy8ChG6ukcj8yXhDRhU
 ljHOp9oSrTsLDcyCgjgL+UNUd2GIal0wM/bY5kEzAcclpwC9Hen3LV3LLZQ5b7aKr09czp4
 AUKv5VsfUntrqNLGJZg4TRtvHvMeQ0QJ0GQHOIuVcfgylJOb4hOwthsHMbkErEpEqFdeZlI
 GKqStle1sRGSCD3DRvvSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bYxrXtSE5r8=:Ra3QqvyyavDcHnZc0ZKLwB
 zc4xp0gPhqG3BCICXZ3DLjgRqWkbFqV1aGlFkGrdfvpDqlvNgIYXo6V/nyNvSYBd1puDb7jFy
 DHSlv4RV6V1jxaXq2DxpwVfaWkPzf4x4sZUQkO253sE9R4QositRJTTP+MSMo0wLRF/QHiU1V
 fPK1N89VfpaIXGhF1C0WgfpzfMa5o6y1a7+mBVJ7D8QdfzITnDGEeWU6oY/Uy59ZSo5wiwVif
 Vj+pLmcWcOL9PvBuP43IjdiKP8/x6Wg/PuKO9veU7YRKSuf892KJpqGb9AuG+GVeGw1UvV7sf
 rQMZ3YMwi5ObRoMmEX/bzmDjSXkJBEI73HAIxoYmFGKCBrMbwVKFrEQJdB6f9Rik8ilDVF2Wb
 wyK6wPDb1vW0hs47cd05xowLCFRT1KvUjclNgTSFBbobltQaMM9PXX1T/I+xpNs+L08lx2mCX
 GqiIib1XX/agyYOkE94ZbaIPes49Q0wqo/T+dU3Q6lpk8rewtQ8YzjOdcTGdD76K5WEIVfYJh
 HFZ6JHUaxljF0eQaK6yiMQOeRpOizNQy/LwFnLJ3f8zWNhC1UaZbVKqjv7DWntlRH0Xh/zesu
 LJ6KVGvDpOSUbmqVcBBS6bvYhCnZx150MK9L6vwIDVdcUynr0/znGaPqhUDQiYUIwfTQWYnnX
 LoSyrGjZEfhel+G6YHD4oIn3m9DkRPTSi54bN0BaqgjtWYkXlcxJa7Fiu5GL0XPWMsDgJ6YT3
 gxGVuTIqkak2zIkFmF/bgvtkXEa+0HolZO/smqMc5y4pLbI3IpD1RjOgcEObwKWAqSBLfyyIB
 hTINkso
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Junio,

On Wed, 7 Sep 2016, Jeff King wrote:

> On Wed, Sep 07, 2016 at 11:39:57AM -0700, Junio C Hamano wrote:
> 
> > > Can we do some signaling with fifos to tell the hook when it is safe to
> > > exit? Then we would just need to `wait` for its parent process.
> > 
> > Is fifo safe on Windows, though?
> 
> No clue. We seem to use mkfifo unconditionally in lib-daemon, but
> perhaps people do not run that test on Windows. Other invocations seem
> to be protected by the PIPE prerequisite. But...

AFAICT we do not use mkfifo on Windows. Let's see what t/test-lib.sh has
to say about the matter:

	test_lazy_prereq PIPE '
		# test whether the filesystem supports FIFOs
		case $(uname -s) in
		CYGWIN*|MINGW*)
			false
			;;
		*)
			rm -f testfifo && mkfifo testfifo
			;;
		esac
	'

So there you go.

The reason it is disabled is that Cygwin/MSYS2 do have a concept of a
FIFO. But `git.exe` won't be able to access such a FIFO because it is
emulated by the POSIX emulation layer, which Git cannot access.

> > With v2 that explicitly kills, I guess we can make the sleep longer
> > without slowing down in the optimistic case?
> 
> Yeah, I think the v2 one is non-racy (I thought at first we might race
> with the "echo", but it should be synchronous; the hook will not exit
> until we have written the pid file, and git will not exit until the hook
> is done running).

Please note that Hannes and I discussed this (as I originally suggested to
increase it to 10 seconds, and Hannes rightfully pointed out that we would
have to change the script name, too, as it says sleep-one-second.sh, and
that would have made the patch less readable) and we came to the same
conclusion: it's not necessary.

Ciao,
Dscho
