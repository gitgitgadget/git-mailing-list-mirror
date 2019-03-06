Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E5320248
	for <e@80x24.org>; Wed,  6 Mar 2019 12:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCFMj2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 07:39:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:51179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbfCFMj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 07:39:27 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54s2-1hAlF719W2-00zGAO; Wed, 06
 Mar 2019 13:39:23 +0100
Date:   Wed, 6 Mar 2019 13:39:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903061114370.41@tvgsbejvaqbjf.bet>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vSP9hITccb/Af0uPszg6rZe+mZxj7wSWDfPy/CP0/WYbDhPp0p6
 shtsVDENvRAE+wL8KZnOkCuVajqrCcm9GxC0JNBRFMs9Z84/rCx3aLPuOO5ZVeztxCsK2aL
 pFoaN6ka3f0Kmcy5JfcAG2fdzoL6gQ3n2Y3O33b6yi2BT2KGikctkI7bxr+jwfPu3O9SYFz
 NIM6H5wYDEkfekRp8lgwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6yOhZY2hL4g=:oi77yw6NYN6c+zvQMJcNyq
 S7/J9cRREzxTMe05Hs8fKuCclwbP1cZG6e/NMIn0Bpu0rRA6RMEkbPrpFzwF+HQr7m8LeI5KJ
 FRz9BkCFvzStBfPw5WV9T83+Vvg215lvMTbbtiFUN6QAxghMBFAuBU074R4EgqFNH7KdkhjO7
 wQRjJxklo6D9wk8LBC1xLSh+j03gi4t3RmNrsCs5qM+lrUpIGx3bEkhclCOrR3pF4hqcC+lMq
 mGPSYFJvW4uO3lCbEE0EAnVWYNojgka6MpOGrfd5MYDdiwGyuWmD8oseKWDBx0drUmTgEdXUS
 NBf2i/Vvb9166BqwFedGJQOKmGyQOnVmmyAZ8IY0Q+ypTSwhnMINXwFsvMD83OqqFo4BnBqJM
 e12FGigHRwQQ3yoPtY9/pXUrhGKJ35RBFeVTJK4KUc4BK7XbQ6Wcz8I58StEfFTV2XlNmqgU9
 CRP7wB54GhFT33tq/ZYBGojk1S+N1lRNU9HollebleclIY3Gp01cLuxNBEDzTuYAxyWEqylyK
 1Ab19LmM7ry1fFjKEmUs0rD3W6qoSJwIfMITKjTjTrJMkgcFSBMGTgNG52BCz4fgPk4kbSCkM
 LXckkT0JLkCWGuovP9CHAvqWw8VKfRMu0SjYbHztRCWscGtuJmR5sZ0pJuWOwKgMd88Bk43od
 nr49Pd80Ls+tFQzHrzoazJV75m86tsFT6aIVdAtrI80lMoXq7moCeGT7AfiTSOExEBdtbTBzl
 ec3EwLh6p042UjLWCf8OHdKMsNfiIoUAHyJIpnLBsnwj9E0r1GZjyP8u20WiBCKFATj2VMuRM
 ShvYY9evWIEs+JYPT3Tnrpiw8HkkJNtd8gYPwpO881CzU0J/BxFm7qmWeaxcHAObTYLJlr5SF
 PLidFu3L0E++ks+0w5GVwUU3krW8RIoWD8MTLQZTbyobrpcQR5cX8G11H6bP/X35+7/JCR9SB
 cqIp38AgN5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> * js/rebase-orig-head-fix (2019-03-04) 4 commits
>  - built-in rebase: set ORIG_HEAD just once, before the rebase
>  - built-in rebase: demonstrate that ORIG_HEAD is not set correctly
>  - built-in rebase: use the correct reflog when switching branches
>  - built-in rebase: no need to check out `onto` twice
> 
>  "gir rebase" that was reimplemented in C did not set ORIG_HEAD

s/gir/git/ (assuming that you use these descriptions to generate the
announcement mails?)

Ciao,
Dscho

>  correctly, which has been corrected.
> 
>  Will merge to 'next'.
> 
> 
