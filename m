Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C971F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeCTPjU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:39:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:59209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbeCTPjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:39:16 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9vnQ-1erfWP1p5k-00B3k3; Tue, 20
 Mar 2018 16:39:09 +0100
Date:   Tue, 20 Mar 2018 16:38:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase --recreate-merges --keep-empty: don't prune
 empty commits
In-Reply-To: <20180320101114.17663-3-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803201638010.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180320101114.17663-1-phillip.wood@talktalk.net> <20180320101114.17663-3-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gejxtq9oZnW3bPwyrWR44zMiGXNc4G9Kuz0EgGNZp0yI+07zCN3
 Um0+RsVMQk1Sf+0sLYP0n56olVjyzrui6mIGGxMw7oCPh8n4esCSHpKUWobx57iXcTLe0Jn
 4MDUIiJB5t7RCMP/WZF49wAUxzpa16o3RK0KevnbyeyEiA0oL3opiI9+tCZ7BKa3bAwAoTa
 16V6rhb+3DiSfVxXoXSRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/iqKfbPNN98=:YgRVCBS7hBQHlzSvCoZlHV
 dQ6eZoh95Vh00aAcwTpBauR7O4RKC+kKIejd1Ts6ty/cIf1RWAyiUUKvametzVD4kl0ZUp9CN
 RtRQ8sEramxmu/WQgJPPn/eBYvPUTCvDqdmI4WIl8gO1UZBqRfxNLKwyupnE16dO6P7elbs9x
 Yy2UJuaIkRwU3gpD9Dm/7c6W+5iqg9v7qyOtFCs0gYGxcjT1KDWTow6x2Uc/z+9kk2k8ikpc5
 mdjwKC5h/nNSUkDwKS4jNcG2Q5212oEohZvZpiJhqnF9IJCrm6T0C9f8mz8eQpXEBDKsIzpxz
 0PaC/+QEEZ1aXIPEGctJ60trx9OzbHiPejIznVx0k3ep5YYCDJwJmEMJQ3wrbB8/9YchEst4D
 0joez5Bb/FY8c0THyagUy+q/oZbbGd1u6DjZVeDze1lPa65Zy+aRmjxlTLcWYZE28wIZGDUrC
 +3OqS2kE4xHsHcwPgr9IQVmrg63Sx/35Og3H3wy1ljfSdFr/LSP8Dcda+pr12hlEKYAROqiMI
 3Mmsw9Wxre/Ulm5SOx13Ul6VHtb3TqLo0xPOXgbosxR4GJ6f5IR76J5eOVkMakeFF+tV7JTm7
 dZUCi1VlIW4kmYD/vra7ev7l+W9yv5D4qcPAM2Xnwsz8oDryFWVR8ffiKe1Z9c7E+H/PjrPrx
 rEvQqm1y4eQuhkGPKfhN9HCQ6GqFO1FtAZe3lYrKHu+auXsg/U2gmPDG7zmAC/Xe6M2B9panw
 OQEHra0Hd1Ngcjvu5JO2n6pIDWzRF4AipWtxiVB0LB4gk4Kh/lpLjHZHjUTEnMSctoQpzsPHX
 +M0splGTmRUtD4vh7Sr5gglAIMsOv7occzKCwRB3P4+reVuM1I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 20 Mar 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If there are empty commits on the left hand side of $upstream...HEAD
> then the empty commits on the right hand side that we want to keep are
> pruned because they are marked as cherry-picks. Fix this by keeping
> the commits that are empty or are not marked as cherry-picks.

Thank you!

> @@ -3172,12 +3173,9 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>  
>  	init_revisions(&revs, NULL);
>  	revs.verbose_header = 1;
> -	if (recreate_merges)
> -		revs.cherry_mark = 1;
> -	else {
> +	if (!recreate_merges)
>  		revs.max_parents = 1;
> -		revs.cherry_pick = 1;
> -	}
> +	revs.cherry_mark = 1;
>  	revs.limited = 1;
>  	revs.reverse = 1;
>  	revs.right_only = 1;

Yeah, this looks ugly. I'd rather have your patch series applied first and
then rebase my --recreate-merges patch series on top.

Ciao,
Dscho
