Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D031D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeAWUTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:19:51 -0500
Received: from mout.web.de ([212.227.15.4]:51863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752535AbeAWUTu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:19:50 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyUha-1epaFh42fW-015ocQ; Tue, 23
 Jan 2018 21:19:32 +0100
Date:   Tue, 23 Jan 2018 21:19:30 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/6]  convert: add support for different encodings
Message-ID: <20180123201930.GA23019@tor.lan>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180120152418.52859-1-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:8HIYI7wOV8J4P/risOw4KeRM+8nO3GKNhVKQRuQewrAgDfU1u1/
 scVcbcE7fZanVKit70UhVT/jxa2m3A+gSy904TWKdhpuaQMTWjak+MvzcClYAIx7y/GDVBp
 PuEAmb3qUiuWm4cPzTS9QG8djR15fDMj49FkzYOSm/ZtO3N3iDG8eKlV+wm0xykAjjsmlzY
 SZ72feYFgsAXBz7S48pqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2SXm9/cjJ48=:3f3DhKotw9VssdwBxclvTs
 0iUFsaiNDxWPGBfLE8zh0POmhtpmresLOHNZkMsGT76hbrqzOd/9vcXX8Wu+yDbtxUYgFq1VU
 +HrotH+lkpva8ltVGuXnfFlxKc7W8513OWhhiVajBEczG1VRDfMtVXwmShVUK8GOHk5Uhsbnq
 inYJUqTkFj1ZXVza6tBvxsrxinQnHtUeohjzaSdSRGB39T3OdnHc12m4UO5qgc8Y2FUCkkCaC
 UaPmrTlvgEym97ug2tMT853LsgzakVbs8vubBboz7toIF44Kax9sr8dE6PAvC9EVR5VjaVEby
 93Va8DNIBPTP2Lftv8kf1zZSifgrXL0HDgg4kJ07vYoqkgwyC3TnK+J9aW1TPoIyW9SaqtNL1
 rVuHzQrRQAZ6EhsjYCRPBdgFOBSDnYpW7EHnmIXOIpzdjoWyTy0Z2CA1Xcyu7sLX+FzUnSAma
 51fw11Ud4bhcb3y5PONX+U91+jNBp9yrc5iN0w7L39qlBcAbHPEEBpfuEkVUeX6J9yHGmbh3R
 zkjJoilKeIGkyT1rUa5DKxrau0zXHIXmVZhCZOTpKOiPUlAsPgGeNo4ADUr1w41bRCgY0pUp0
 cs6cbuREmBMuHCN0KW5ESkTrg1Hob1lG4QxOAg1D5Gz6O8JE8P89zw3wpJ+gBoZ+l9WrJB2tt
 oRfF7fTX3yOOEK4K5bJ2PVi2W5unG8D2JOL2oQ5em/7Ni34sc3by1dRZPraDJ/ZocK2Ufbfbp
 Y1OcWP6lmaRPfSol6c4tkAlZBxYzQNSUdtilooaUaLLhEZ/Ze05XQP2/8g3zYWS7ALwOm0Xlg
 3o+p1wJPKXAKs6rZvmWotKTqe0/eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 04:24:12PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Hi,
> 
> Patches 1-4 and 6 are preparation and helper functions.
> Patch 5 is the actual change.

I (still) have 2 remarks on convert.c - to make live easier,
I will send a small "on top" patch the next days.
