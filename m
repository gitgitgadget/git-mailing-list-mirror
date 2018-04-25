Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140181F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeDYMsv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:48:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:50443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeDYMsu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:48:50 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS0c2-1enYrB2hBa-00T9Wb; Wed, 25
 Apr 2018 14:48:43 +0200
Date:   Wed, 25 Apr 2018 14:48:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combinationof"
 in commit messages
In-Reply-To: <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804251442510.4978@tvgsbejvaqbjf.bet>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de> <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com> <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q0tVepMntkbz1nD2jB8nQRlxh7EtCCdY9uY2dw5eICk0+HJDPaJ
 SquVyXO1brdCCAGoV+7esaMWGB2TiZCn5KNbmvhlxI5QIrVViM0grkheyl42ZrJH412vm4F
 +xxJTrpggQvG1RyzoUttfOq4KGdv+xO5vOuOH/1Ey/RaW+yAGBP4aJ0Gml/yR9PCGCBvSyI
 EYDC9DrocZh+EVdyUWNAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WkxMJDI/Omo=:FCZGHc3YHkPXWSizBc6XJG
 kll+hq8zTV79lcPwuxjQ7qvZkNTANon9vYha1ZX5otfnSaqqAasMbzaJN1B669zgpbH8SSuZw
 P7YK2gRC6uISOWKvsQ85vU90U/2P4SWO/ny8MT4ftD87d/8KMeUwUW+Mn4TNyWr7zteGYRXOs
 02mRB3alkWyoitpTkkpo8qFGUjKggnJlCvjE+PJN2Npe2fdXRhzd75ZMQonA+3M8NASKj4U0T
 8EFHNUvn0BUBvhmdCwwt+Maz0WO2mHsSEtzEWzNdCMtr/q/y/ckkuaeub1MCK4kbwbeY0IHl1
 wkAwy4ZVUKFTpRyue4DkWC0szMwF1SjZiFCnzBN/K+Olcdo4ogkjHRIp3+9ARxnDBJsdHrr7U
 iP9tAH+VoQH7FF15ZeR/lkAesX0DWsTKNyIoFQ9K00NKkG9bG75F8eArOJteOGlq+Ys1ruoKo
 0Xh/LLZ8oXO+B44qv4Nr5xvAH8LljJ70Ea1dXaUNmwxyGZ/biiUzPlWiHCi4pGRg5fTyANxWZ
 ksBNJNx5Hm/Zp1GOaKoqLHakQW1qD2lMKHPZZ4nO5qaRoba2cYxtaTCP+KBlcZHlF79TwZJd+
 KFCQoazOZRkWriUVDX0GcXsi2Xx1W8ohHhrsoY1/56Jm0WrBm727j+vTxybRo/aT4s4c2MFAL
 7zk3IRZ4pGcSohAmHfnkM3UlhpuRtOGGrbveklOWzFVzepEsCBl4F99ZZMnB6oVisLadPmVV3
 UNIFO5MinqcbHC8ImodvjK327yqMR10YsLgrcS2MedO+WhzyoMlR0UAsOu7N4I0/x8POQjCLd
 3/x+EzvC7/FhxAokj6Hg3LnjBo8YIE5necdmgucuZHVyCNEp+1rGJvrgRhmHcvSd+rra0OE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 23 Apr 2018, Phillip Wood wrote:

> On 23/04/18 19:11, Stefan Beller wrote:
> > 
> > On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > > Eric Sunshine pointed out that I had such a commit message in
> > > https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
> > > and I went on a hunt to figure out how the heck this happened.
> > >
> > > Turns out that if there is a fixup/squash chain where the *last* command
> > > fails with merge conflicts, and we either --skip ahead or resolve the
> > > conflict to a clean tree and then --continue, our code does not do a
> > > final cleanup.
> > >
> > > Contrary to my initial gut feeling, this bug was not introduced by my
> > > rewrite in C of the core parts of rebase -i, but it looks to me as if
> > > that bug was with us for a very long time (at least the --skip part).
> > >
> > > The developer (read: user of rebase -i) in me says that we would want to
> > > fast-track this, but the author of rebase -i in me says that we should
> > > be cautious and cook this in `next` for a while.
> > 
> > I looked through the patches again and think this series is good to go.
> 
> I've just realized I commented on an outdated version as the new version was
> posted there rather than as a reply to v1. I've just looked through it and I'm
> not sure it addresses the unnecessary editing of the commit message of the
> previous commit if a single squash command is skipped as outlined in
> https://public-inbox.org/git/b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net/

I have not forgotten about this! I simply did not find the time yet, is
all...

The patch series still has not been merged to `next`, but I plan on
working on your suggested changes as an add-on commit anyway. I am not
quite sure yet how I want to handle the "avoid running commit for the
first fixup/squash in the series" problem, but I think we will have to add
*yet another* file that is written (in the "we already have comments in
the commit message" conditional block in error_failed_squash())...

Ciao,
Dscho
