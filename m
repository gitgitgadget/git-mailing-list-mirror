Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9311E200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeECUpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:45:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:44369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeECUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:45:06 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1fFi0f3M7f-007TCa; Thu, 03
 May 2018 22:44:58 +0200
Date:   Thu, 3 May 2018 22:44:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
In-Reply-To: <24af8d6e-da6f-2d0b-22a0-6a2a215ac55f@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1805032242510.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de> <24af8d6e-da6f-2d0b-22a0-6a2a215ac55f@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OdyLVQ70woTwPSNdp1larTQcyajtm8aEfTQjN+G5EScaK+WLniF
 2PKh3HmU45eqhudC5A5/Z+hSB7912vvdIWy8YNVs/UFfGmFT/B6oTgbveWAnplRtcEBut2D
 jTRPPEiqJy7Bz4rapLty/4Fs8RutPxM7qrcB/oD02Spp+6u+1SEegamy8Vsxca33fSzqRK/
 /Reulsj85K7h7kzVhNOUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0db7FMJgGI=:uIqt5M9LtHp4FjGiBp/7I4
 gCjL+xQNuxY6BG9AjBAge/lr7n9pm80U3h4i1pnSAWh1jujwjK+HA4uvic48uOV0kJ2qMIFcb
 BVoT6I5sMj+NHwykrK3bbPBxR0omvmrPuOv7462Kl5ODGd4K4voFQbJix7ixtcLemxr4Wrnmi
 WMLS6r/JTrWQsGGn5Iv1xGkcn7ItqGB0T6G9BGsE+E3In+/Rm/gPKPpR4GzDbRiuS8YwQg2aE
 B3UEF1rBCAm8ssAn0+CgxcL/8l8TaNgZn4eH9tQdqHXOA4iVqdzj6U26nCG2gGQJHXuUo0qN+
 7oRo/p8gd5qSh1kb9jGkt8yoQf+hszyQx5m4QYwtTSmZT+nsGc6mgKxGsnqEhhTOp8hFgETkM
 JMR2SjruRmmm+hWEwOFJBFZxB5ZCgQEoBxfh4ZL59xqg1Y2CVZno8GkLgb8Z6ODOjz+pn6AB2
 Eh1woBZxX3FSCMpf+2fiFs2GTbKsmYuP4Idh6a/7q1wZZbR4CXKTH7fYIqqx0Ym8Wi61nYrkE
 M9iS8HCOilGKXLJXvlmzxgSGygu0Nkb+Po3thknaA4FNsySOzz32OmFMfNv3GY2xx47xtLxaF
 dKlmsDALFBPAuG6aCCL5Ktcrh1gr9A5AAhrjmHvRvsF+w4Ppxf6SnJN9FvSl90P+OlfOyoEsi
 bGIMKtw3ZYrwhVgCofUk0806ryhsjGs1rwGV1WiTUM6WxECneCX4yZyR2IsAyObVosUTO5I8p
 ARnTdmHkaUjvetGYgit/j5oPLdKVdGN8punao03xBJfJE478ophGnPg0jhTQaSnyu76wysqrc
 iGko/7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Thu, 3 May 2018, Ramsay Jones wrote:

> On 03/05/18 16:30, Johannes Schindelin wrote:
> > At this stage, `git branch-diff` can determine corresponding commits of
> > two related commit ranges. This makes use of the recently introduced
> > implementation of the Hungarian algorithm.
> > 
> > The core of this patch is a straight port of the ideas of tbdiff, the
> > seemingly dormant project at https://github.com/trast/tbdiff.
> > 
> > The output does not at all match `tbdiff`'s output yet, as this patch
> > really concentrates on getting the patch matching part right.
> > 
> > Note: due to differences in the diff algorithm (`tbdiff` uses the
> > Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> > calculated by `branch-diff` is different (but very similar) to the one
> > calculated by `tbdiff`. Therefore, it is possible that they find
> > different matching commits in corner cases (e.g. when a patch was split
> > into two patches of roughly equal length).
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/branch-diff.c | 337 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 334 insertions(+), 3 deletions(-)
> > 
> > diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> > index 97266cd326d..02dc06a57ca 100644
> > --- a/builtin/branch-diff.c
> > +++ b/builtin/branch-diff.c
> > @@ -1,13 +1,17 @@
> >  #include "cache.h"
> >  #include "parse-options.h"
> > +#include "string-list.h"
> > +#include "run-command.h"
> > +#include "argv-array.h"
> > +#include "hashmap.h"
> > +#include "xdiff-interface.h"
> > +#include "hungarian.h"
> >  
> >  static const char * const builtin_branch_diff_usage[] = {
> >  	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
> >  	NULL
> >  };
> >  
> > -#define COLOR_DUAL_MODE 2
> > -
> 
> This #define was introduced in the previous patch, without being
> used in that patch, and is now deleted here.

Darn, darn, darn. You know, this macro simply won't die. I tried to kill
it off but it keeps showing its ugly head everywhere.

I *think* I finally killed it for good.

Thanks!
Dscho
