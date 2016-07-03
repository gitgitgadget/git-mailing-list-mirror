Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD22020179
	for <e@80x24.org>; Sun,  3 Jul 2016 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbcGCLvn (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 07:51:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:59908 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbcGCLvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 07:51:43 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MLunc-1bE95x0SZo-007ndi; Sun, 03 Jul 2016 13:51:37
 +0200
Date:	Sun, 3 Jul 2016 13:51:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	David Turner <novalis@novalis.org>
cc:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Subject: Re: [PATCH v14 00/21] index-helper/watchman
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
Message-ID: <alpine.DEB.2.20.1607031350440.8378@virtualbox>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WsUx5wmUUF/F/kFFTopIICdlKOBHGwr9lZ5ykEJGERtOuEIM4BZ
 tR+UKuV2Ry2YnfecuaPdXVMmCjHSXxI+yFr0hJ73jFCVDPfx0gGr/BhBMBm0HjczYgS7eSY
 wa03r0O72ZhL7DYPhwV+Q6iAhxuBkYkQeAQOvIUcIONS8+sBN44K3x7cAFTi9fil6wCeL1d
 sBxKwvIypL14BSXnsyUPQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9r1p1yMokcc=:fsYCqglU6BUnlhake+Xp9k
 LSVFYajh0S8n4sEScXC9YqLE8UbybIfpfYEkveezHwMUsATA28DV9m4mHVDiMK1t5zGyyvLZn
 P8X8OeLc50eyufMWbHWS9PQiPc8AkPsG2SY2CsOATQZZkqEfmtye0nDo/YQExwujJfIBCtQIj
 wJYJ7DMPGdieEN/o8cWjQQuGKKsprsiHmPFHouwQOUyPX+X4A0tba/qGBBQCCKSK3AKxAawwB
 gE9ZrgjwyBdZK/bBhbLfmi03ifIjURszbOlyvKvHvaqA5VDcBzUsC1iK7U5biI9RaA55E1axY
 0LNtcM/wDUQ2UVSpsR8n8/KUN/7+3E9n63w3Gh3o/HvdGpHHTcP1Mle2I3TgqZoL6R4aveRdK
 R8w6qam+gY8fqkGYIfD7glQ3Xows4X5CGVfXVPNtnyC4xddCk3wyDc6PpCia4JWvuoY7iyY0k
 QdTZUzxsfhILYXr7mnNGPssUowR2l3bQp9RhzW10phQ0o8JocGKB97+kM7c3Aw6Q1bVHdmJ0S
 TdTJdaWCmuxl0qmvle8MytmVvG/oouyWvJHRiCFR/hr47/mLbFsbH4jEQ4ZHmRfncnhIktn3K
 X2nMx3D7dA3z1hKQ7X07ftGU5bDn7o4raA1DZD3/dV9ItEOXqyqSfICvlQbw9SBFll5QTuQi1
 16fxN84aFxEcuYlYPXrn4PLivf9dX4XSzIcLnMNWZa8mx5Y0MrHiF7umXLJYuSpn/QwdvIBmU
 oBo2nVon8Gz2nF+sp0IOyuoOW0AAZQoplTwmwRCYY5adDGP78hC5oMcsjOyFEQQo+ri7nrosQ
 ggbOgmR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dave,

On Sun, 3 Jul 2016, David Turner wrote:

> This addresses comments on v13:
> removed unnecessary no_mmap ifdef
> add an ifdef in unix-socket
> OS X fix for select()
> test improvement

Thanks.

Would you mind re-sending 20 & 21, they seem to have gotten lost. Or is
there a public repository where I can simply fetch the branch? (I am not
really a fan of applying patches from my mailbox...)

Thanks,
Dscho
