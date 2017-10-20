Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC831FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdJTNAn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:00:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:61305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbdJTNAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:00:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm3H7-1dVv333TLF-00ZesN; Fri, 20
 Oct 2017 15:00:40 +0200
Date:   Fri, 20 Oct 2017 15:00:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
In-Reply-To: <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710201459020.40514@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XTfTxAk+1yBvznWIEUdxd205s2ZU/cZ2MC1u5RhSB4Ahwdq4NSc
 r+s69uHur7N5faQIT9ctOcPZ6dqjc1zHRCISE6raCX92NbdrYvBkqzDxs/5juU+G++xWr1l
 VTjW2B7Z+QXEic+RiOjPxDcFWNTwIySIwFqlu5+CSxv68VSsXyxAAc5/XJuOaGfy4JuUaJQ
 Pk7GJe4ib3wvUGfPkYN8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RRpARzPRzPU=:IYEhSsj44DW/iIwXIL4EPY
 SnsuN32aGSKT74No6HIBQ+QAxuNTa/xmwyj2rjvwQWAvAwDIGnytANUEZzL9GhclN7YMD6Ng0
 Oecg0A5XTDPSUWidW8LEIdrKKdkUCiJS0gceJqIibgyTSrdrp1nw7GjEBXTVYnJvhXOGX4Zuz
 CqmyjvpaWie5+c5tG1pglgcotUg2+l2Vg7oJdDuMDPkodVcN5pwranj1wMNzIQcIMqpvQIp9F
 YwuBAmqsVRZOMGt2+MCbcKrJL50zX3Xx29vWt/CgFPWsNIdAAYncsxIsYHEBOhVbvo8aDM3ff
 cDyU6IDwwJTMh5bzagxz8G0eKEJCWzXnbpr9gHHx17A9dT/VNHAoxS/3xePAZkh/m4ATAPJd8
 f1z73GhgSH78kd8nTFj/BWJ7TyMaVY1R/9W+ZwKnsu6bGo8JlVBnOLEVESJTGLctp2O0NwsND
 3UvzrpNNeCAnvovRNdi6Qpy5yNcA6v+a3I3jyILGJADy8jb2S1EBmqgOMIh6QkykPdNA5QNvp
 WH8ZyDBQQJgs4e9KX5MiN1clcv877sq+5Zjv0yixZzv4c3FIbE0D83rTreflNY4xafjS1cBCS
 d2jl2JMIYzYYNwt20f0WuUnHBOtGs6FRN5+XJSVMWZ2F8sFHQEzXK+cG5IGlR0NeKVF5jOmXq
 93Bi6oF2oGS37doyr6Yi5CrA4BRxT3/bE84QBR+Og0VX9DafO7nfm+9la1eg6ZJG9OoYAHNaa
 gtMEjnUecgRzK1D6A+PDI4t62Miw+zRuEOsgz8oVBPja367xTskOS1cpZK+jL9fxLAjBG0nch
 el1hV+SmMEyw7uBiR4Lx75OkP1EUr9VZuIyoiYxnzuutGl0fJWwyLBZSbc9YvXh13p2A/0v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, 19 Oct 2017, Alex Vandiver wrote:

> This provides small performance savings.
> 
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index 377edc7be..eba46c78b 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -51,7 +51,7 @@ launch_watchman();
>  
>  sub launch_watchman {
>  
> -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
> +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')

While I am very much infavor of this change (I was not aware of the
--no-pretty option), I would like to see some statistics on that. Could
you measure the impact, please, and include the results in the commit
message?

Ciao,
Johannes
