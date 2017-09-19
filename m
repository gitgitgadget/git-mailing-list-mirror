Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,SORTED_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B560B2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 15:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbdISP3S (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 11:29:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:61411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdISP3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 11:29:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1VlJ-1d5fe30kTB-00tPl0; Tue, 19
 Sep 2017 17:28:54 +0200
Date:   Tue, 19 Sep 2017 17:28:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ben Peart <Ben.Peart@microsoft.com>
cc:     "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 12/12] fsmonitor: add a performance test
In-Reply-To: <MWHPR21MB04789C11E37F58FF9BC11C51F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1.1709191726430.219280@virtualbox>
References: <20170610134026.104552-1-benpeart@microsoft.com> <20170915192043.4516-1-benpeart@microsoft.com> <20170915192043.4516-13-benpeart@microsoft.com> <alpine.DEB.2.21.1.1709181615040.219280@virtualbox>
 <MWHPR21MB04789C11E37F58FF9BC11C51F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wq+ropD1IMtuf34XhVR4Vj1sTK7i9ACqT3JNEMl5SNbg6HDuDvl
 pMH1sC0vHuSfSJ93OVwpjm1ECY3ihC1G3PMMKmO4O675/zYTTVZI5LGQQMd/g+egShY2mWQ
 tfNet7mHDpVE4UmUZ3hDj/Qqu4ksiw+o1d9x2iBlzBHrHx108OLrln0TtKahKTisxDGPe/x
 BGlUM+OFph8gHlbHTvFMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oR5ghlBaHtg=:l35o7yFZ67c+sEPAbI9fz2
 5ihjO9y/NO3z0rHa+K82GlG39VwOxYyQpe5VhYFFagiX2xBleaaWgbsURvmh2B8BxJW2+4zxg
 0A3V/X6yFSdn0r6Rl+usqBcDTnHbz7lGXniLLTuIYz9HcpS6a542CNhgzJnvL8Z7h3DmOS7AP
 311ZnY6rZLXT60spDYSSbpECANxfsocpQb10Ly6a9tpzgU37bq5/PUafbgvYF6GdOGyuxjcR2
 nitB3PSoRd23gG7ofkeNTVpXbkteCj8fzf2Syyh+hjVOlOMTo7T2hG2eqU92H+o5sbdSXRLX0
 myLhnIb6iDLkoMUSEt5OEW/wDvD2Cebr8YSD1LMKNgOHuiNsavayIsufiYqGnTZrBffe4LpAU
 WsIlG3TI6DXoXmZ4xVbVZdoRzbRZ8Iz7awnVvK5YybG/xpP6ZHr7QPyStRwPdu70OWG8Cnv3R
 L8mNEWUpvwMgPMietweS6sCwKENf3+SaKS97+4F6igB+zBPe3oXNuA6r2vsUNuEWqv+hX4fMI
 RLU4erfAb0a12xiTm1AzS4x6yr9e6Wdzxs/RQn2YqIY5ZV5gKNbeULOT12+u9gfPlQNnCo4Mo
 tCWzcYK4qwbxHV3j6PhOcOE1psZKyqINUmFgBdmA7tJIcdkQfjALHOXQKon47wjqWwp7P51Wd
 4ezk/k/Bv9svwNQX/9NSpbtj89u3Q01KeGJUSrPX730vSCRCsK/D1FEN5+ZDHXpe6KGQSr6jh
 6IB/OluoQQge4gEFy3QumPdBdo2mwrqouG31VNRCin690g0m0XGYTkd9fb3Ik81IizOnyOmcv
 o3iyFqWON2l+wi42Q3LL02okJsPYlGW+gdqVTymBwKyWG6Em5w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, 18 Sep 2017, Ben Peart wrote:

> > From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de]
> > On Fri, 15 Sep 2017, Ben Peart wrote:
> > 
> > > +	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =
> > > +		(DWORD(WINAPI *)(INT, PVOID,
> > ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> > > +	if (!NtSetSystemInformation)
> > > +		return error("Can't get function addresses, wrong Windows
> > > +version?");
> > 
> > It turns out that we have seen this plenty of times in Git for Windows'
> > fork, so much so that we came up with a nice helper to make this all a bit
> > more robust and a bit more obvious, too: the DECLARE_PROC_ADDR and
> > INIT_PROC_ADDR helpers in compat/win32/lazyload.h.
> > 
> > Maybe this would be the perfect excuse to integrate this patch into upstream
> > Git? 
> 
> This patch is pretty hefty already.  How about you push this capability
> upstream and I take advantage of it in a later patch. :)

Deal:
https://public-inbox.org/git/f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de

Ciao,
Johannes
