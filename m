Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75121FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764066AbcLSRSh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:18:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:61066 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763848AbcLSRSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:18:35 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1cxsAb3HIi-00nfdH; Mon, 19
 Dec 2016 18:18:29 +0100
Date:   Mon, 19 Dec 2016 18:18:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix pushing to //server/share/dir paths on Windows
In-Reply-To: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612191817530.54750@virtualbox>
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ziU9vnEx1vCw2pZ+cY9pxIOMQ7qmArk0IFKBeT07bzgI4C22BkJ
 FqGy8usXwE4tL9RmpG3tNfOYJpjKHGjj5ZMP2RBn+EOMP+1RQ5YIt9Da3slHamPM+IlUAzC
 Dd5HPFe7zeKJDb7j4N1OciLjinVXXMZ1y2qiabekdpmhc5myrUO2TaUa1KvGnBp7Kbxzgu4
 cHJqPGNoooPJskpMiyD6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GPP7RH9Zbj4=:J38J1m3oBHPiSrXVwx+/Gm
 ti/kMTTOjMKvGpxiZna5pBXJiVqMlMdcCPUCRy4RHvRLp1n8q4Q/ufnJd+YO9rs/QjWfMB37C
 y2QF+ZBksKQc9S1HKwaq24OEMq+zz+9bxLbhHyD+7ryDCLSSAN2FvfU/Q1rM+KAsLdCmbVhHs
 LXdsPKyBt2tSz+BeAT7te7ARGnZWCnODqDfay7770cioUxBXJP8/obpDehniqMS74/qMmjKNZ
 hJ5VrrLlVb3yr4lDb7S2szXuZ1KmTxGYZmYu02qAfIIq98MpJvZvIp0Fu5g9nBQg/FYozMTFG
 sxt0RfhOtzGXtUBblPcjWFSyg+K3HeFKKBCYmEkgM8WfJ5UgKl/Jl5jQfOYR8+d0ZAisR3h9s
 Vjmz6aSNH3BexlzameorUQCdJ7wq8pWTfFWZ8XS2PH6kFPhggA2CRMHc8Vc55cx1GhiSdSQcA
 ffnjf6IZ58W5UfYymyCJ68iABes2lO06WZAZLQcoHJXCV1acZOtRhyBmAWHQpOxbI1r2iK+NR
 9sm81dGStYM6OS/0ZPBomcGNFjV0yI+A7v8YKMesmYgwGM6ArQP55uyK7ONjD9HAIhiNSqlfH
 HdyOdqzjBwGyQcHo1WXGlvqPjyccE9PnAnM8azfeCBZ33iK5YM17XjephTc+DC3bli5XwrpqJ
 aW6rHftGsGX0onppjuvmZoA9WxtoC1zziY84eKlZU/uRVFp/YFQEJJrj0Nc87lipqcOvP8WCR
 /w56Y4V9n4XnpUs4vkX+9eUbOHEPxNobKnQzxCZeHa7xIcdJr0S7hW51/9Y0yD8C6N0UfbLKw
 5rEv2F/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 13 Dec 2016, Johannes Sixt wrote:

>  Dscho, it looks like this could fix the original report at
>  https://github.com/git-for-windows/git/issues/979

Yes, thank you so much for fixing it!

I think your v2 is safe enough to cherry-pick directly into Git for
Windows' `master`.

Thanks,
Dscho
