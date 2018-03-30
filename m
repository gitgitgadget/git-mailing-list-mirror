Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697121F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeC3Mhv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:37:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:54925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbeC3Mhu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:37:50 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyVIk-1eVcpB1TV8-015pdT; Fri, 30
 Mar 2018 14:37:39 +0200
Date:   Fri, 30 Mar 2018 14:37:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 2/9] t1300: rename it to reflect that `repo-config` was
 deprecated
In-Reply-To: <20180329194221.GC2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301435590.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <6023d70cff199424893d116339f860952c6a6b4b.1522336130.git.johannes.schindelin@gmx.de> <20180329194221.GC2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7zG4kF/sKOsfo7xZ8mFd1xpgAKI/oPjT0NWmidtpkB0MUgIa/Yv
 j1orKvRU3LCdHkk8XOorZRHpxMuI6DtJkqRMZFIPJrldeTVBWrmyPAz+76lkVZgfDOY47Ak
 ASOlbBR5RV8SfQV0ndcQi5fSEZcSAfcfEkjBWkgTA2HHOQYOIMLU8cpwrCiQJEPDtgcYE/N
 dvQ864wlGugXHMMrZWuRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dkOot+TgtIc=:fVUIuQCBF7vPmWVm5sCY+U
 BjKibfqq9sx8w7dAQAu3aO7IsEAtG/4A4HM8M9wqw9z/5RWFyEEELLw6shtvxmaJ3thSRxMLY
 mqRPvEqDIgHq6w5/NaN3L5HmjVEkrE4Vc8vOhTJvReY8VADQlafSJtz9LgET3hmb9hMKH12s0
 WeSWrHfQ5XZbC5yCPJp9iyv90IB/4xTwcV+u8IZKek0O8xPzKfwXjCDCzH58fuOUb4MaMlKgD
 k6LdWOEayzIMhCgYTIf66nK8JJa2idD8vFJrUoC+w+SKg8uVvxprnkINu6CrzPc+JNd0o4Fzv
 EbfNqKYAvmYiHs00YbpCnEhPPE2hoIlf05gIQXW3uI1hCO0ZZhqI9iBC/YS2Ifl9yhJhmuaFI
 6EE3lsEJsHIN18E9Y7KYv4RVU+FMKGjIDbRk4QSM0Md6Z/MINuglLhNndcRytFRPhHHglOkf6
 qDqJw7B7tIZxBWi14N+7Xiag4ufVI8ILqySnF4N1IF+eD7O83p1YkeQ9hj+uFtApKdIm/q/P1
 1wJWYQA/MIWhsFheyUZlnFBV51IqFEe/P8vHnONSYaWoYcPL48eUW+Jypxx2IDs+nae0vf51C
 WPZYbOiYf0rEQ3aSeUKudNXc/Roze/Pqr3isFZZbaGcbxfVdtvRCxRFNu5O2qbV57AYcdbKHo
 qxTxbqKoy9hhXjfxlAHJMvPZJ9fUAgaAZRWOD1BvQme7uwMcKMNUFXo4Q+I2c0Y2yKHwcqBwn
 OskyVD+Ts4Ux3NslYRndTylpPlghP3006hxtF5daSQh6zjdv2+ak9QTTgdYc/yroeR3/Rco46
 dFVBi0i+J+oyV0VzoQiC//aIGSXHhKmIZzVikFsBX36YzsgwDqx5fIyGsHyZKJ0I0wdQ+50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:18:40PM +0200, Johannes Schindelin wrote:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/{t1300-repo-config.sh => t1300-config.sh} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename t/{t1300-repo-config.sh => t1300-config.sh} (100%)
> 
> This has only been bugging me for oh, about 10 years.

Yep.

We should have done that right after moving the builtins' code to
builtins/.

Which reminds me that we *still* do not have a lib/ where all the source
code for libgit.a lives. And then maybe standalone/ for the source code of
the non-builtin tools. And... this would make for a fine micro-project
next year, I guess. Or in ten.

Ciao,
Dscho
