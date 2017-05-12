Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9904B1FF34
	for <e@80x24.org>; Fri, 12 May 2017 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbdELOs4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 10:48:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:53687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbdELOsz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 10:48:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX4u-1dAHnt0HiW-003Ldh; Fri, 12
 May 2017 16:48:53 +0200
Date:   Fri, 12 May 2017 16:48:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Josh Hagins <hagins.josh@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Git 2.13.0] BUG: setup_git_env called without repository
In-Reply-To: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705121643180.146734@virtualbox>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NPXSYL11uy9wZ/Thqdf40lRLF6Ta5hvKJ/qMjpvCstgdvcDdLgB
 fk+BRIdYyURm5Rn8Hw7BfjL0uqkTbaPJBM9H1wUKUFWyw0mgVNApPYyWLAEG9dY+qU9vU3P
 Hb0GmHSwFtAJKbbkBJ6JMFy/yWBeJ2lqBI23K+Ym8CdO1LrtHK8w4hgBrQHsaa5OSFTmdo5
 Vb/tmN9byQDPmW39/o3xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IcAbGP2H0mU=:0bzSJIV/jnG3KdXCq2VpT6
 Gp1S6/QD8LykcUEkt3xL5XerV1yyOYwFOsJUQ61LTmFcdcm2WUSsaWSKZyoEcnL3Bq89881T0
 VhdZv/05wRiZDYWM6ZiNzd364EKSMETtkPEfZnRgdpQCjcLpmgYtl6EfyxrUy99wNzo6KSlAd
 nIp6PeyWxWryoPSV4ZKVN37xE4VrF/AqzA0zpDnNpRJGpJu9RSfWHwqZtb45ZMm4caTqth002
 BLNiUrqiJcRk8M1xoRAVxlsH0F4Fu5r8xn6LttjDAP5D6V4y3hsVAZVXxoBryiwrrDvSTXDSU
 iMQTpL15jlYbF5hcr+vqIMCMvTxtFb3yC7SDDn/BEXVEtFpLFSbdCfNMQx2kiNLT/m/RwVc03
 PMs8qo9QOg/etbSI3TcvYUC9st1DsQHY2BOmz1vkXyvRPERNuHbNvkBbO91wD451E3tl1hu7t
 9Vao265qa5t9kpeaR3PZE/CVq/R0XEOsM/+VbmKoMZ6ddc6Ye6X2SUD5hYP62EVj2lpeo3hCg
 x6Rp35dxDrOyI14mo2ORoy1zOj49eTDh+yViNYfzDoSOIfoVBJ/MfBL9AUQmzroXcGOIOiffs
 dp4cbGScagiBHAuGd1otgTBafNwbnv9tD1EE0PPnfc+zAKh1bIsdZb/leDD9gz1WvSgLje3Eo
 BiiRdqnjsPC5CrrydLH3d0lxNK/8F6Y6csxwxu5fWgzPll6j0mVVYSAo2xgkYVATVqsB7zC1K
 wMaR51/YC1MYNnghGzLwa3pHH8WS/y4qilRCQJfYfudLknzH+95nKNxQpWpONITiO+jdr3EPh
 P1J5Zr1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Fri, 12 May 2017, Josh Hagins wrote:

> Since upgrading to Git 2.13.0 I'm seeing this error message whenever
> `git config --local <whatever>` is called outside a Git repository.
> For example, note the difference in behavior between Git 2.13 and
> Apple Git:
> 
>     $ pwd
>     /Users/jhagins
>     $ /usr/bin/git --version
>     git version 2.11.0 (Apple Git-81)
>     $ /usr/bin/git config --local --get user.name
>     $ /usr/local/bin/git --version
>     git version 2.13.0
>     $ /usr/local/bin/git config --local --get user.name
>     fatal: BUG: setup_git_env called without repository
> 
> Apple Git outputs nothing, as expected. The summarized release notes
> published by GitHub specifically mentioned that instances of this
> error message should be reported, so here you go!
> 
> Please let me know if I can provide any more information that would be
> helpful.

Since this is in /usr/local/bin/, there are two possibilities:

1) you built and installed it yourself (but then it would be more likely
   in your $HOME/bin), or

2) you installed it via HomeBrew.

I guess it is the latter.

In both cases, however, you have XCode installed, so you can dig further.
Yay.

The thing I would do in your case would be to clone Git:

	git clone https://github.com/git/git

then check out v2.13.0:

	git checkout v2.13.0

then edit the Makefile to remove the -O2 from the CFLAGS (the next step is
to use the GNU debugger, and in my hands the -O2 optimization made that
pretty useless), and then build with

	make

After that, you should be able to start the command in your local GNU
debugger:

	gdb -args ./git config --local --get user.name

You will then want to set a breakpoint on the die_builtin() function:

	b die_builtin

Now run it with the `r` command, and it should stop in the die_builtin
routine, in which case a backtrace would be most helpful to figure out
what is going wrong:

	bt

If the output is not enlightening on its own, it would be nice to paste it
into a reply to this mail so that the entire Git developer community can
have a look.

Ciao,
Johannes
