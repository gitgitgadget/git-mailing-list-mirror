Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8B31F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeGLO7R (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 10:59:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:52645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732310AbeGLO7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 10:59:17 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSuMn-1fTM0t3KXl-00Rmxs; Thu, 12
 Jul 2018 16:49:22 +0200
Date:   Thu, 12 Jul 2018 16:49:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vitali Lovich <vlovich@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
In-Reply-To: <CAF8PYMikJZF4Qk4VHhAUPB80LG=gjZBVNBu0yGKCLLPpdG_3sg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121647310.75@tvgsbejvaqbjf.bet>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com> <CAF8PYMikJZF4Qk4VHhAUPB80LG=gjZBVNBu0yGKCLLPpdG_3sg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+D5oQ1IA8FVodve2eA26k7xBjtf759FFfy2zUQB1t6Px3rXYJDG
 A3UWwwWw99mY9kQcstieRCM4zkuU+qu9amIr4kADbhlM0lGA5ObJMpWQJXmxXeKtk0muhR5
 45lpnJZQg5DPYWbECJ66GaxZ4L5cVpZftcfQtDQK1BKpWpO0iiMeO/ivWsiQt7zFCh0VrZo
 in7+E1WZ8qtzo9UzE2bfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hlJkxUe+s4k=:pTdyLQDx2H5IbjKDcrMK2Y
 mGn+nHrfY1c9p572q3uC6X7ykucDxDRk+4nM84mQbPw3ttlIuHNmNKwUyvJfsgb2EkZoY/b15
 R0aWhQ+ppiw9qh3ThuMleBMTCZ9FHxIUQf0JpD9utSEPNBOMTH0fl+5k9W0RUT2KNsIQRxQKd
 Ypoc1b92Wq/l36Ry4cxeuqtofvPEaMIkwP+cZL6P4VbUChlTIZ6hdNLLy3VgxdGUKx5LN+a+6
 vOLo7pd+i9camduu5mnh6/GNbCFe/4ZLDBSfMZrZ6F8IdGRSPnrSjyhkYhStXEzmH1zqhFx1x
 6hX5WuhQGSFHkS4oerrOvlzsyaBvUfb/EMHETcmjl4yxoxc8CY8VRJM/zYqRcZfSR1FVC0P77
 nT4WLhs1HTy9GagNNFmvzaqorpuXI0GAJU/SG1pC5qtid3E/UMfrc0TymRnYEnMPsydT86nfH
 7U0BP25h2c74IfvuxC37xphoiaXn+1aHRLoFxXdurTJ7pyNGak4ZMHOBbDabpF8oFYbRHSPEY
 6pIc0IKb5p2tD0yhEzkKUeFUKcCH8nzO37NEf3eQu7L033TgYVUiPEj0c4OJ/rs4SPZUIqbrY
 QD/hucG2zyMauuNV3vQNJ5yOAqrO3IHsRvAZ6/rIybfWSz0Q8oy8zE3WlJeU4boBa9N6/1FEE
 sz4Wa0oqj8MsqyPwRrIPbT8R3akq9WQ0f8NeaysS5f826Vc4wP8ZGAZVF/Bz8ySpjtqGZXniG
 63wYKBSuZxESNX0+XHCHBaOUq/+nVWvpi4MTHq4nI1o6uzPPcqFviO1SLFljQNpN/t/14U9fq
 4/Tbkad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vitali,

[please avoid top-posting on this mailing list]

On Wed, 11 Jul 2018, Vitali Lovich wrote:

> On Wed, Jul 11, 2018 at 7:50 PM Vitali Lovich <vlovich@gmail.com> wrote:
> >
> > Typically git rev-parse --show-toplevel prints the folder containing
> > the .git folder regardless what subdirectory one is in.  One exception
> > I have found is that if one is within the context of git rebase --exec
> > then show-toplevel always just prints the current directory it's
> > running from.
> >
> > Repro (starting with cwd within git project):
> > > (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> > > git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> > # Stop at some commit for editing
> > > (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> > > git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> > ... path to git repository/xdiff !!!
> >
> > This seems like incorrect behaviour to me since it's a weird
> > inconsistency (even with other rebase contexts) & the documentation
> > says "Show the absolute path of the top-level directory." with no
> > caveats.
>
> Sorry.  Forgot to include the git versions I tested with (2.13.1,
> 2.17.0, 2.18.0)

This is actually not so much a bug in `rebase` as in `rev-parse
--show-top-level`:

	$ GIT_DIR=$PWD/.git git -C xdiff rev-parse --show-toplevel
	C:/git-sdk-64/usr/src/git/xdiff

Ciao,
Johannes
