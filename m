Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88133207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbcJLMqG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 08:46:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:59523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbcJLMp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 08:45:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LcnRD-1bB1lF1Xbr-00kBKn; Wed, 12 Oct 2016 14:39:06
 +0200
Date:   Wed, 12 Oct 2016 14:39:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support the --stdin option
In-Reply-To: <dc76476b-9ad5-a3b6-f12f-33cda2ca5814@gmail.com>
Message-ID: <alpine.DEB.2.20.1610121438400.3492@virtualbox>
References: <cover.1476202100.git.johannes.schindelin@gmx.de> <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de> <dc76476b-9ad5-a3b6-f12f-33cda2ca5814@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1476745715-1476275946=:3492"
X-Provags-ID: V03:K0:JO/ZIPbYvLJPWSRr2IawM+mp/rgxgKNR6CALXPWn87RRtLEjHwj
 9v4QjsxWcR/ETpoFQZ6ewvGYYs+iCmB0eNMNONtn7eqbhluX6qwC0Y7qFTiGnEMZ71aX1tL
 FVdW8fwguPscaiYNo+pqRDGJiSw/W/TnB/EWABviVizx2u29aPcjKB81AZR2nHaB6E/O+yt
 xjQCNhX6Gj+EOJ56dT9lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SJttVupO19w=:grTBe9jUFMtObotSi7NfDV
 cyC+6ozr+Y0FROzK8SZlIMAfUSkZ8Fb9A3gfLZinopJ/+lV+IabMt5RvBTXjzOWZl6dGCJ+iB
 Bp9mIKGVNv7XNLNewGGtYePfVae6PElw3KPcaudkzsn41qVAYHy9+WgzR2lTOb7ZvPJ3n0VAZ
 1aiNEqEZpWnS72xVTgHpQnAQKaRxXLhmR8SmVnP/7CN0QIdEORlmqdOBvndeO2eChCjzzRgA4
 ArOX9dF5ZiUu665msa+Ghr0tAsSLMOqJ3bS5fKjFdeasOumRg/Wogm4Z28pcXUV8TLUiz0nLF
 FpkWkqUE+gX/kbzykhi6DRlJCzyz/VyRJTvwLg8ZGVcMcP+eFZDdnLMA3j/HIeMX3+KCJVgIw
 LBrtCykVTgjBQL9uqYVYkzjO6BXCijeOOsGl43T4sKH3y0fQfYjiQBbqamIL9vUdKX4REuc70
 7RJ2ZeS4tRu2B/KfIjp1JJGqjNBOCJ66T1D9ZDyG92TzlFWJXK6AQ+eGSZrt2TiI7ySpFlzD/
 hvusDyYVm5GPVtCmXi2puAc9GkAjc/3GtKUunkEKM4934q/zN2ZijzhC1hBzMr+LeVuHaxmZM
 l5DqBw8IUPZEtwTMxozSXZ/+IwTnEi7DOzJucukfVjRRc9JbOl+A/dExhkEUfI0d+CK+Pb3Qi
 TyWf4wHcrbfqpAtlBe5CSxu0T1T3Xvoccd+uQ8ehJRBh7ZJzdGWIwsW3wsFFTTZNAQl0XqDv1
 btZ5IFXwCL2EaZ+ZncrrhOhQsQ0Fj/SHWQ+aCgIwbcrDf1moORbYh1sB1gAasHpwDD55nutmV
 xoUsmGO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1476745715-1476275946=:3492
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Tue, 11 Oct 2016, Jakub Nar=C4=99bski wrote:

> W dniu 11.10.2016 o 18:09, Johannes Schindelin pisze:
>=20
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git reset' [-q] [<tree-ish>] [--] <paths>...
> > +'git reset' [-q] [--stdin [-z]] [<tree-ish>] [--] <paths>...
>=20
> I think you meant here
>=20
>   +'git reset' [-q] [--stdin [-z]] [<tree-ish>]

Good point. I overlooked that the <paths>... are not optional here.

Thanks,
Dscho
--8323329-1476745715-1476275946=:3492--
