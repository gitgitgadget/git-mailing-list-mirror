Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983411F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfARSOd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:14:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:47837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfARSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:14:33 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBFUT-1gulG20bIr-00ACSE; Fri, 18
 Jan 2019 19:14:19 +0100
Date:   Fri, 18 Jan 2019 19:14:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
In-Reply-To: <xmqqimylludk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181912460.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com>        <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>        <xmqqwonkclpx.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1901181443350.41@tvgsbejvaqbjf.bet>
 <xmqqimylludk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xPxOGkOGkIv96Mc8ocjmmr3m9u8itzXXyEIgi8ZkoARcwQDHlUD
 xq9mXB7/isLRq5PWTC2o3bqDDTHJkw8iiTCPjueK8JwBaq9u/uFF/VF2g9uMC9/ReDWfQ6N
 MFyHLE/sM+u5ORjqwbdq92/mV1acwGldmyO1xwnZuSfi85IQtO6uy7MUqxHvwoO5wQINXZF
 n/VhS0P7kjgfm0uBVUttQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nNHSvveEdEM=:OE1gTMYfIwI7dz6DD1cN1w
 ZjpmZ/89g9o+Mk+1gnTqArL0Rmr+4FOSU6iRGEAmsbO8Mnce87RTuw9lJoG5ZolsU1OCNLQZP
 nxfZ2tqpRLX6kb1wIgIdOU4w+arVoz/hUwj3KxXszOkPqG7M5olM2mvR85C+2w9Wvvl83yeTe
 CkYS8T0aIezlk6dwqaqTqUe1OwVkzZlI8NZba0+OnftuHGMTBFBcuJP9vnb9OJiuwQCtx9eYZ
 +Gcp35PQOdh4R6KVAt4aM9VX/wiDH3MF14Rcb6+YgEm1xvqxgSHi7ZGOwfxJXRgG/EUvQ2pAy
 9vNuNL0vQ16FR7OVekH2n5Zng/YuEpNW8Ta1k2se2gEnVoPp49KAYiMogZGd6MUrVFZQLMRPN
 rn3mpO3twtTgQ+AgV6KZZzqj/RO0g46z1suaqTydnQVSc7PuFKwuTg8h+eFHZdc6iIpbop2eN
 ARfEucPIVY2A27vJ17ckWIKegUCAEl/v/iwYVmG+jX3WdZn+WjhgEVvHlpMObfQxws2yQTAMZ
 HHE5eurWlZ11niyAEdo6pHq6QTiLZd+/fgiFNcwq+u9+gLKmXQ1o0DqWJHcUHbjzQkJE6pV4X
 QXNbdFHXUdKsD3hrwBMQqR6T6eqDXPWOE1nLjYSC91fTWE/XyntsqPa/Fx6N6YApPwBwfvtFo
 TzSUULze9ordd/YiFwUu/m9DSSN3ZOWVh4WdNZREhSjnK+KTGiMi6YUOJQX5hH0HxZtma64Ec
 ZtG/uURBo8N18hUEYfHlUCyNLQN+zWeZ952igEvI+z44hm/ZC2rFroWLcaZXylr3Gm98c4jXv
 gWJTEmLHPEx8f7DZBCORA1CqY9qoLqOWnc7E7tFznhSr5UmIJudjGbEcsQnxd3lDaSnH+g0Hp
 /K0O5pU1jzZoUO2vHjbAXyK6rgvT51SD6jcwAodW6BoldhUeB6yZ4SgRlNG+Adf83bKtHGhkB
 iFwEApDj75Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Overall, this was quite a pleasant read and a well constructed
> >> series.  Other than two minor points (i.e. interaction with the
> >> 'post-checkout hook' topic, and discard_cache() before calling
> >> move_to_original_branch) I did not quite understand, looks good to
> >> me.
> >> 
> >> When merged to 'pu', I seem to be getting failure from t3425.5, .8
> >> and .11, by the way.  I haven't dug into the actual breakages any
> >> further than that.
> >
> > Sorry for the trouble, and for my silence (I was heads-down into the Azure
> > Pipelines support).
> >
> > I did not see any breakage in `pu` lately, hopefully things resolved
> > themselves?
> 
> The (semantic) conflict resolution can be seen in
> 
>     $ git show 'origin/pu^{/^Merge branch .js/rebase-am. into}'
> 
> which is recorded in my rerere database ;-)

That looks all good to me, with the minor nit that you did not wrap at
<= 80 columns/row:

 -                       "--no-cover-letter", "--pretty=mboxrd", NULL);
++                       "--no-cover-letter", "--pretty=mboxrd", "--topo-order", NULL);

I am not a stickler to this line length rule, though, as I long switched
away from the 80x25 screen and can easily resize my text windows.

Ciao,
Dscho
