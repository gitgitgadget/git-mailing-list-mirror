Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43111F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbcHPPjr (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:39:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:63935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbcHPPjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:39:46 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M3S2C-1bII5x10S0-00r1ay; Tue, 16 Aug 2016 17:39:05
 +0200
Date:	Tue, 16 Aug 2016 17:39:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] squash! diff: add --diff-line-prefix option for passing
 in a prefix
In-Reply-To: <xmqqfuq6humf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608161738440.4924@virtualbox>
References: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de> <xmqqinv3krpe.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608151519480.4924@virtualbox> <xmqqfuq6humf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JLOPz+vRbeOvyF9cey5Sor5pGEZw08Jp+e8YRvp9mXmh+2roUNu
 CaT2NCoEnnHYT23a1NNC0TvWbg8J+gqnK9fOH1EQ/SEaqPqJQy4YpoJUmxfx0q3Z6Hrl6T3
 7bF+D+dR3j/COEV0SGcwb/RPZBbczulQuZs7q9zIlrRfBfIkx5TJ5ptUudJGfiU5/Hbt5wl
 /2lAUe3A6nA+wd2yRXz4w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nddXBmv4kIo=:aQQblsF2kuyYJhqZ6ZTNs2
 THzTdRnE8yS2j+YsHZNq9KVfUm88VnCQi4gpZ5qqITql5vxU137HH2t3I+82BeYTf/h1FJOHa
 uhpLcdGvoPmV/EcGl4irE8sRe1ZSVASnIDW9zYHOR//mZ+Ugl5UEb96KNMN5dF78VrOqqwZ2d
 W9a1iJHsWvBEkpAd76psQnSplNrtGe/F13hNenvEHaynOSI3el19FDK1mJPD5vpdcMH+8wcw+
 BLbQorCqOJJl1M9CucLnpb5vhNELhsMxr0VxTS4GyU/JD7LjztTdREQHPEn9oRfFTBKluuQFW
 4hAINSF42K81CVZKJBulbkp0QDrnyL74oEaSQorS8V6bSfzzSjOSfIZQ9olQhIlzYSTA2gc4H
 Ux0tp9ZpCaII0yjLDghzn7twO2nGWmG58jZPgzQ7VtD48n0dw2DdnxXaMD/dc4ZLsQ3ZX44Dv
 MEED26sCw/7pLh/0ZpY30iAZ1HooWqRPgD2FqXmb/Q9MRri5RgT3c9KxiyPd0cYKRr/9nBWPj
 /bCyhoFwtBCzdPGBAP6rIceQeQeueIpoIMYID/Cf+LLRPLc3db8H9KNnnXytqKSOQ58pRQKGL
 vtsmU2fMBYZZVkBdcZ3jrEPYdMb+1EZUlEWFSB0mGhKjeQg7BtJcEC5m6Ll1T5ThS1yg3yCsa
 lDMUq0wX9Z943WJraJPPhsrXaNmmd6rxo/3uGGgBKk5aptX+rSlxBTI6D8aNd80wfjpwINsyC
 YEtNq3CdjcOg5hLfnGN8cgbos/iontU2nOlq/GUL26LOev+uyJssECsn3B+fu4YrOAaw68lxC
 Pvjsplp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 15 Aug 2016, Junio C Hamano wrote:

> Obviously (1) is a lot of impact with little gain, and as Jacob
> already offered to do, I think (2) is a lot more sensible solution
> and it also is more in line with your "If it isn't broken, do not
> fix it", I would say.

Yep, that makes most sense to me, too.

Ciao,
Dscho
