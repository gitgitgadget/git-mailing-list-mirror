Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67C41F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeAEUWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:22:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:58322 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeAEUWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:22:14 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MdKkd-1eF3sg0Hb9-00ITCR; Fri, 05 Jan 2018 21:22:09 +0100
Date:   Fri, 5 Jan 2018 21:22:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Isaac Shabtay <isaac@shabtay.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
In-Reply-To: <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com> <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com> <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com> <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com> <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:auouXOlkPNEKJ3sogOyNy2pmzQF2t0uTCJlVIe6hf+JZrycYj0I
 BxYvcXmzX2EyLkqzATVvl+WkBjE/l75dS1uN8ujzggqBSn8JRVnZnGjSWVe2B/Hq2B0YTo+
 NqvRgeBzTeo1JXC6y5CEoQGj1Lw6nEfzRRc3+Ed2nyHxmS8drgxsJsGYcJJDb/gMTbSo6ej
 KhH5zVFNbqyEyLklPNFow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OEag9l3eTtw=:86F0b2FRjNzdvSlfmsZ1Mw
 NkSeHbUy3G6eso4MvSbkE2pga/js5j/Y7xaawGReOPxmcXE3G/XSm7kpgPjTc+YLxjRWKoCKT
 lc5ZrPBv2m/V3gUcEAFmrhesORynFR3FpssAhmCeyJ/PlNwTOgmBqBMDwp9WHBKUwam8AxQ4p
 dLgKhF7GxyYjsdO+mvxZjCOcTltcH4hKvZ5B6o2JTvrBbd7kzEEZO0/H++t4fnSUgM2kE4ioP
 lK9c3qbU77Z/8Ge6kNKI9RokPXZA1HQ4/LIWezRdevzS/sqU8lOpsYwTJlB4psy0hlTFZ1OLz
 lImPhD62C14EGDYbwuj5APQ5n0fgQg+3ybgPKMIWhyGfMWxWY7Wg+0d04SBRsmfV4FDmxudmw
 5a8RMIHBEZUQii8apdgnccfms3PIvGHZKc8i8qAC6Djfeo7HskK7bkUOlC9ivgO6aZgwyEPyn
 N6pT4sbIueQG+V8ey5NoSvAiWi+XEI/Rwy3nKTWSpd5Rw6LEPNLTRo3erowuryE/7OSO7QBBC
 Jh+Nw9qozTFuD2kkHioHhIgM8vg/oBFzLGrRygjAmLAZu205Z5XcLyXs1vb1TJPLQs7wrmKtt
 DHKv/pBoQGAsrTWHdBybYXWvppWCEziuhkhncZ2RNiOwV8g5UAZx9RkhW2AO20hjTk4S8KeNk
 ywCR/y+A/6KmHt/LTjiNx76ATJUsYZkDMbTyRKqinGaFIL6EBVuXZf+fJH+zjw731p1wr/eNu
 thDRu8CVY0AE5pBBYU/+8RR8mQ7NRCEdSv4CoK6ERpVQO8pE2XEgK28JKgKY+dDp1kBdpzXvT
 6WjeIIDwupMR128NPscbRtTDxZ43GTgVrm2TEc9bUrk76ShCIxSsccvV7KbgYAIsds09HIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isaac,

On Fri, 5 Jan 2018, Isaac Shabtay wrote:

> Done: https://github.com/git-for-windows/git/pull/1421
> 
> I added credit to Jeff in the PR's description.

Sadly, the PR's description won't make it into the commit history, and the
authorship really should have been retained.

I found Peff's topic branch in his fork and force-pushed, to demonstrate
what I wanted to have. Currently the test suite is running (I test 64-bit
builds of the three major platforms Windows, macOS and Linux), and once
that is done and passed, I will merge the Pull Request.

> Note that I tried compiling master, but failed due to a reason
> unrelated to this patch:
> 
> builtin/checkout.c:24:10: fatal error: fscache.h: No such file or directory

That was an oversight in a previously-merged Pull Request. I have fixed
that locally and will soon push it out onto `master`.

Ciao,
Johannes
