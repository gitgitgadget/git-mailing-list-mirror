Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2CA1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947515AbdDYTpY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 15:45:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:58108 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1947477AbdDYTpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 15:45:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBFgr-1cst8D0UB3-00AEhX; Tue, 25
 Apr 2017 21:45:16 +0200
Date:   Tue, 25 Apr 2017 21:45:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     liam BEGUIN <liambeguin@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
In-Reply-To: <1493089056.29673.21.camel@gmail.com>
Message-ID: <alpine.DEB.2.20.1704252143520.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>  <alpine.DEB.2.20.1704241225300.3480@virtualbox> <1493089056.29673.21.camel@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VEJp6sB+Te76WsMDC4V4pActFqQxxdonTGl6iQFx19uObFLyzw5
 j1nEQF+Cv1jvCHr5sB3fJi+8AsyA//eDWE3iC9F8omGnt714huPvYH3+gqW0Hu3hUzkPjQM
 7uEJEVlKFnLJa1m4+pyax3vHVtBbMAke7kNFm3EKV6snGNR+AdwRS+KVCOLMtNp8vzaXE4H
 vPNp2+gbFBJ4fYlwk580g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p9z5amyyjy8=:AeNOdwtTnEpSKTL+tnTnm/
 BFnnPrKiaaYs3WRhyw00QCumuXaofEmsoMs1LkPeHLJMipa8DGnkyAenMpRG/VCsMorgDCLqD
 CmOZo1qkijILvYSeajj57RQrYVMB+xdd1S/jRzF447Leoo9JoyUpmGbExHCCkipYVglAGv/ZM
 mvX6CzqUBoJ0TC5BsYHGtOrli/Zu7Pyn1GPEl3n0GVKHnRrE1q64EZ/++x1Kk3zmtHMa2Rs6x
 c/o6PFAfQecms2oPWOulz1ntWH8pAJc/CQc9BuclHvJimtuBeJKDE8xn4FcT9AihPMUep/cU/
 DUnBiXLisEhteV9XgkTA2wS8LnJ5BYMTts0vfWI28dil0ALGAmAnY0bcUHxGiTGajZN7Pz/PJ
 t4jX49/o699drEZR2cf0nicJfsGHK+4+Fl3qWKO+3zeC7m/RL6+weKGnIZ6oE9zbhQkCn2gyB
 WX/Z2J3dq5mjBwpiqqezitzceXC72CESRxxOnA/SzRU4S0O1pxGBcZ3uZ0UA3ppKjx8CU8Vl3
 uAU8yRh8kCQOQVsjwjZ7h3YYtHCAsA+h5aZ7fGNcdBcVeNEPf6nLsDhmoAoXIfK0FeqCxnH0L
 98spYiIgfms1v7RnPHeuVpMtWgx4eJ6vSybllEN64iHMaYSc+taCnCXSp5pLCQTIggvcDKfJU
 W8e9yxzFGdHazyxEj7YGVWkC1V/TvzB9wmVGRIz5hecPEWr88X0ka/IBNPKSRSgXouJ+2SHTa
 WZkOu9IpKYDg3aI8+esTlGa3S8xaoyZaUDPTccnCn2EmvyW5aXWNiQPVd/eSujWEpq+IvAUfJ
 lHbu9eO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Mon, 24 Apr 2017, liam BEGUIN wrote:

> On Mon, 2017-04-24 at 12:26 +0200, Johannes Schindelin wrote:
> 
> > On Sun, 23 Apr 2017, Liam Beguin wrote:
> > 
> > > Add the 'rebase.abbrevCmd' boolean config option to allow the user
> > > to abbreviate the default command name while editing the
> > > 'git-rebase-todo' file.
> > 
> > This patch does not handle the `git rebase --edit-todo` subcommand.
> > Intentional?
> 
> After a little more investigation, I'm not sure what should be added for
> the `git rebase --edit-todo` subcommand. It seems like it uses the same
> text that was added the first time (with `git rebase -i`).

Well, it uses whatever the user may have edited. It may surprise users
that their `pick` does not get converted to `p` like all the original
commands.

Ciao,
Johannes
