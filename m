Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6593D20756
	for <e@80x24.org>; Mon,  9 Jan 2017 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbdAIIKK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 03:10:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:53878 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932227AbdAIIKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 03:10:09 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzGV3-1cUkAn1HiD-014VyM; Mon, 09
 Jan 2017 09:09:56 +0100
Date:   Mon, 9 Jan 2017 09:09:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Steven Penny <svnpenn@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: POSIX windres
In-Reply-To: <xmqqtw99x70u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701090903500.3469@virtualbox>
References: <20170107214110.3124-1-svnpenn@gmail.com> <xmqqtw99x70u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2+elFPInqAvhvhQtpmbu9/rmcDqAofzPbYKWs8RyGo+YkzznmI7
 sDltN0WBEes4tmTbAmzI6k2fCCLsO9ydQUjpzEsM8YikiSTWHE+dBAeOrIcYTc40C3hUE7p
 Apzpi3SzbFS0d44CCYE8K1tkExoKoOB6xINvZfnytlbf9mh19C3O2Ixhzj3vrsxG31HH2v7
 0BT8/1p0+xWxnMlNNMLPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6TzhDyiyxZE=:Y8gtpV+7mLYa/GV3QqY5K6
 YT2gjiDIQw1b8e0FoAznXhH+TRXcjlCdIIygGd7ED5x6xCSt+e6VOipBgnhmSocs5F+ahI0Dh
 v/c7gi60hm1ZU4dbuAmHWSkSBp6SpJBZdz1k/FDIB6T6cfP7s0O9m93uCILcF4oSiHO0cvjkb
 awlKGuyMghf0XDWQ5RCERYuesmNdcJQzrbqLreZY/2p8cuzy9Cgg4fBXom0u46zc0kH2BQo7+
 JqKWrSIJk1cbpVXRZtTiSB7svTyWGDrGVAf+aQ+KCkBOMufzqPR1lgB3SwQEowrUZkmMdnQF+
 sa0dy0eXKy+ninLdyHPXrA5bp4gCw+ClD8vXBKHPfNVelqeSOK2fGn/2XSKYG0rxyNcd1UzOe
 JeBDDX4VIV221lDMSIguljO8jmvaVhvqNvyUWXdOuV5fct/mGfiygbQT35AnwlqasPs6twtWh
 0gy9Oz/VV1PAsNXnz01jcDkNwo4rdCJV52VTc5TX9FPByZX2cGD0pTewTvJ508kZKOoO1aF5O
 +A2AoMvaSaW3w2SqUJRTYjJ34mneLdtllU4s45ZD+G3uR7JoGC94Q6ft10TzscflTUk39ZFDO
 PiFSO9ArqmuAAwkrVnQ7fBIp2y72EWybzt2L0rSe4beuZmb4JHQkcpeiWIBwF3jm9aTuTKL3j
 knZ3JA50fEVckxlosbDtoh4mUwLXPooDGwqG2k1XuZkvV4D3azHpuaXQ92xLMfkrDv3TpWD+E
 9FWHTndiBImuuEAKACeZJ3QnPj4hAIy4Fs3hwcbHkQQ+RSW99gI4jn3E05zaGz8Jr9HkQqflC
 YRrRsif
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> Steven Penny <svnpenn@gmail.com> writes:
> 
> > When environment variable POSIXLY_CORRECT is set, the "input -o
> > output" syntax is not supported.
> >
> > http://cygwin.com/ml/cygwin/2017-01/msg00036.html
> >
> > Signed-off-by: Steven Penny <svnpenn@gmail.com>
> > ---
> 
> Who other than cygwin build uses this target?  Git for Windows?

Yes, Git for Windows uses this target, as did msysGit (and I suspect
Hannes' setup).

The resources are built correctly in Git for Windows SDK with this patch,
and I just verified that the windres shipped with the last msysGit (AKA
Git for Windows 1.x' SDK) handles the -i flag correctly, too. That is, at
least windres.exe included in binutils-2.19.1-mingw32-bin.tar.gz (which
was current at the time I updated msysGit on Feb 19 2009) can handle it.

So: ACK

Ciao,
Dscho

P.S.: I applied this patch to Git for Windows' `master`:
https://github.com/git-for-windows/git/commit/744120c602
