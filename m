Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CD320958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964891AbdCWPw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:52:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:62810 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934419AbdCWPw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:52:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzcIM-1c3uNy1XhC-014lKh; Thu, 23
 Mar 2017 16:52:04 +0100
Date:   Thu, 23 Mar 2017 16:52:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <CAHGBnuOJKopxq4s0e-mw0=siOERDcLXCEF4xzERpq7usbrZa6w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703231650090.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de> <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com> <alpine.DEB.2.20.1703221704500.3767@virtualbox>
 <xmqqefxpkwjf.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231541180.3767@virtualbox> <CAHGBnuOJKopxq4s0e-mw0=siOERDcLXCEF4xzERpq7usbrZa6w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/ftcJp4jtirG/pOm3w9iumSpxe4bZiOYUOmhotMW7cAkRsR5ZW+
 yYtFstdPMr63d0A4ef1/t8Ilb+KQi7szUQMogSSw10mphu3XuDcuK6oDS/8OWqrvWKDKGXS
 WPf3aESciqRdJmol/J3gwXIyWD1pXqTfugoY9cEYjI5M8lf75PQq8P+MUwJj+75DypawKKa
 gpUvKDCkdQLppKHXqCFiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a2mz/cTwyrE=:LXGFAvVODFdojyvYsHezXH
 K+A+Vq25JSNZ4aTL127kUKuzb1DqoqC3r5aOHgNSrZe+Tx2h9Gsewi7+d4zQ8X6XPHota8o7D
 5KxZN+JbERSx5lS/+cpNc8R5yTCOoZGDR4KUlXXGhODOW5yPV/E9ctHLFDbitaeEgJj4m70DX
 aepcbYr/AR7/1tW7K0A6TvYIZt3t6mgK3VTpUMowOJpbjABwkIQG3tF1pdJjquSyOjEc4IDb8
 OF72SdxUhqbS5OaVS0MjKqENTEWV3MQtAHtK+l0cmws5uujFCS/I7x+gXYKgmMscZ+/K+0zOs
 LoON1Y5YspSYfrVo7+Mc19sj852oX4Yc9e0rMcUtOmRjc5BfxM4MHzL2sF2xJz7ihcc/d3H9e
 nw+WkzTJAXdP5+2ePSbh4x9K2Pc4TR3jtnEDMYL9PFw733vB336W3PkG0L0MbMUqTIG8VH4nD
 gnImiHB17XFx8osYI2+RHM25oM1cKCB7nykkpxi6TXzpEYAoiigRKFYHlymogmMHu1D64hXl9
 2SEI+b+z4+BMDnjNrxXOnjzdNnrDmpendC9yrditTrtiFQYp8kRA2UZKzDjXvPpH74YjI8950
 5ef5ejIWIR3fO2Ooqit4m9z7+ma4mkCw81ASDHDDmMKX+6385pLVtoPwQzCN9fwTazreJsg1t
 8QtnIksaJvOAAWUFK8a3NPN2sGm5COvw6EKLsPglyMWb539cVbkL0nwm1BJep2CRdwQOl6c5v
 Ko2pVAR+LahBQCfy9g0rbE7RT3PGHwYxZOptAiLt+v6LKuX6bEg3CQ/hKfLLqimhMXjE+1LXu
 UN4e/OHKDMDpW2vOfYEC1Wx3KLbhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Thu, 23 Mar 2017, Sebastian Schuberth wrote:

> On Thu, Mar 23, 2017 at 3:43 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > I know Sebastian well, and I would hope that he lends his substantial
> > competence to making sure that the changes that affect end users are
> > correct and that I do not introduce another regression.
> 
> If you'd really know me, you would also know that I only say something
> *if* I have to say something.

Okay, then, I sit corrected: I do not know you well.

> I.e. me not making any remarks regarding the C code means I did not find
> any issues.

Sadly, this is indistinguishable from you having not bothered to read the
patches to the C code at all.

So an explicit "I have read the patch and found no fault" or even better,
a review with some indication that you were thorough would have been a
nice gesture.

Ciao,
Johannes
