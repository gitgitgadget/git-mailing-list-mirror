Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAC920229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756521AbcJWJfE (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:35:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:64938 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756322AbcJWJfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:35:02 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MU0U9-1cP1OD3ytt-00Qil2; Sun, 23 Oct 2016 11:34:49
 +0200
Date:   Sun, 23 Oct 2016 11:34:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 22/27] sequencer: teach write_message() to append an
 optional LF
In-Reply-To: <xmqqmvhxbljm.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610231129410.3264@virtualbox>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <d858bd99a3ad3dea807f38b8bd42a221a9f7924c.1477052405.git.johannes.schindelin@gmx.de> <xmqqmvhxbljm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NzPgpe8oTJKlHH1Q5pF0QD9seose54JhlHtjAUfL82wyehLV05x
 6KcRoXAP/pRnMsAIMyE7Ms7nak60xyR8X5GaFoHBA/Y6cDMBoirwK8QXRnP6A3L0j6IcFpP
 DWvOuW6c6O2DkMg4NxpQQC31LNu7DoPV4oUBgXkvrh5Iz3kpw7KH2SVbNeNWJIFmiBZYbqc
 xrIN/cB2WYxMoCPx1/0Mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xxVW+Te14zc=:O1+unu+NZl/f+ibkU2Cr5q
 TeRNzwgFNQyfo1NQuVypcVFM1tQ3owY8/Wq0gp81H1zbCDQda9meEG6B+kHsUeA98BDAmovpW
 Fz2La/mVv0+A1MwHGNfpDf/uikowegfJZHzLYrwHEZdYzveobF+6NCgsya04MfEIUBU7iNXUv
 NVJb0Q+Lo9EVoavNOB4ahcJkeKEn91e6hJFRRSvUVSUsgzhr6SkjywFOPUWcKPx3Mi3yP1eiT
 1+nJs6rQLLtSAacCJZeRE1rhsUDNdVg9WFfGy1s5a+/kmm8ch+XAvQUkp5sKE7l2Yq4dzF9IM
 D8vHbIRW5YMP4SFb6H3ohBllcX5K8IpsND3JGAipY34Djnk5bndgNgJu4OaKSczTzdfTJKmEB
 V15PT694vd6l/lR5PMJP20KETDDR/ss2d9tny/mi3enL1xERIJzK2CA7ptmxxf82WfbfTEA71
 eK6z5zaIVKfvrpVOpyQp7ryQBx7GuUH208kjbLVvnVbEO3uv7eE1vRVgjGFC/Wpr6OkcFYC4Z
 gUTBc346pusgVY8lyxjLAbAPL/VAZRNaEkx/FybmtzcFnuGXC1pmCndeGzH2oyxEzolHIRKjk
 8lZPMzyHWA4GCn2wSxTAAMZxFOx4HpCAS60w4aLMLnFRh6kK/5ohVWXfKQmfBcI52UdoanvOJ
 Taf6N9K6Em/NPX15C77PVIPZwlt0IwJE0pUr7VpZ33ke2vzcYc4FQb11bBXF9o8otP96i5r5p
 CmR5JKM9MPBCLlaMHv6qWO9oA6OEigEA44+lMcTJ6UgqaVTTfm1uV9WDwQOXgps7nh+8Yu1ww
 +k/aRwm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This commit prepares for future callers that will have a pointer/length
> > to some text to be written that lacks an LF, yet an LF is desired.
> > Instead of requiring the caller to append an LF to the buffer (and
> > potentially allocate memory to do so), the write_message() function
> > learns to append an LF at the end of the file.
> 
> As no existing callers need this, it probably is better left out and
> added to the series that actually needs the new feature as a
> preparatory step.

Apart from this patch series being semantically the right place
("prepare-sequencer"), there is also the following consideration:
The next patch series is already quite long. Taking this current patch
series into account, which started out as a 22-patch series and needed to
bloat by 25% through four subsequent iterations, it is probably not a wise
idea to move this patch to a patch series that already weighs 34 patches.

So I respectfully, and forcefully, disagree,
Dscho
