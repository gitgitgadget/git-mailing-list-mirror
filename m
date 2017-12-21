Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0251F424
	for <e@80x24.org>; Thu, 21 Dec 2017 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdLUOGL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 09:06:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:51150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdLUOGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 09:06:10 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7sF-1eo6En1HlP-00oVp8; Thu, 21
 Dec 2017 15:06:02 +0100
Date:   Thu, 21 Dec 2017 15:06:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH] sequencer:
 improve config handling)
In-Reply-To: <1513794792.9785.2.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712211442470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>  <20171213114621.30250-1-phillip.wood@talktalk.net> <1513794792.9785.2.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AU5YBOSSAU6S/Slp/dpVRmojRaEZspAr0Xz/V1/9f3s/RF2Ci86
 pr0JwtfRU21oCVQ/83KEzMEc/+D7F8zZlNnDXwJ7pjFWyCsfcVQ0HpfDiudIO5cHhL8fNSD
 LzbTolkloovZBZRvHmsOTG5OvcAZFxlrymMqEZ/SD67B7uTzVMFNSryk674X8AdLijMVwQw
 WkzIMNR74Ej/qMVNi7c/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uJKTTVPZykw=:8Jy6+70E2JZZLT/AWpFcvg
 tQqkkHW4chCDmHS6ptvLBsCL3ReLcTDTS5hRklH9YPkYx+KrlFF2yDVhUoqd4N806cN+9HKeA
 NVLTJqFEqLUzbWBs49qL65YN6edjSPx7ZCPfQrDgTSkmJtYLE8sj97uaNvawPhHB3838+Yrvv
 ohfL81zvPOSGllaEXe/To31UkRDEbzfxEKOZFcEuMV5QjkxRc6h1jG129ee2ZggR3ZVeRV09l
 arQN+jCLx7MFEImHQOyGbPow/uFK4/qfDkU5k65CMXJXAZ9INuTNIVmteJAdP107ziAXYJzGq
 htgsP0cqP18g/nqdVRxTQ2Pt7Du5m75iRbZvsJrs79m5uY+tk94DCpTAUXZcjGR6V8i10Av5J
 UVhnmDNknsY4hpFU4jfFWopkccaM4BHmYni7qFVImdoJZ0jDVBGv/xSSc30WOe/IY+JQYNQwo
 +xfnBmhOFmooTOSy/ilby72wc9T4YZEEQ+aQkipL3g5xj03cy0XYxHKO4Nc7kAtIuwPKs6AyT
 rbdibzrfkunKLFjyz022WetlyMgicMDkaWanltEItGx8fBwKg1cvvx2DO4PBCcg+V+gQf45Vl
 gZP/kT/ohRh8NBX3lp5NtCRYRtheidcJCLH+YQZ0IurguUcJj4++EMywX5dkBdjLKnHsFz9CG
 sTWIW4ArDniQ1UmfZHaVWx3aaSaHc13HebmjYwJMJmCrnxh3n96Lt+e7uPjCzr/DzyLEuah4S
 +qtaHmxBx0LJiapxIF8mN2cXPV2RmPVOg970UxTqShxmtQFUdXpPafgWMX5BSm1Gk7FJvmnOC
 20EWnPgaa6Hp4y3pgN0U2AXhpCOMYj1252gXf4AIqtazSf1VOU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Thu, 21 Dec 2017, Kaartic Sivaraam wrote:

> I recently encountered that error when trying to do an interactive
> rebase after using filter-branch to remove a file completely in a
> repository. I bisected this issue which pointed at this patch. I'm not
> sure how it is related as I'm not too familiar with the sequencer code.
> I could help in case any specific information is needed. As a first
> step, I've posted the output of "strace /mnt/Source//Git/git rebase -i
> HEAD~10" below.

I fear that the strace does not cover the `git-rebase` process nor the
`git-rebase--helper` process (which must have been part of your run, as
the commit affected only that part of the rebase operation).

If you have valgrind installed, you may want to give it a try. Since
git-rebase is (still, much to my dislike) a Unix shell script, you will
have to work quite hard to get it to valgrind correctly.

This is how I typically do it: I edit the
/home/unique/.local/libexec/git-core/git-rebase file directly (it is in a
different path for me, of course), first adding a `set -x` as 2nd or 3rd
line (not the 1st, to avoid messing with Git for Windows' shell script
detection that requires a shebang, and I do that also on other platforms
to spare some brain cycles), then treat git-rebase--interactive
identically, then run the offending command to figure out which call
really fails.

Then, I look for that call (I imagine it is the `exec git rebase--helper
${force_rebase:+--no-ff} --continue` line), then copy-edit it and guard it
by an environment variable:

	test -z "$DDDD" || {
		valgrind git rebase--helper ${force_rebase:+--no-ff} \
			--continue
		exit
	}
	exec git rebase--helper ${force_rebase:+--no-ff} --continue

After that, you can run the same command, and trigger the new code path by
that environment variable:

	DDDD=1 /mnt/Source/Git/git rebase -i HEAD~10

That way, you can keep the rest of your Git calls be unaffected by the
patch.

BTW from your invocation, I imagine that you wanted to actually run your
Git just-built-from-source, in-place. But for that, you would need to pass
the --exec-path option, too, like so:

	DDDD=1 /mnt/Source/Git/git --exec-path=/mnt/Source/Git \
		rebase -i HEAD~10

That way, you could edit the git-rebase--interactive file that is *not*
installed, and avoid affecting other Git operations (you would also not
need to guard the new code path behind a conditional).

Ciao,
Dscho
