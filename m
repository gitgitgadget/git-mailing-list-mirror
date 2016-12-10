Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4ED1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 14:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbcLJOxH (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 09:53:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:51856 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbcLJOxG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 09:53:06 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDW9x-1cPvD520YH-00Gp3H; Sat, 10
 Dec 2016 15:52:42 +0100
Date:   Sat, 10 Dec 2016 15:52:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
In-Reply-To: <20161209221854.re6qf3e5225wxvge@genre.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1612101551100.23160@virtualbox>
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox> <1481231552.20894.20.camel@frank> <20161209221854.re6qf3e5225wxvge@genre.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UF4x9FxfNdQbDDgkfmQiN4w+77JFLXyNb18tY/2RRsu1lXK5nf9
 BdUimLxaGdlJlVjE2qlFHVaqzGxAAw7N2ajlbw3wLf4YHljTySLkdDQ0WRUeoS5zeuvNKMc
 AgCUiU+O38vl3BRwdNin5pCY8ZzhRC+FcLZWFbaHA/Ax3ztaKCUgb0y/2DKa6AudQ9MZPeF
 PyoxAJEuJBvucGt0f3KsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aPtzMdQJmp0=:8hMM2umfWAGx2AJHk+33l+
 7JYCvoRUWmrEDmM52hw14+TGcrJfTWn2+3MjaZEnSSJtYLAYjD/qB4+bjkHapUeUGnNCEmGsc
 IgsrV6Liak5bWKaMw1EGzSQLYApxSd7t1/xCpeoy4mI8RVUm+tcMOfUsWury0/yVeqikD1Ymr
 lMR2kfLOKQBEvHOl0fFiTNBonbLU/L11zRCW9+zD+094dm86/Jil06A5zPZwrg6o0N6cxDcVy
 +ilUQYcEmun9xH/vnYqqzXFYnZaYrPsN3EuogpVLcEtx9BsoxnA5cuiOHYWqqduPb25Ew7kfI
 J1gExJ5in7XJdZcH59j9J5Fr4IjOrBoxehH3TaZh7BX5jvD3VPuodN1UZaWJctY8mkTBQdNir
 6hXLI3cBO2J0LpZk0bcc7ayCtQZNZhwm6ouglb75PMT6ubFHolQMwfiozAyT1gNjPVgkBCnTv
 knO5TtzJk/1FDtE+KStZ8qdxyYFOUHvnDoXAOv2QTzfVI5Ny9zF64VBw9XW1z3IEBVL+/Fzmq
 mz6WPxb7ZsQNuRllAv3uYmlyW7cLVDhM/4yNUJKtiMFo7+rYaeJhCqrZ2xnvl9nMz1eGkOrm7
 2gEp8o4rA+ordL3b+1Gol0tWQgYbShi3tLRGRgOvfaOJZXCYUQERtz6n7elrSUbEz5yAAm/nB
 ezKHd9XJDAtSPL2S4pKTODg/+SSUrtrd5+RYxZnMJpIyMuJG7n+31CjhGzgSjiORld7MFWXk0
 T48CJhIETTI/ykK+C542TFawJsO88oSn0X8LbiiriW2U6p4A4j908NDCishySeQgl50ek88UB
 C1V0FYL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Fri, 9 Dec 2016, brian m. carlson wrote:

> On Thu, Dec 08, 2016 at 04:12:32PM -0500, David Turner wrote:
> > I know of no reason that shouldn't work.  Indeed, it's what we use do
> > internally.  So far, nobody has reported problems.  That said, we have
> > exactly three sets of git servers that most users talk to (two
> > different internal; and occasionally github.com for external stuff).
> > So our coverage is not very broad.
> > 
> > If you're going to do it, tho, don't just do it for Windows users --
> > do it for everyone.  Plenty of Unix clients connect to Windows-based
> > auth systems.
> 
> Let me echo this.  This would make Kerberos (and probably other forms of
> SPNEGO) work out of the box, which would reduce a lot of confusion that
> people have.
> 
> I can confirm enabling http.emptyAuth works properly with Kerberos,
> including with fallback to Basic, so I see no reason why we shouldn't do
> it.

One of my colleagues offered a legitimate concern: it potentially adds
another round-trip.

Do you happen to know whether regular HTTPS negotiation will have an extra
round-trip if Kerberos is attempted, but we have to fall back to
interactively prompt for (or use stored) credentials?

Ciao,
Johannes
