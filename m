Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB8F20188
	for <e@80x24.org>; Fri, 12 May 2017 10:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757140AbdELKZw (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 06:25:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:54001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756761AbdELKZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 06:25:51 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVZuV-1dWbf40nJX-00Z3EX; Fri, 12
 May 2017 12:25:45 +0200
Date:   Fri, 12 May 2017 12:25:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
In-Reply-To: <xmqqd1be98kk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705121219150.146734@virtualbox>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de> <xmqqd1be98kk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vsTrJBJXMK5rhDZeqZBdbq7onh0n7Y6IKqSR7LjjppATLRoBgjh
 vE0ewhC7LWXTEJ9v8vhefjp1DIm1E2gan6QtOBjTLken+ocw2mEraGEt5brho2dCN+FcU4Z
 SW0To5ylLIy6Ge0uycqul+x3Z3XJpUduGU32fEKzC9XHRs87IIRBW+VEhfRSE2GjbgTSCMm
 H8LKF1Mp+NE667IU6ZeXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FaL9IrJmASw=:gHXi2/xQ/2lS3dW2HtD/fV
 MJHAcLMLzSkoPvwK8UZVfC+nHbmqaAKSTo8sBtKp99/kjdnn/sMIRnxKBz2PvHGwMBmEQOdzH
 M7RRCiD3uMt5U/BpWHk7M150SGA48IAFsg76GNX5sBQFao2s//eCCyEUPUbs8ZpB+ION7jfia
 F8T1gtTLMlvX1eNyNzpmgOXqrA1lCUWkL9jPdP+Bv07V5gr+SZMGPH/LIV4bcwvsLKcnCdmw4
 uS2IocVGXe26sQRH79klJcpkNPrLLy7PvBnPvBX9j0oGQ5F1tzbs6Cl7H5cyjsWH+M5V2Uvku
 GlOVs3u4YLfTslUFEXDb0Ixykalje9tXNSUf9Pg6b5mMex0MzZjdZSsuIIck9ydWN0TniNkHu
 xfi/cWAc/krUgdEX/VAPbuTGI8kOHcZNms8qq7lh6v+YAHLQj1Z0mXRdnpg/5rH7UBi/LZzdG
 5SkOXlM01Orm7yzZJY1j0GZ4/Xsbf2rp4UgUCnaYT31LxN/F5SIRxRMaUYz0pug2iLyuph6pV
 gKJSte6/Ns5CBJ7+gbwh4pMJVhYJMnELnFVRMBuLE3gRrX26f4KD3qVn5TCiBEPscPshieVll
 dmQ5EVPw1tlU288ueAXhU+kLY5VnBliYW9M6gk0GH2bMPL6XLErI++4tmkMvaRShUutnbqZVQ
 N9Th1TPlVrWpE0kfAkseFrBePtZsoDG+z8LeMM492uSFTN2RaCHnU0jZoGrHLcXJnc2Uci1FD
 xbjfnPo6rYP9+tRClX9y8OU697X+rN8tiLFp8RxvDtvvwHdGXYhV6oBeP2nxQRIVj5UsE3ts2
 GUR0GJn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The real issue here is that GNU awk's regex implementation assumes a
> > bit too much about the relative sizes of pointers and long integers.
> > What they really want is to use intptr_t.
> 
> Good.  I got annoyed enough to do the same myself before opening my
> mailbox.  One thing that is curious about your version is that it still
> has "#include <stdint.h>" behind HAVE_STDINT_H; when I tried to compile
> an equivalent of your change last night, the compilation failed because
> intptr_t wasn't available without exposing <stdint.h>
> 
> Where is Windows build getting its intptr_t, I wonder.

I'd place a bet on this part of compat/mingw.h for GCC builds:

	#ifdef __MINGW64_VERSION_MAJOR
	#include <stdint.h>
	#include <wchar.h>
	typedef _sigset_t sigset_t;
	#endif

and on this part of git-compat-util.h for MSVC builds:

	#ifndef NO_INTTYPES_H
	#include <inttypes.h>
	#else
	#include <stdint.h>
	#endif

For the record, it seems that our current version of compat/regex/regex.c
has this:

	/* On some systems, limits.h sets RE_DUP_MAX to a lower value than
	   GNU regex allows.  Include it before <regex.h>, which correctly
	   #undefs RE_DUP_MAX and sets it to the right value.  */
	#include <limits.h>
	#include <stdint.h>

while the one in `pu` lacks the last line. That may be the reason why
things compiled neatly before, and stopped working for you now.

So yeah, I think you are right in that the HAVE_STDINT_H guard needs to be
removed either before my patch, or squashed into it.

Ciao,
Dscho
