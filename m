Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BC81F597
	for <e@80x24.org>; Thu, 19 Jul 2018 20:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGSVNX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:13:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:47081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbeGSVNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:13:22 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMHaL-1ffPez2SJZ-0084p9; Thu, 19
 Jul 2018 22:28:20 +0200
Date:   Thu, 19 Jul 2018 22:28:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
In-Reply-To: <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807192225260.71@tvgsbejvaqbjf.bet>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com> <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com> <20180713184732.GC968742@genre.crustytoothpaste.net> <20180713201949.GA17670@sigill.intra.peff.net>
 <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nZiSBR7T4AZeG/HGq7tCWkYElSPjv9S+5ZTEog7GOqJH0ax9l8i
 JWRzwWrihk3G9Tvr+ouhD8qeYYPir+yrlt8g1f9qDapPKjYKRFTQ9aJtFy3IHHs8yIII4SU
 FDzA+xQnLU138I1pVbX4x+oQOi6VB5VYeG3ov3BKKoZptRrxqkz7kXI3AKuck1QJvQ+gDDh
 KDXP+l7KT6qO8oskwn2mA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q3xy+eJwoDA=:RLOXaLvR/yUlv3KFf+GBTK
 0PKhp4dyTvTHTKtb88p6skalaC5kAzmZxmYFvyQj0bDqSt2R5BuIGQlxuXcGd+61IzxCueCJF
 xEnHdWyxagV3iJ4Je/etbrJ5DEZovqwtGmmZWXDCfbGWgrHtX4YRKCOySGUfI+xNbgwzvttva
 vk99vgXkG7ggVYxDSg0QdX5zVx1lrPC5GPGrYgwuF480tjJKZCsdQhThjejvQq48tKVTzcMYx
 TtiZ84GHfxCOw9nY+0qlHinPRoypQjeWwSPUKIz7vJkATaQW/eahysk11ww8Xd4W0GFE+R71x
 Rrzhs5YNJDAWdGz4YFiOZWHfXyhN2VNCYwNlHzIuvoqWffjOdDuVaXN8k1fLgofCp5UbKfBXT
 spFAOo5EFjgk0ux8aewAN3UTAW2Rvcxd1NJeHfVr8hs1mazig2GymxcVxOutqAUb93Zj3qAXM
 fZZfL/Q+9lpilNUyJiPxar6gY5s1/zuIq0kfy8aCvDuAT0aZ0LBV831UWql1MCpBArpvQYXQm
 JeVqTRqjEiN0ectYF4AD1mwBcW2Snpv9ogDFlWQCNaWnOMOPrWSHk0rptP4MkLxp6XzYQvMxv
 1rEdSOokEFJBKUIfcop8l96UjZZYlNq86k+BVapZUx3oufJgFWn2P1NakrjgJQwh2ZTgum5Rd
 C476nB6FaWCI6F6cIbGxQ8AO2K+hD4hHYN1igKeU2CGPE8H2pqmOtWF2dMGLQL1Kt+IwjAusN
 SY4kz6+K/cXjxfJR8/hKKvAiumuxOEZR1vXDQqj7CS18rqs4PSwhbINiLjz2c6AziHbNX1kFG
 iH2RjgM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Jul 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > None of which is too surprising. The root of the bug is in the
> > conversion to rebase--helper, I think, when presumably we started
> > setting GIT_DIR at all (but I didn't dig further). Then 09d7b6c6fa fixed
> > _one_ fallout of that, which was relative paths, but didn't help the
> > subdirectory case.
> >
> > Just reading over this thread, I suspect the simplest fix is to pass
> > GIT_DIR and GIT_WORK_TREE together, which is almost always the right
> > thing to do.
> 
> Perhaps.  Not exporting GIT_DIR (unless the end-user already did to
> the environment before starting "git rebase"---it would be a bad
> change to unexport it unconditionally) may probably be a way to make
> rebase--helper conversion more faithful to the original scripted
> Porcelain, but I suspect in practice always giving GIT_DIR and
> GIT_WORK_TREE would work well for many existing hooks.

Forgetting the code in git-sh-setup, are we?

git_dir_init() rather specifically set GIT_DIR to the absolute path, and
since that variable is already exported, the `exec` commands launched via
`git-rebase--interactive` all saw it.

That is the reason why the sequencer.c was taught to set GIT_DIR to an
absolute path rathern than not setting it: for backwards compatibility.

Ciao,
Dscho
