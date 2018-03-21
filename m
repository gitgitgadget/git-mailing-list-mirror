Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB8E1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeCUVur (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:50:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:44629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753734AbeCUVuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:50:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpfas-1eLZBs3jCI-00fOIf; Wed, 21
 Mar 2018 22:50:42 +0100
Date:   Wed, 21 Mar 2018 22:50:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Michele Locati <michele@locati.it>
cc:     git@vger.kernel.org, charles@hashpling.org
Subject: Re: [PATCH v2] filter-branch: use printf instead of echo -e
In-Reply-To: <20180319155259.13200-1-michele@locati.it>
Message-ID: <nycvar.QRO.7.76.6.1803212249170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180319144905.11564-1-michele@locati.it> <20180319155259.13200-1-michele@locati.it>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZoN9jXb0fF+8/vJ6DmocIT2HnS+4sbpRvkfXS2zA3gd6LJuArjN
 9+Bf4JJ7hdNuieT1JHynjP7I+axQGhXuOxUzzipVPQCcy86ZqsLWYswmDy8Au6e/Xt+Bbpu
 U4qewJJE7ydjA3rBL/9whCCyyBF7StTadJorbq5IWZRHj1SMpT8j21f2TyFPUVaIimk3TkY
 NmDGjcnoy7OcAsZEzNNNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5tp6wU2ugLM=:5zQhVbyRMEI52CO/01hZWv
 3n6JfrEAtIt7475fbtwlcFU8gUm857N9wkRiUafVnFQJkZlySYMSImxfBreNoEs8piqpRxVqW
 Am9iyQ90aq0nNQ7OMIfB8wBnE+YyAFDcek6+g73tfpq5T2f8rFFK94Fde/F5XokXD4NNuyzSL
 wWm/ohTAJRDc6NVoS2DxLvID6X0LlKKkTOoWq+Z5lO6D14VswW3+HkPKYnH4WPz3fAbMJVotF
 fDm0d6ImWOpHj8cVQrSqo22BqUvTfqBSj/9RMZ4Ha4GgriYCf31YtFKBteLVuOskeLjXA3oa7
 qGgW2T29kyNWlL0ralzr7ZfRc8ZECIReSVJREsCjmzhLSLPbgBFeD6p+yo1U1PTR+e8jlqLZ4
 INI3UgWuhSWsd6RczqL+MFgn46hCdWOpRBFj4hAxq9StACvB8STq3fXPLARuqJ/zEg4siy9vb
 siOmkIM+j5AHyfsodSdSAxthYF+y8m1Evmqrhdz3Ao2M9VA4w3ZyzefZadE9LTz2B//rqjxHo
 LRV+hYsrphmwrmPiOb7q4mWwdYEcqFGKRzazWRKUfN88xCMMk8xhYeyhNN7VguBdJyuD9LbEH
 RuHFymgP/w7yAoY8HPJChzJ1cY36bhRJWIQuh1S5FY4ZnoDl9ow/oueKkmI66VAfxXVeLoPxB
 pQkp395aj2iSSwiaKKgjVqlBvaBFOsVjKTfJ/lHDmPkup0ioNHXbDE1ZH7HD92uvc6nSkSQ14
 Tt02RartltlfxHkZaSSVB7rP8z/Iu85CBWc5TX/BBDGIn+wEEy1A8ruiDX7FTqxMbiftVuf33
 k1+Bmosjsg/sAq5vDk/hLHo4nmPHoVqnlEUqCnZBGI/QZXDdog=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michele,

On Mon, 19 Mar 2018, Michele Locati wrote:

> [...]
> -- 
> 2.16.2.windows.1

Yaaaaay!

Out of curiosity: did the CONTRIBUTING.md file help that was recently
turned into a guide how to contribute to Git (for Windows) by Derrick
Stolee?

Ciao,
Johannes
