Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBA020C11
	for <e@80x24.org>; Thu, 30 Nov 2017 15:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbdK3PVZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 10:21:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:53969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdK3PVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 10:21:24 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5tzh-1fIKWx2rXN-00xpsF; Thu, 30
 Nov 2017 16:21:22 +0100
Date:   Thu, 30 Nov 2017 16:21:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Robert Abel <rabel@robertabel.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <cacbf41e-3b4a-99e2-a0e0-50bb4cd9e152@robertabel.eu>
Message-ID: <alpine.DEB.2.21.1.1711301619590.6482@virtualbox>
References: <20171128201818.4132-1-rabel@robertabel.eu> <20171128201818.4132-2-rabel@robertabel.eu> <alpine.DEB.2.21.1.1711291519290.6482@virtualbox> <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu> <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
 <cacbf41e-3b4a-99e2-a0e0-50bb4cd9e152@robertabel.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6KV3h3D78OM7by4B7f0YxGHQzv70rx6T5P/N7HEu1lDw7/YywlB
 wGPpKO3fsuk+/VF3EBiO7DyTkQk4tMckeUK+Y75Nrgd9CkeSYhQ0mlTunkOgB020CiU+l5O
 4rdst58otEtMOgS7KJinD3uBorr/AFOEodieG1tXcFLaoIGzuCA1owFRqCW+jmNhOWtE9hv
 Wq7pz97YAeij8Oduq1ehQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:omZH3sml9Qg=:caZuqtRwxJxwXEgyyl4+vD
 hTS/KitaAMRwD58522EccNWyBWkVYRmdpNIhGtLYaVLtUScrNv5KGuXfMoCHoqxjNG6DjpEA/
 N9Olyuwsz5BZxqxUiUcdNq4dimJXttnGjCcOoJYq5dkpw041K+mOXx4c0Y03h+MPdTZ+RYeRg
 Q5Y885Os/ht6dKQJbyZBmSyEOeKSaPJ7/gPdIQTHlzIkuFpcVptYsm1RBgduxChN92StLVGXf
 yfhUv45uF6CVJZIv6hZVrD5v6/A5sO1LqL08A0tfNBLu3tTQVr5GF2vucoUbeT6jnguTQ0E1t
 kQYoW7r4RCSUl19r3EcB5Dlzt4Uy8y51lMhwZrnngIgKvcNpydVzmuQxVzXVC2TNEOkE8zsAN
 7Mh8oARLVA5bPQd4zkKxIrfMBrsfBkpjqxM6VX3ki/WMXWjZ9gkxwazHzlhCou33RZN0N3Pqg
 HhQdZH5EpV8AlyS9hBZ+1SI/kaA7v2zAgBihZiU0k7GALb9/eqdUPO0TFebB872MKT0lSpCBm
 JUkrz9XVpNnk+VQTvtFNwhipx6ZXkVqZI95pjmc5x/UllcZ3FoWWWSOAmsq0No8j7cyiqsjNP
 w4GcBCpJX4JErXOb1/F0e0FowDcaSADXYbXU+fj+sLVZrF5xOaOZXZUA9gMJfnHZ302Q2sC4y
 A/DaGPrTBdGkw8cNKhSHNWd+CewdK9jPYE/cSZcqlLMLhElBbpphDQXyhH3FOLVINAjzuXEI1
 J7lxH+409t05uP6Xd9WwRagy6HRFw5ITalTkSlR8nWt6+QdJUoqWTgMw2VrOZSD1tCPcTXcDX
 XIEQYXE8BngxjAS3oKETfpq1LDwEX5U2Zj72Hv8JT9c/zhbro4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Thu, 30 Nov 2017, Robert Abel wrote:

> So reading a dummy variable along with the actual content variable
> works for git-prompt:
> 
>     __git_eread ()
>     {
>         local f="$1"
>         local dummy
>         shift
>         test -r "$f" && IFS=$'\r\n' read "$@" dummy < "$f"
>     }
> 
> I feel like this would be the most readable solution thus far.

Hmm. I am just a little concerned about "dummy" swallowing the rest of the
line, e.g. when reading "1 2 3" via `__git_eread line`... the way I read
it, dummy would consume "2 3" and line would *not* receive "1 2 3" but
only "1"...

Ciao,
Johannes
