Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC951FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 12:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdJTM6r (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 08:58:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:52973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbdJTM6o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 08:58:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lr46Z-1daqhe2ZbX-00edPN; Fri, 20
 Oct 2017 14:58:41 +0200
Date:   Fri, 20 Oct 2017 14:58:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 1/4] fsmonitor: Watch, and ask about, the top of the
 repo, not the CWD
In-Reply-To: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710201457180.40514@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oC6oaaxxppEK3Tb+ZFPz7J578J/+L4MClscqBBrxSANNYG2+0s0
 tjIEpb9WAFV0in6FueKkvAtSKToKKACci94tW0V6Qcq47pWiDBjbMly1O+A2H8CxSKs6Ozp
 EB8SlHFbU7FCXySIWSH4qFaouc4PoxxQegSpv5WMLE59xWrcRqIoHvvca6YaUZVDBsTBXXP
 6O7CEHpFX8AVQShQ5Zkyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4Zcr3VwmFIQ=:DQTtx6D95alUXAxYFryIHf
 mbPgAE06PjKMDt0vIsNedi6PRoZ2Xo1lWhkkXC4smSnQj1eWi5Xbm0jw7moJqRVFJiVlGRzNZ
 KsZgA/8bgFvkNizlK6lzjNOLJ2WP02U4GBbkihFxGiLuA5jeCmIshWbwgux/EkJcA5vnnFa3N
 m7w3L0KZBjzAmFQvRGWLyZf/8hx/KqGcMJAcz1ndq4yhw5FzjFCoKa/BflyRXSspLUlaHr6fa
 l2oWYrAyCznQms2/pOtJNnqe/kBKdybJER3/SsWGnlkRFaHAymZCmN4TcOIfyOLwrDD3vQuMR
 f+LCZUkMQUQdUbQ7GB3uQzyUKZCSabkvmZNGTKxwXpd48uwFjx6EiKZwbM86a1d6yYfFua2ym
 DXBIewrVgD/iUtmTLqR76tSfYuvfYeBrMGLDYYTFOQrZQXufSw2t9HfC3FmhKSSRHopWpHgjX
 A5EtOHmtO5welWvPJMOIr5PWHXJgwmnFE0DZzsmd7N3GrO3XWDh4SuRtbiKbs7VCO56W+OTcJ
 sS8M25TNzzpdNY7BSxJhKB5lozMSjdcwOhcd9VlFu2vRQI7f4beOgQp9JD+rjUDJ+04KblRz6
 NUxA+P0xbiUeNliNO/dPbIfl4Ff5Ull8HOj+riXIPm21sLClGwLgNJO7mMfs+59x3pztXZiY4
 OcX6fDg7S0I/JRPuL26JVMiRtKeJCCyjOxQ2CqDl4VI+qgeEqAp7QYVgeF7yRiInYKll7ENl/
 Rmvt24eqcqMSe+KJkZ/vkkIEDDaOksTI+NrHEokpf9glIh+36iYQij3HBXi2ZM5qPVkztgNWQ
 Bfcb57+V4xgJyJtbvTSsE4MlBwi9Y8Sbph4c0ZA2p619MpSIWh4gd6fvuDodPVZ6gtvUFPz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, 19 Oct 2017, Alex Vandiver wrote:

> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>  t/t7519/fsmonitor-watchman                 | 3 ++-
>  templates/hooks--fsmonitor-watchman.sample | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index a3e30bf54..377edc7be 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -41,7 +41,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
>  	$git_work_tree =~ s/[\r\n]+//g;
>  	$git_work_tree =~ s,\\,/,g;
>  } else {
> -	$git_work_tree = $ENV{'PWD'};
> +	$git_work_tree = `git rev-parse --show-toplevel`;
> +	chomp $git_work_tree;

This is super expensive, as it means a full-blown new process instead of
just a simple environment variable expansion.

The idea behind using `PWD` instead was that Git will already have done
all of the work of figuring out the top-level directory and switched to
there before calling the fsmonitor hook.

Did you see any case where the script was *not* called from the top-level
directory?

Ciao,
Johannes
