Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F0F1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdF2UMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 16:12:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:60260 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdF2UMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 16:12:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC7em-1dZVV92VVo-008pAF; Thu, 29
 Jun 2017 22:12:15 +0200
Date:   Thu, 29 Jun 2017 22:12:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Gyandeep Singh <gyandeeps@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
In-Reply-To: <alpine.DEB.2.21.1.1706281527120.84669@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1706292210230.84669@virtualbox>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com> <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com> <alpine.DEB.2.21.1.1706281527120.84669@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gt0ekmQrJJBuWNx0xKkmWc4Ngw8w4YqXR8l8tpKkSzIUruOWA5O
 /GafKOs/SPJqkOgnJ/CekIMs5/CtFWTCFbSYg/0V6UWfxnRX2IGVVOuUfIft/ieZL5WnIH2
 wF8DnSlvp+Lu1HLhsri1Sri7s/Vwx4yKGbKpZCgI13G640zVRGX/PivVmla3OrZ9UtYXKC6
 Jrsxwl7QFmj6zIokR0wuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dIk1NSZ72I4=:Kt57Rp9cA2n2WOAsqF5fVM
 9w+TengVVKAGlN7hS6nXg1m7xJT5fQbe5N+jKFz+1ukPKtGlKyIzRddxmKLstXc1+Fsj2/fJW
 ISKLFm3O2nz7XYLsGsWRGx+pC3fCZLxAhdakep8mEf2uSmEW2Yx8tfqxSH4CgJAe6qDufkQPt
 oX7i1kuTvj/esGqoOR1eXPZR6igMOhm0pVd52igunQaQ0HOFygf9L8pPnNxcZXoZ6PLXo6Q1J
 FcTS7z7RP2lq+kLI78dDjO4b1p3c8KMU4sqwxUn1xE5LIKqf7SSg24mi/9xcBr2qeug4tTKlc
 BENoQWOulQ2qlc9JEEdWpqM/UQgm0btrd9aBxjY+8DreZCpwxrCM8y4+UedbokbKWP15VbNh5
 pp1+iKDTjK62M1ErwuSemuJ1VcZjIf4W/o8ROcgL2+r2I8Zf+vQeEUNefkq8ULR9+r69VGbnr
 8SE1icz/YgXPpIBS4n94q+6Pa8WOeMwmh4l4aElGt3oGUvFjGpoWUdJLhslHdZQ6pWf0zX234
 Ri4UAdmmzAbrxaX7npq2bo1ZB+7nbo4N8MK0/3kf6nJqgv1S6WA4W3Bi4qXQ7etFRWtd/iyUD
 OoW+LYvKBTia3k8lbzLPElKk80pHjLZrniA2CS4bCkYVYsZPYL+KBoPIuRvwFln1Qe5jQQoFd
 KQJ7/+Mxs7NM3KE0Psy7unjC+qMLERT5pD7maT7jRQAaJnTiuSSpB9kvzzlYJ7Am7JHJyl6Wr
 4Hj+ycELk9tYUoqxCibJDkut3uHU1c/qDmct8lkjyXfpFpL/aF1f1g9MGKF2r+KCqikJyWgyM
 x7xMs9P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 28 Jun 2017, Johannes Schindelin wrote:

> On Mon, 26 Jun 2017, Gyandeep Singh wrote:
> 
> [... a bug report ...]

This bug report was reposted as

	https://github.com/git-for-windows/git/issues/1219

In my opinion, it is too Windows-specific for the discussion to continue
anywhere but in that ticket.

Ciao,
Johannes
