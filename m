Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A1A1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 13:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdLINp1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 08:45:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:54430 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdLINp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 08:45:26 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZmd6-1emmyO2EQu-00lSA5; Sat, 09
 Dec 2017 14:45:16 +0100
Date:   Sat, 9 Dec 2017 14:44:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
In-Reply-To: <20171208220046.GA26270@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
References: <20171208104647.GA4016@sigill.intra.peff.net> <20171208104722.GD4939@sigill.intra.peff.net> <alpine.DEB.2.21.1.1712081602570.4318@virtualbox> <20171208220046.GA26270@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vmntZOFq/SjLq3ZhdAjPNm17tnuDhdcB1namT8PlmpE/FG7uOx6
 6kXBufNi9/mTt18/0W0vTEcOODpJ6sKmtvTLTVT0xJ7v77A1R+QpHNvogdr0480O1DqUvg/
 FQPu3pWRKyqpc7+C3dUDllJ5ggEIeTmx/mYLyJaHkC3jkBltKoNAzcQ88NsgAJ7MlBGY1GR
 8Vpklkzr4t/5gOcG0Nkew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ByZCNp8MHp4=:RFRYxnTu0n4Yi2SCVUOOiC
 FLlcBiXflSuuBDNqNF39sSzQ/m+QmgTP6NjmzjMBDeSfAqqG1RgeGz0k6pyI617y7M0TnqCCt
 lJjh55BHTyZu5eKqccSNDAkp2rSqQzn2LP4YTIZHCgY5zCqYbSsvdacTRPlgfLSv/BZgiu9aB
 oiGI2H5V0O6z3KQBXRAw+nja0dMLycN2iBaAP4MMUt6C82vX+two8GUeowFLlUn150g6A/jjW
 bsxOzVwd19tfRXcbhPyvA2mhke8J8kdUMC/l+aioMttTH6WNuUQpJKcRNpyAbWVn6lRg8X0PT
 DtQK3vCuj/3plfn1K+hgE0kVS2Jk6TZDQzOIPLw5Kw+pYfO7TOExjqBcArxRpfY3OT5CcKiNE
 Kwbu0gidNLENoT0sv3PnWBcAjhzmkolJIb5G0vJZiJMkCbNeVGPIvAejDPRPkpnAggFHsCrKb
 iVl+PMFVCEqifznaxK9Peze61HKDO6NI6q34E2ZVn/g/yl3JNzSw4ZWbRz2Z42BUKJNtPSl60
 S2aM7VXD1MBfh34L+yPr518As4RGAjKTN38qL59nuxK1g4BIXgcdNncuEGueQJBM33kzyVxpg
 OvA8IvXbw3RWv5pOHRkgYPq9bgVwMXgDzPhGbOoUVXpBqpsCt5zrlqCDTqJI+HbHz545PVDM9
 Q7Sohhkd+kZTknEwQG6tm01V0qHiVP6VZdERT4kr4qasYw+VX4y3rrS3WkpOnnwBRpdJ/0Ymh
 KBasfUKLE+opEz668Eabr3kMxl7qvE7VVgW9jZvCSE0dN4SWJJvhOfQA7qpgwxAk/RHLVZpnT
 j+xi+k4BGr8xVxSVBAKUtvm7rEfaGxw5IUhng+kbbsAYcdhT+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 8 Dec 2017, Jeff King wrote:

> On Fri, Dec 08, 2017 at 04:08:19PM +0100, Johannes Schindelin wrote:
> 
> > > Yes, but test-lib.sh sources GIT-BUILD-OPTIONS, which we
> > > built during the first "make". And that overrides the
> > > environment, giving us the original SHELL_PATH again.
> > 
> > ... and we could simply see whether the environment variable
> > TEST_SHELL_PATH (which we would set in t/Makefile from the passed-in
> > SHELL_PATH) is set, and override it again.
> > 
> > I still think we can do without recording test-phase details in the
> > build-phase (which may, or may not, know what the test-phase wants to do).
> > 
> > In other words, I believe that we can make the invocation you mentioned
> > above work, by touching only t/Makefile (to pass SHELL_PATH as
> > TEST_SHELL_PATH) and t/test-lib.sh (to override the SHELL_PATH from
> > GIT-BUILD-OPTIONS with TEST_SHELL_PATH, if set).
> 
> We could do that, but it makes TEST_SHELL_PATH inconsistent with all of
> the other config.mak variables.

It is already inconsistent with the other variables because its scope is
the "test" phase, not the "build" phase.

Ciao,
Dscho
