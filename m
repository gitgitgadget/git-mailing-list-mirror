Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20661FF30
	for <e@80x24.org>; Tue, 23 May 2017 10:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760976AbdEWKq3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 06:46:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:60147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758653AbdEWKq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 06:46:28 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyFr-1dAfZW2CL9-00HKlW; Tue, 23
 May 2017 12:46:25 +0200
Date:   Tue, 23 May 2017 12:46:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
In-Reply-To: <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1705231245300.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org> <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com> <alpine.DEB.2.21.1.1705221600100.3610@virtualbox> <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MjyvmLQAJY4Cp1XAMAF5/UevWPaj49UtKH0MORJpAyVKZdxwcwx
 p7QMeXhaNoIDUj+YJ59dwCRAXshsrp7E5mqI0y7/tJqsrwoXj0k3s+GipHr7zaOAealyqqP
 LaCyg6Cg+WS/l6XAcaZz9W5fNjAgY/Jrh/JXxpP0iSpNRIQ+Pdghf3RoWN8k9zk1+QY8Z0w
 WSVH4vaxMWMaxQU83gEqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l+EWgDqacFo=:Xcmfo9+TX4qE6EpyBCna+E
 ePf4M8TORnbPBQAvCqRPQ5I0AbEzWQLJ9BkoHENepljnyBeM/kTq53GhR6C05ra6u9ELPKaAx
 6wCfzzG9NfUX3HCBppDvjRKAjias+pnTCO7RU0DpPeHkx7A2HfoTYk1gloUDDJbeVdSClP/R1
 48hyK8EocltxqMsJajPlECD5raLepwjdl4eQuqCehFWjm5sJq6ew3W2wzhNHwsdfJVwtFTzyx
 X6np889nRjzrd1QFJfVjRKcKBd9rQ+t7FNaVycHMkfShUSLfLdyfHWT6JBxoc8ywogoGuUHIV
 7fOdqg7eMosFk9EyWyLjn7ueRaANgghI9gG9orN+wOxtV5yU9fONCALmqaJs3TWDkIlIy0v0m
 qwXX/1XOlQIRlGAU17xEXSL9Cb3jmubWyIHSukG20M2pKIai06jR5uW9iKzT3mORuHP/hohvt
 DnvDjY3dWfkLRVJYw1lhMKL7xa7qkyeHIERC3otZDWBitew/1qjoV8T4K0F8bpUHixyoVGIGx
 UdM8qz7GjIzNsc6XAJ/5CXr0CaGT3EzmVUDOQ9iD8Kl5aIltj6P6Lpmegix3zi0PwNnDkDfIO
 y3PX2WwFaY3xuj6NNJHQTBg6qk+Hx0QNc3VvfAkZ0vIm2k+5L8M8JZV392WMsmuQ9Nl23RH20
 Z7P2vbso1SUcaEfpH48tsQHw95/phZvDDfLTpuK4JUm9vkyGvsSiLZ9byOaAef5LSVuLvhS10
 An3YDNPahcipBQcSsXFNjBEomuJE77TXzNPyzbG8H2bZYXmaPSjRyOvj+iCEzWEXguQtC6KOZ
 kmQbG1r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 22 May 2017, Johannes Sixt wrote:

> Am 22.05.2017 um 16:01 schrieb Johannes Schindelin:
> > On Mon, 22 May 2017, stefan.naewe@atlas-elektronik.com wrote:
> > > Am 20.05.2017 um 08:28 schrieb Johannes Sixt:
> > > > This small series fixes these warnings on Windows:
> > > >
> > > > C:\Temp\gittest>git fetch C:\Temp\gittest
> > > > warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid
> > > > warning: argument
> > > > warning: unable to access '.git/branches/C:\Temp\gittest': Invalid
> > > > warning: argument
> > > >  From C:\Temp\gittest
> > > >   * branch            HEAD       -> FETCH_HEAD
> > >
> > > What is the exact precondition to get such a warning ?
> > >
> > > Just wondering, because I'm not able to reproduce that warning
> > > (with Git4win version 2.13.0.windows.1).
> > 
> > I had tested this also, and came to the conclusion that only Hannes'
> > MSys-based custom version is affected that is much closer to git.git's
> > `master` than to Git for Windows' fork.
> 
> In this case, the warning occurs because I build with nd/fopen-errors.

Ah. So the base commit Junio chose for your v1 is completely
inappropriate. It should be nd/fopen-errors instead.

Thanks for the clarification!
Dscho
