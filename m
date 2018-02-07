Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7AD1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 14:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeBGOMH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 09:12:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:44788 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbeBGOMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 09:12:06 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LvE2c-1erv0x0Nxy-010MmB; Wed, 07 Feb 2018 15:12:05 +0100
Date:   Wed, 7 Feb 2018 15:12:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Bulat Musin <mbulatka@yandex.ru>
cc:     git@vger.kernel.org
Subject: Re: [bug report]: error doing_rebase
In-Reply-To: <0254c12c-e820-9c00-a4d0-2192fca76130@yandex.ru>
Message-ID: <nycvar.QRO.7.76.6.1802071500020.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <d4246fa9-5ca2-33c9-d7b6-07adfd9b55a6@yandex.ru> <nycvar.QRO.7.76.6.1802061045160.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <0254c12c-e820-9c00-a4d0-2192fca76130@yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TstHQiCYeYju5vnbQNIffc2pxXymO4K3HnHiywELH5EqTLlh/zh
 uyeSGicSYueuimpk7MnF+VkkRBulPSFXtkQJYkGcPRj65L02CX/oDwltMibALrcO3PGr/CN
 2SHPn9Gh3GuwHVCZVA0TTXMwmDVxqhJEicJebI32k9iUBZv9g7QOABS/sBX9H4YSfuAK0ze
 Q3vjh9L8Og8H+NmV+lLTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Up+lRyBZrL4=:sTAnLeSrPJkhFK/rVu9dvD
 RgT1/TB4Dxfqk7A2vtBB+nxPUnHQfAmkvQ48zD6pEsHOWTIsqusXAKEwTnnJRSeOYZyA0PY3p
 Dm1NWMyJv2vN6uk0ISAX319DfYJ/pPkNRptP0Keq2s7AuKh7dd/F5/q+6axHNOKuc9hKYuxfl
 pzZ5j79+yXaHoH49CD/3GiDl+crzBruhTukuckUpxhVM4KtOSpMq6JWObGikB54Tdj6DyB6NA
 jhagvB1xg5bafTU6N5M+CeF96RLh7e4jB66bA543F75HgjYXmvTVmMrA8HLr7fj3udHBdM9o5
 pQlMDGFo97wh+0WZg+b5nzYYi/NCFAVZYXg2CwQ33Oh8aufOALsaHsPM3xz1yl0NBwkzGj2S4
 72wx+Lk+vLymw1NPOVV7XmWiwYi3ppGGZtMX/SHnx+b3EpaZW98Kg3SHcpBYdw4dKNoMiHAwx
 g+o/Gt99OaHVZ51SVljfd7tnZfUuDFm5n9jPM0TcLmp67WBZ6Rd4G1NLyfEkrnwXfFTShNF0p
 bDHCTtI2RvBoIOMt+f5QWrdraUXo27XQfxHC5j0wDj5O2oHgNXhDVUpdEYSA504RONQGFwzHw
 xPzuhmdeRE8+Hamhi7nN1ZMzgAcKvV+d0oe9yqFICngL9sL70iHONWkIi8Iux6PtsBTLKp1Zb
 WVOQzp9nytM1jUEuYX5J2jZe37ZZjFO1of/oHiff7mtCtalmKVQ2vhefH5QbosTKJzaekdG3x
 +dNWWS8Hiq910QgndwPKJTcH2RKOqo7PDvbENoFXlolf3+HEy4qoE9E0RO9jFmA/cfDAgMWEB
 mnEYBmV6uSAlXTstFcy4tn1T84aYqevI6hpxlHvCFgoBGaxtYI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bulat,

Please make sure to keep the Git mailing list in Cc: (I get *very* prickly
when Git users treat me as a free-of-cost help desk, and when I get that
annoyed, I stop helping).

On Tue, 6 Feb 2018, Bulat Musin wrote:

> Yes, I tested again.
> 
> With built 2.16... and it shows error message. git rebase --abort restores
> 
> state before rebase.

You misunderstood me. I am convinced that that error message *is correct*.
It shows an incorrect usage. You cannot start off an interactive rebase by
a `squash` command.

> With git 2.14 from Ubuntu's repo it works - 3 commits are squashed into first
> one

Yes, but you called `git rebase -i HEAD~2`, which means that only two
commits were up for rebasing. The third commit is outside the range
`HEAD~2..` which the command `git rebase -i HEAD~2` wants to let you rebase.

If v2.14 indeed modified `HEAD~2` (as I suspected in my earlier mail),
then you successfully confirmed that we fixed a bug, and that you expected
the buggy behavior.

> - with change SHA.
> 
> It seems to be bug in recent version.
> 
> Should I provide additional information?

Ciao,
Johannes

> On 02/06/2018 12:47 PM, Johannes Schindelin wrote:
> > Hi,
> >
> > On Mon, 5 Feb 2018, Bulat Musin wrote:
> >
> > > Now there are 3 sequential commits, I want to squash them into 1:
> > >
> > > git rebase -i HEAD~2
> > >
> > > In editor I changed all "pick" to "squash", saved file, I got:
> > >
> > > error: cannot 'squash' without a previous commit
> > You cannot start with a squash. You have to pick the first one, then
> > squash the second into the first.
> >
> > > However, 2.14.1 from Ubuntu's repo does the job - squashes 3 commits into
> > > 1.
> > It may be careless enough to do that, however, it might now have modified
> > the *wrong* commit, i.e. squashed the two patches *into HEAD~2*.
> >
> > Please verify that your HEAD~2 is still intact and part of the rebased
> > history, otherwise you will have a problem.
> >
> > Ciao,
> > Johannes
> 
> 
