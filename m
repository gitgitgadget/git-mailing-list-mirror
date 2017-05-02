Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CF21F790
	for <e@80x24.org>; Tue,  2 May 2017 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdEBPkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:40:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:52649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbdEBPkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:40:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLvLE-1d8tHw37PA-007nx8; Tue, 02
 May 2017 17:40:09 +0200
Date:   Tue, 2 May 2017 17:40:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 4/6] Documentation: move rebase.* config variables to
 a separate rebase-config.txt
In-Reply-To: <20170502040048.9065-5-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021736470.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com> <20170502040048.9065-5-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M2fhfAS0y6oEqIJZApkmTuDzxa8PNnt0wuEEjrC8NvJj7fHCzmZ
 UoEYNIIT/aJu5mT6RcbzCKNkdO5udQ/xFYIkk7LtQwRNKixOrfvc8XWe57VX6CVrr3srfcT
 OTIDsqGasJZNUpA6xJ/jrubD81fdwOoiujPQ392s+TXjVAvjFh77d3jwG/6e/hoEOithP6e
 8AHOA/XQgPeolI9c364VQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:um9Ax4TtW9o=:QdNe8nb905RAoiDLpzDHPq
 RLJnj4tzLLBJEoIij6sXnqH4UCSTfS3qLtkOXLZSeLOxy9nFJab8ya7EAEEuQutEzm6P09PC9
 AKMhvBGAlmDAw6xY4OA5fQYXWPQVN2oNOfp9x1WM7mbqGQlBQJ682rhSE6jlf/QtGyPq2pUrh
 As1qz8MHfk+NwI4Jr3iJ1RTm3TjqljyvU3Y5+IebPq2Qu9CMLuR55peF+0mq9WDuqXjDj6UVA
 MwEfu1kN0xBGPWWEJGWv4fWrikMNFi7jx+TlJJ3qkJKpj0WXhx/mRC4zV2rP//5g4TOLOVELn
 RS9PQf5x9u0Zj1eXh0lAZDFoszdJda97PF8BdG8Fx0SsZhO21qy8Rg6dZoJ5KZEFKcQdrdpRd
 bli1Mg0rAqxwBdJQw7RJ0VHbZnFjbShmN7UbIZtsxyHtD+VsVyw+nPFJ6NJPmqLgD88nPFrRR
 5XB/XOLrPFzhJR9VS626xYpqQp9DAYAPsoZIIep/5WVJ+TJLXjvp+zS2wA7XkDYZFeVPsKNoD
 w0JwATTNE7mTImE2XWE1BpzATaXRrXs+xAcIqHAfzMKXFKEl6crJKZOfMbbagOq+u5ldDoH7a
 Df/rnELcH1q3Nqmfg/1s11dwK0mKXh3cVvHUAqCH1pbjveFC9jZsPnDbfftfEyc9l4DPVEd4D
 G29u5ZbCn1pk/YyebSbeBJGYikWRilA/10db0Mug8/LygTbK3cMiB91Y5HtKCL+7b7l8eGYyw
 vuDX6pXrUsau7UV2NwjQ8hFKQDRPE0glgdTlA7mLFuO8tCcvPn2sCZrP63x3e4MQKKPhPAMU5
 AQsQfyP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,


On Tue, 2 May 2017, Liam Beguin wrote:

> Move configuration variables to a separate file in order to remove
> duplicates, and include it in config.txt and git-rebase.txt.
> The new descriptions are taken from config.txt as they are more verbose.

This is a nice cleanup in its own right. My only complaint: the
rebase.autoStash documentation no longer says that it is related to the
command-line option `--autosquash`.

While the original description in `git-rebase.txt` was suboptimal, maybe
we can add back the reference by adding something like:

	This option can be overridden by the `--no-autosquash` and
	`--autosquash` options of linkgit:git-rebase[1].

Ciao,
Johannes
