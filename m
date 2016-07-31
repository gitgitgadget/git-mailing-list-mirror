Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0317B1F955
	for <e@80x24.org>; Sun, 31 Jul 2016 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbcGaQkl (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 12:40:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:64287 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbcGaQkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 12:40:39 -0400
Received: from misery ([80.109.83.31]) by mail.gmx.com (mrgmx103) with ESMTPSA
 (Nemesis) id 0MGB7j-1bWua01vUN-00F7m0; Sun, 31 Jul 2016 18:40:31 +0200
Date:	Sun, 31 Jul 2016 18:39:35 +0200
From:	Stefan Tauner <stefan.tauner@gmx.at>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
In-Reply-To: <20160616095947.GA15988@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
	<20160616095947.GA15988@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-ID: <0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
X-Provags-ID: V03:K0:YmwLypr07Vlejl5M542hn9eeMi9yHE1djp05N5ZH/O6TCxeW2oe
 75m3h4wWeSzjdR6XtbUz1rHD8J6qrQPIvT+bUhN7zrPDNiRnmnw1AHl6uoBc2E+8IPOcEFa
 ZoiO+xKrsjz1PwZZeli8xxnRBjjfmqM7YbqTzQFtkmkxOB9gklX/kPvjuvDGXK3RBxxJrhx
 TMuVaSs9Y5zAazYBSCJow==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BOy6QVjdv3A=:sWEzz/p6LS1ET/HrA6o4EY
 pAHPvtOsRAFuVVltNmKgG6RICvC/jJDpTIEbhmJdjW3/zr3BnvBoe0ytHwGhLJEhb+vY1Uj6G
 Sx5UEvb23Dz5dvx3GZ28Qg9rZY6uVKacJU3ZbuV9EI66MrdnKjg8wV9U8pKWdnCdnTJ5kxu/F
 hcmht/0BBCHhFLebs6pCWgBGTlbZJJGSerAJV78ZayQCza9qFJ5H1S6tGrinGXlLyFcgwHE7U
 41j7F40+FsjtjoGIbr5mwdSW87hCK8B6j3BbY/pWUcnzpaX/6KMR2/qSgKnhPFT6zCfypwqRg
 nwvg2zqRVpnyNJQpIVPnyLqCE4VDgnkpopbHlDyUKWz1Z+eYsBRCnyMKcZnXocx5m/lCaAXE7
 GVemkZt1BDk+qSzcBg7yPTCZnW8Creej6rQtvVyhXOts2HqbMAm7wD/WfenUwarOCI0fktSjc
 /0Btd4lVBHg3jmcAHEYn3eD2E8yMrBFpd3wlSMp8Je8LKI0Ul+4i+W7ox1T4Eve4vl4ZKZlPT
 1nGplm/9/eqbincVWjDeUcJ3YHWpSXSxK8tUPwbMvDccdowQ2Aqa6eA9sZSmHCC5ToL0xkrWN
 ih/oXFgBAlRPqDKUI1/cqggwYLaZJFEOXwrCOP1mkzrL2E2i1b2B3uu+g7mfKjwnoTK73nhwz
 ONSumQ6A5+LbmlhYzNzwjaU9ueAHL8AxWJfTHBVzanfO1dZy5+AtOb3idHCeRzh4YbIBiQBGF
 l0JB9wwqOMOjUuHe9tf3Lrs4atDsNYHXpIo14T72OdospTu63/oPPa6vz/sD1X6foJLb6xAkD
 QmVNZ3l
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 16 Jun 2016 05:59:47 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Jun 13, 2016 at 08:28:18AM +0200, Stefan Tauner wrote:
> 
> > I am trying to do a major cleanup of the repository in one of my
> > projects (and switch from git-svn to native git). I have developed a
> > commit-filter script over the last months that massages partially
> > dreadful commit messages into something acceptable. While I am not 100%
> > sure I think that upgrading git has broken it partially. AFAICT since
> > the update the commit-filter does not get the original message anymore
> > but at least the subject/first paragraph is run through a pager or
> > something similar:
> > The first line is broken into multiple lines (i.e. some line breaks are
> > inserted about every 72 characters where none have been before).  
> 
> There are some output formats that will wrap lines, but by default,
> filter-branch should not be using them (and I could not reproduce the
> issue in a simple test). Can you show us what your commit-filter looks
> like?

Thanks for your answer. I have tried to reproduce it in other (newly
created) repositories but failed. However, it seems to relate to some
kind of persistent paging setting, is that possible?
git config -l does not show anything suspicious.

The following commands produce paged output:
git show hash
git show --pretty=%B
git log hash^..hash
Commit message in gitk


These do NOT produce paged output:
git patch hash^..hash
Commit message in gitg 0.2.7


This is the script I tried to use to reproduce the problem:

#!/bin/bash
export LC_ALL=C
input=$(cat)
echo "===========================
$input
===========================" >> /tmp/paging_bug.txt
git commit-tree "$@" -m "$input"

-- 
Kind regards/Mit freundlichen Grüßen, Stefan Tauner
