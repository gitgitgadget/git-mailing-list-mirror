Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF5A20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752993AbdK0Uy5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:54:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:50982 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdK0Uy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:54:56 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1f0Qgm1G1k-00jGOl; Mon, 27
 Nov 2017 21:54:40 +0100
Date:   Mon, 27 Nov 2017 21:54:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: [PATCH] git-status.txt: mention --no-optional-locks
In-Reply-To: <b63ecdab-2283-9479-0de6-29a604c09670@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711272152510.6482@virtualbox>
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain> <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org> <20171122202720.GD11671@aiede.mtv.corp.google.com> <20171122211729.GA2854@sigill> <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill> <alpine.DEB.2.21.1.1711252240300.6482@virtualbox> <20171126192508.GB1501@sigill> <alpine.DEB.2.21.1.1711262231250.6482@virtualbox> <20171127052443.GB5946@sigill> <20171127060412.GA1247@sigill> <xmqqindwcl00.fsf@gitster.mtv.corp.google.com>
 <b63ecdab-2283-9479-0de6-29a604c09670@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Atglub2N3lSd+1s6Qtghht0AUQKilMadUToYJTW3YrTc32FmyCY
 kjcaX7Seg69kQz2eP9azZ1cdE3sMXZXox4v13mpN8YQ2PoN19ixPugXCzQ2eNrKxJlUGe/e
 b2N7unQNvCOShlnRakJB0uHNo1/XSUKFKeRDDQGqsgldxXjSEzB/eQCqkPBt1b+G69AJkrU
 wnJAx0cmpmz1s2Sa2eNJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TLDcsEqwHAM=:MFwT2hZ+UyxX5cd/VpqMmJ
 LiB78Irykt6j4FFSZQkBPdTxNBSQ/dUsKD7Cle27BfCSD0Nf1HXIgmrg1DGRN3FofkksPnFzF
 IxRznZ8V2NxgZ2Wjd46jIIw+cVnP9xr6l1M8rCKISdbBnf5R1nOTTcKxzcm9fB7lCerbEf4ce
 ePg6Ijw194qNUc1r1/+BrgUOl5seMzRfDlDAgKYhyA8h2dKO/yxMFsNHsKUInk9ZSgDo12hrQ
 rWtLpkDF/cYguXjaV78Knf1Mn7lRawJSv5xiVp2fJY+2cj9JeAR9KTB2vx4pNq5ebdoB0cthX
 OV+Hx1i7uS/m9su1OXNgG2pEXGUya3stYn063i3YBp7uQlEcfUBVhDW9r8G70h7zj8Wnyt+Xh
 jWIf+WP8Sb+Q7xNFeaVWfgRzG9jyMIQyFOFaT1Rr2Y+8iuBC90lH+aqFr+HBetne5GUNYDxGG
 +bHF/nD7kTloL2unAeTvOwc7iaNKuE4QhnB83h/NdyUhBBxw1bJsi55nSGRrOWhCzITJwSo4H
 PiuzDsf1z8mf9Ocmf6rARp6KT5ZI1RGyjiw9UCNkWPsgSh8/3sJn4vVlAiolx0LS/wQkpUW1S
 6UATGd/+1dZeO/6+8FYnfmTkIcLiWTo5dlvg7oEbV9ADt5J7IUx7ATvvgIZlct7A1atLkOt/h
 BBnafnU2PF3EMA1grWMWCww6T89f4x+c3PTd11LekmkEHgizCqrwBI29814kEAbLmZUfhzGc7
 FZI6z2Dr3OAvnNU/7GizIGXy3oASDmRjpMiiM3B5ZYYvdCNImxUGWL1CA74aaGfllnBxt9j+Y
 3RDXHlmi9+sAoqqqdl4HEj3l/GRu31IRJ3yfYqWDX8AkjCcUz8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Mon, 27 Nov 2017, Kaartic Sivaraam wrote:

> On Monday 27 November 2017 11:37 AM, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > > +using `git --no-optional-locks status` (see linkgit:git[1] for details).
> 
> It strikes me just now that `--no-side-effects` might have been a better
> name for the option (of course, iff this avoid all kinds of side
> effects. I'm not sure about the side affects other than index refreshing
> of "git status"). And in case we didn't care about the predictability of
> option names even a little, `--do-what-i-say` might have been a catchy
> alternative ;-)

Your reasoning points to an important insight: while writing index.lock
files is a side effect of `git status`, and while there may be other side
effects in other operations, it is highly doubtful that any caller would
just want to switch them off wholesale. Instead, it is much more likely
that callers will want to pick the side effect they want to switch off.

Ciao,
Dscho
