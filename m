Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEBF1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbcKZMr6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:47:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:58510 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbcKZMr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:47:57 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lvkwm-1cn6Rl3poi-017YHm; Sat, 26
 Nov 2016 13:47:50 +0100
Date:   Sat, 26 Nov 2016 13:47:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: Re: [PATCH 1/2] cherry-pick: demonstrate a segmentation fault
In-Reply-To: <89ffd6eaf4e1e121426c84f31dfc9c289f2a948b.1480091758.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1611261336240.117539@virtualbox>
References: <cover.1480091758.git.johannes.schindelin@gmx.de> <89ffd6eaf4e1e121426c84f31dfc9c289f2a948b.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CgeRehCcRekFJFPFElgDIPrcGsBPCCw5SdO6eTndN72Xmll5x9J
 JjoICkdXY1AWTyumIhCaIezhTa1KgsnZQMjjLC4BjHog2Qp58lCE5+4IqAgdgEsrxAwRW7i
 U6Gu89y6Pa4xiR6BVjG5T3/zBkHWugNF1Bp7vIgvsDkyx55J5idhHvlYB6Q2byB0Wt8LTJs
 OJWQm0vsHFp2LoK1be+7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T9S8cTuP/M8=:NrIvlH9JTuybEzLKd0ltVW
 BP3YMeoMAWwf4R2QBI/HLDn4vFNmQDkIFEvtdGllhs2n5xu5kVZHUTuLbAooy+5rOrnTVuAdd
 f/DWXwvruOehwek8l2KdCYB6jBVUM3Vh2pOz7djk/s6AcyQ5rTgGvoOAivqvQ2HqBNZvSIjlE
 +gs3tZQIzwU7G+LfdOX5CoVVn9+mXSu1ABgpxuP3yd41sicPb/dChqxlrFqIDHHIL926u17IJ
 xZZsOWr4DmVy2/RLKc0R7i0YaOfnqXqmeUZCsaJhHFwTo9vieFhFVEw5Y3icXA5d77kOkSWQb
 ISC9yqm+1K/rCf76ke9c+OgvkRRMpV6yriOlCRPrWPhOS/UWmV71p9ikYdpEtQNjqEuM1pLOM
 alqS3ePo+AA7Mi6vkPjSN9UfW5Nsbi3MZzwaAlZ+ft9eNL08DoaVjiO+8Ce3GdMQSS75HpMOC
 xga27Evoh43Snlrcp5gDMwJqa4pgdtxITrWGK5wZieoC0TsVrNgucJ58D6ZRcIcLG5bDOkFQg
 SPQtWFoJIlbyJmT9nRyL/L7yACZ07PXMLpvIxBfYO1WVnecOM2c/UdQ7svWuscqKXnzcbFd9x
 MBwTsEQt/p8fPgwjG+ZXyfv6kgf+qyIpz+a4nMf6SVXtSnVip1hFc3UkxyV4fAhJYOtoMQS2K
 6hm+MqV0JXBmT/D8aTbN0Xx71zutOJzXZqgJORK45zWAHhit6OzPB7/oUWMF6wgzE7WGgA+xt
 mSGpBVq435+dWdzIPFv0vBRGA6ni3QxG5UHAIksvlg1z78FADdZvjUHtzIWHM/mGaiEX+HgCK
 RwiPYj6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 25 Nov 2016, Johannes Schindelin wrote:

> +test_expect_failure 'cherry-pick fails gracefully with dirty renamed file' '

Woops. This title is wrong. It should say instead: 'cherry-pick succeeds
with unrelated renamed, dirty file'.

> +	test_commit to-rename &&
> +	git checkout -b unrelated &&
> +	test_commit unrelated &&
> +	git checkout @{-1} &&
> +	git mv to-rename.t renamed &&
> +	test_tick &&
> +	git commit -m renamed &&
> +	echo modified >renamed &&
> +	git cherry-pick unrelated

And this actually warns about an ambiguous refname.

Will send out v2 in a moment.

Ciao,
Dscho
