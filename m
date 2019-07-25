Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235801F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfGYJgl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:36:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:53491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387547AbfGYJgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564047390;
        bh=FlyDTfqGTfhvkCP8tLdfkai/Fgj5CCLuGSQ+Qq4zpEQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PTjSoBIVfnfpmvnSgmD51AuPZwMOpLmW5vFd2g6QUR/jUGf46xsRDfNDp7pwfTBdf
         Y0JuBE/Le+Wi3vNHESon7cp7+GTPAZGrFG74gVpjtOVfQsBQJ3k76GMTmlu2W46rhA
         RDOtTICwbDBrJDVNp0erLLmCLm4Pm9Lt4YGlRZZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEbYb-1haqj10HnN-00Flmi; Thu, 25
 Jul 2019 11:36:30 +0200
Date:   Thu, 25 Jul 2019 11:36:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/5] repo-settings: parse core.untrackedCache
In-Reply-To: <49be7a73454b13b04270531eece87a2c6f6d3189.1564021393.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907251131450.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <pull.292.v2.git.gitgitgadget@gmail.com> <49be7a73454b13b04270531eece87a2c6f6d3189.1564021393.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xegrKMHtZ/eHUoH9JczoP1r9GJMxGQU1KbCp/VKBU5/EaNHWfJA
 rkaRuHb2f4fJntsLtl5FZhuNZtfGIEXZCQJSeYvch30MNREliPbkP1VJOehDmH4nksowDNA
 u9AV2zlEqjVT1bRFLqU/mqThMQXZgM+WLzo6Q5GEMsqapImP7PdpWR5L4wvEtGHLOZbAXbw
 YH8OVD0LP3f/m1UaHIxFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z7L+HQlVLHU=:4xK9ib6mk+cObiDoq2HVHx
 Yc/xsqBqaABCcdnN3niBepV6elHyv56k01/lrVru5hJcpdelqBxf0c+VAh+KJ6Gb+YFHdSXyu
 ENNfniQDmLHcN7HRRLmDYCSw0akZ+J8b1P83Ot1Irait0ghfPb1+dM9uglyPRB/P4Vwo5lLUB
 kOvK0tbqTnbnIxEmxc/UPnQYah3EfOZEzp5nMFxxnbjS3k0pE9qH6Zg1nrUFKAj986HGK8ONb
 pISzFxlxpaGGWD863zkrI2FfGkKHlgCvw8VOCKy6dizB3ehUTmIlWJZDp7FGQwVx+HO9JVWLo
 Nzdqh7zqPpNsK+CY8ozIkshjPB9oqJAy5VBF8gvO8Oi5oFekPlD6iYdPqC2FaMjli6dfKv17u
 A5nU+YDEePtntdQVBJ3cSeN3b0dzXvsYXRePexzJtb8wu4OrCEfhcjRLpsOYJmC4LcK/VCv1a
 t1cqiVmqK6WDTP6wvEhdKT5cUouT+C3iNobZNTKhn3TL7PWfcS9xG934MSBTvRm0zB2mhrEsT
 NOUQ60l7UcwU1Nqii/Z2rKJCykvwb4wQPv5PooPQ6tnSpd9cSqdeZMfKHkTzUHloVAtD/AsBZ
 eGGLAbh342vR4FeTDx5eI1xX48D4RYuWhws8YXMuNFG+9m+J5FBKVqAKW+Ko9FhzAVCltlGVn
 imww1jc32lGVgglnrpH0/AEHLyVCfWOq63g5fvy7gWnZj8Y7O96bvfLztHdXQSQ343yPjVj7m
 QAtKUB8n9PP4TYXX470+0L1qZBYrLMc5zzdEVL6buEnvvpEteyKhpkg8sk37MQKitHt4AVyJr
 bQ8Jho5qzqxPcDvj5SiEm3eT27ZQ1n7VcLjhFSJ+ZGkHxkmp0zPZHMrNBppfyhM4Fhu/dR7G9
 BEcx+rLbP7y6vwt13Dasp4tPSQgTmwIFOgbQiwew8wPHXIUWxZtrcVWnZqhfohFvmr9TowaTG
 E23Ux54NN3wYtRW+/XA9npwz0FQV7kQb33S4cKSnqTw+DLWLEijV4gtGW81AhTzTEcZ5o7cYS
 2HN5rsHOlRYyp46JQL//9BofxQeX1ewQwSiBpDdFOjWdG2ANp+DqlW9h3sLfOb1EPGKWVo6C9
 WUy2MOUsBYgLyfTGt2EYKwJW+QwwFV+gs6r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 24 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index dff2f4b837..5ced51c1ee 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -18,6 +18,7 @@
>  #include "dir.h"
>  #include "split-index.h"
>  #include "fsmonitor.h"
> +#include "repo-settings.h"

Sorry, I only realized 10 seconds ago that these `#include`s are no
longer necessary because `repo-settings` is already included from
`repository.h` (and needs to be, because the `repository` struct now
contains a full `struct repo_settings` field, no longer just a pointer).

But really, I would just fold the `repo-settings.h` declarations
directly into `repository.h` (but keep `repo-settings.c`, of course!) as
it make everything a bit simpler.

Thanks,
Dscho

