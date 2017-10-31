Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A22320437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbdJaRj6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:39:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:52090 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbdJaRj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:39:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYwQh-1dfdIP3OTb-00VfuH; Tue, 31
 Oct 2017 18:39:54 +0100
Date:   Tue, 31 Oct 2017 18:39:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t5580: add Cygwin support
In-Reply-To: <20171031131903.10496-1-adam@dinwoodie.org>
Message-ID: <alpine.DEB.2.21.1.1710311839340.6482@virtualbox>
References: <20171031131903.10496-1-adam@dinwoodie.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dO4hDHM82CJSwpACfoBsDg6xtGXBYQOyQtR4wBjWYNMVHg3p7X3
 B9sQkeMc4NvyAmEdoYaFDJZNfKBlBim9LUojRnSt2cgZHug6jsgqZcCZ4DG9uQmdon+G0sX
 /a+2r0f9ECabW+QstYAiVtvwslBaq6/P+YI5bSNSCzFdJcUkaVX8fxMaQqlEcdBsv929SSz
 Vaab3BYsAgyqhtewUtdTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hx/fRb+t/6s=:KaqTga0ZCK4jacwgUw6ItL
 tANqtiXQZRRpOzN7v8gDZSjQFfrM9+H+aQxEslFlZHNsfon3a7Nt4xQfNkqx4+s75IhEMbgYg
 evhZHsRXeMyykEnNP75fCmwBCSGQS6dxNS17SmFmKnVnv2K9SozdJn/171DiOLOan6imIkEaC
 3MJUEmUwhyMoTHQiAI1WEKMncJoq6YMTvDRfUM/Zrl6yllh1hMNnTLe2ZsT5RPRojVVXW6jdF
 06iLB4wo3L152KhBIYoz3sfDVIKOO2RL+XGZhOqu2LHMBlOijcDN7bw08s/dsftyJmlD2VTpl
 A0GOSZBvtQTdgPCvXrRMxKSYNMmXbnEmDwkQG/Zrbm4wJlspifeYeCx2JpvDegkd80/E5ivm3
 6G8L9GP3cdw38ZdtdN4A6y15FVMosb5Cr3GuAAF0+xwt2lUlVmMRDaDAQJzg9dOfgbGV98+88
 HmpATfyMNxsHm1Rf1BDlsNY00/Gf4i+TRlzspevmoHuVbZg4k2PdUxixnS1cLC0p4rXTm8GTT
 G8BakM4h5X10xmi4ZcsGBED2i4g0f/Rk/v8F/qKqoD5v30rNFzmLiO3HFzWPo3Wp1HEv275Lz
 bFnrVqxHk7qFy7z+83v1m88z7XH1GFQbDtf5e7sjbtGfdR+WCYJZE+qDg/Ekb1pFkI3ePM+5x
 xT2nmdlSdpy7v2oGEO2vPdjKWfJR7PB/xLzkRL0fbdAxc08mCV6IPAcID+0pK/lK+JVE6653T
 JB24Xw2edhdGvKc0iS/BHjrtGzCmtAW99FYuTfqGKGwFH5z8Ai31MVNzIKuMsq5G9zTNXBX7y
 xgh16yZHHTg8F4uZpiQfTZUhj6yMT0KHW/U7ZaqKi8a8bGvpQBlDprLs+ywpZ7mk1vGxD+Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Tue, 31 Oct 2017, Adam Dinwoodie wrote:

> t5580 tests that specifying Windows UNC paths works with Git.  Cygwin
> supports UNC paths, albeit only using forward slashes, not backslashes,
> so run the compatible tests on Cygwin as well as MinGW.
> 
> The only complication is Cygwin's `pwd`, which returns a *nix-style
> path, and that's not suitable for calculating the UNC path to the
> current directory.  Instead use Cygwin's `cygpath` utility to get the
> Windows-style path.

Looks good!

Thank you,
Dscho
