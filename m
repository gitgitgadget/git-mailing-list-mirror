Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDA920A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934792AbdKGAwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:52:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:56206 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934704AbdKGAws (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:52:48 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNIi1-1eIDmV1I7d-006zjS; Tue, 07
 Nov 2017 01:52:42 +0100
Date:   Tue, 7 Nov 2017 01:52:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/8] sequencer: simplify adding Signed-off-by:
 trailer
In-Reply-To: <20171106112709.2121-7-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711070149490.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-7-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UXSduzCkSaep3M5QENF75Azx/lxx0f/cClvjDQA4Vo8VPzE7UIN
 AV6YO57mfSmhodjVwxJUTXCtX87os2rIOn1vBC4mffNaK1IiI4uZwr/V8bWEVGJuCyL3/J0
 CgYwWP1Ay6qtaIw0ZB3dKheOh6q+v8nNFdv59K+AkW1vkWMRobLR5IDbdLDJQzPQcDpR7HD
 EMVjeQSR8mE1bLDlV+fmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tAWRRsUZCwI=:pWF0RHIlKiNFV3W4p4g5kX
 oQ7rHC5vyBvwmcp+EEVnlznSDwP2PUnldDgxJ9kyP8uUfRmbj6j7as+eOkN5QORRvsHIWFBlM
 a8INHfdRossHzwcmldWz5bymGq0stLt05tvH5PhGxTcDCsKHLp9Btjvl+fsOtdnFqS5EU39IY
 AEdf4y9dj5IQjFL0r7c22/t9g+HQOgNUi0OldkxSKaCfSiwdR3Tq5ytnUxn9lE7J9Wbt7tNCo
 If5TyHU2d+ZZOBqGmEp/9aAf4WN1hX5jkuc+A9CxEsATYUAScHAeIsCd6PHWrBJvoR2rPdVl3
 UGCR5qNH+BFM6nFMu/79lmdS5Dwkd31THGFYs0ExBN072RvgerE6pG6gltKuJnyzLLkui0SdL
 q34qt6VPcJu8dopD0CR2OZD7LJ0FEwfYoYjFfaELfJNGrmbEUtHCZdMpVsP8Grx5kd2Xz549i
 CMAmQ/KJok1xeJcfZsi+0OHxzYeodvEcG4z6B5+jQWsGclDeyxyXvHvHsKRkw1hoIPUI5zBQD
 vd24GsE0PdRJWzoteD2B6um3mqigZEkIXA7zql9sVqvMpPDVcjkmBvQHInRCEyLPYuZxcCXGF
 OUHtA5x8rHoLV8psG3bMgVmtxeipsAevSvRrNYDh9UySNsb3+34q/Ga+x2pVL/NwEMARFiJMd
 lgBDOXSM2LSCBZh/i69IDMsWcDM9MrAsHM7Jo+miNj4jicYeltbS+dY9pzTts3/1zuym2C4UC
 UJRaXvcpMp66AlpaV20MlkGZkiAoghRHQQBjUqoI80e8HR9U1xHnwYoyKu+kz3HBLx6saDgD4
 HkEE9GKseP9NP/tgneGPcZtiYiXMw+Q2g9yv0V+SAuVIEdzi7Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Nov 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Add the Signed-off-by: trailer in one place rather than adding it to
> the message when doing a recursive merge and specifying '--signoff'
> when running 'git commit'.

I would find this slightly easier to understand if it was written like
this (and separated into its own paragraph):

	Add the Signed-off-by: trailer by passing the `--signoff` option
	to `git commit` instead of adding the trailer manually (and only
	when the `recursive` merge strategy is in effect).

> This means that if there are conflicts when merging with a strategy
> other than 'recursive' the Signed-off-by: trailer will be added if the
> user commits the resolution themselves without passing '--signoff' to
> 'git commit'.

Nice!

> It also simplifies the in-process commit that is about to be added to
> the sequencer.

Also nice!

Thanks,
Dscho
