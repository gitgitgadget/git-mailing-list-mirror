Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1271F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 12:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGGMZf (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 08:25:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:54703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753905AbeGGMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 08:08:53 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8Nik-1fyGyh2xSk-00vvXw; Sat, 07
 Jul 2018 14:08:49 +0200
Date:   Sat, 7 Jul 2018 14:08:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's (not) cooking
In-Reply-To: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807071403320.75@tvgsbejvaqbjf.bet>
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7RUU+2COCEvDB431dAFM2dmsMLpC9yli3BLcdit6NePuT13D7po
 HzUmYsgQbZAaURfOedNhkhjZMbSpmufOuh4CDp+HAeiT68fpEdouDxzWdmKRqAm5xf8G+Km
 wvLSNd8jsGLHn2Y52TkdbJn2xVtMH/CDzKJfckDg2qbSXEzywCZUFT5hvPe1aNJAECJsR0I
 9Nha9cLg9+g0mNokp0e2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MxaCadz49ZQ=:aKxkJ0+yeULrvuznhvodHP
 vxT+WkkK4MCa5sAGvPSe/PjyLUoc6GgEKquPby8cnFP12DVJlfJ3K0SCwjQbpfLkXiNV6Ztly
 xveZFtd97mZVMyaCHTmatr0WF+2OuhKuQLDHzJees0XObnryxrDLaDt2SaCGPRcqDE4BH/GlC
 mjofmGYk69XOmA+6qHoTeggqVUxG9G5RFehktGJqpJEZxUkZvmC/tMoUwZvZZC4xPvyRwOiLb
 3VSXm3fR7fnO9XTMYnxYAJ2ysGi2vM2q2xHHP/9SCE4WCvI/PIeAmM3A36l4tiVa03zQd59t9
 lqUBV7W00t51hMlJNpYsevPMEUuTfSKhAWmN5CVgLOoskfupoSqAVZF7PRprMZYbRg66u83d+
 Joxo1rjcbBAtWiR3q17BUOf+wu8Xpw4zjHUlJo1b9GUAIKoOKBBR03nqCeyFM3SYuaZslhHzA
 6oaVWDt2cU3xQgH0HbReqdZfkw7VFXAvJndxnWJjUKyZI7pKeSQ32pheFLnZFpm7xj5lwtLCS
 +MC9An9r8baQ0gPu/T7KmkdduhsfXeSyh1KGXP1uaiV/X3kwoNm4fxWWs62oNf4rgMytROr4d
 K7Q/zEwMzvvrcNCkK22E4yeHnhAwAaGchN4s0dckPwDUhMSvRomhKBb99WIy3/kWEXcWjNeat
 cU56ggp2Wv2mGUqu9EzlUy9wh883z/k+bGc1YS/smrE6CI8sr7fyvCg9vHRZD8eIpWQo1JvyC
 HF8ov+7WHtaqzzBFklnJkJ4WCyggkClo7rFE1MemSOddD+6KCefBdj49DWkytCw16Nc220XhH
 M8Dyw4l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> I'll be pushing out the integration branches with some updates, but
> there is no change in 'next' and below.  The following topics I gave
> a quick look and gave them topic branches, but I had trouble merging
> them in 'pu' and making them work correctly or pass the tests, so
> they are not part of 'pu' in today's pushout.
> 
>     pk/rebase-in-c
>     en/dirty-merge-fixes
>     en/t6036-merge-recursive-tests
>     en/t6042-insane-merge-rename-testcases
>     ds/multi-pack-index

Quick note that `pu` is broken on Windows:

https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=11901&view=logs

One quite serious looking symptom is this (line 169728 in the log):

2018-07-07T00:25:33.9171932Z ./test-lib.sh: line 664:  4516 Segmentation
fault      git gc

As you know, some time ago I tried to implement an automated build that
auto-bisects issues like this, and unfortunately I had to disable this
because it regularly ran out of time after 4h to bisect through the
complex commit history (due to the fact that many branches in `pu` are not
based on `master` but on commits that are way back in the past, and an
automated build cannot retain information easily such as "this commit was
clean, and please do not bother bisecting past it".

And sadly, previous tests of `pu` (see
https://git-for-windows.visualstudio.com/git/_build/index?definitionId=1&_a=history)
were failing on Windows already in the compile stage, see
e.g. https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=11612&view=logs

So I have no idea what caused this `gc` breakage.

Ciao,
Dscho
