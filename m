Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EEC1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 23:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeDMXsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 19:48:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:40075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeDMXsc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 19:48:32 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LedVG-1egOGh33eQ-00qPcL; Sat, 14
 Apr 2018 01:48:21 +0200
Date:   Sat, 14 Apr 2018 01:48:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com> <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sfm737e.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com> <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/rQ+mF3sVmVWkX+N0osb4sa6WWPFmjFreY73/flOm9oUC2nXnmA
 CK9gJjyLvu5oXY+a5lDNGNhTEA0t/JNeMQIyQGxa87buONfFWbGIbF1NSbqqYOc6PB4yYuV
 wjNnzvES/wV+E0upKMffoTNrMifV07Dgu5de4DnVNDwiD5osFO2ptWI6h1Y6uYTLefs619w
 b5jqu8+UAp5uV7wqHiLyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dS377nAR6v0=:ZF+vQMAW7rZ4zOVFKhi6kN
 y7wgKoxkRv3nTppHUzQ9MeJt9ZMOk7rtGB6x+7U8f0OSPHud+myNFDh7M1/aSWkBFjfbDWovv
 yq+JEXAEwm6mxpETc2b90ipejIbkBrMqt2+Hn30WGRaGN1ti5pppbhwUOp4BByWX1gkpM+ZrK
 WnpErmpM/7d6vu4BLEmujf1+Nj1/OiQZCscxoiL1ST6GKJvsxZ5Ip4ihUIgsMeugWf+BLlJ23
 +b3xFm7ak+DfMIUkyYr7ccODMKE4CyYnKqg9iyR+8O3pYimOFefRPBNf+WxS9cGuVGmFEU07u
 2tR5MOXfa8wglR/wMvPI+tENWxCE9TYVftudfhtpbDrrTJZzq4bwNfTgQCr5/5RQR/6xwqLAT
 XN6nZFeKqBLvr+ux44PuQANBihfsGuvnIfU08Oh5DTKsJSNKrgH/VeTLUOztPLcZAPH8Wr6ew
 zPMqnp9JP3f5zRyIxaD3N0yOB+E+Q9Rn6Q4J3RjOoHfcqVVv13Ai2bUGEPxMu76KDjlq+IPJj
 Q9MRcW22OGwPnM26hnpwYWFx6tvcNed9QYbJ/BTaKFUk3a+L3GAZ9jf6GviDmeWHtstmQIv3J
 hYjYxsU//g2uAImiQBSmDpILFMLDSqErPvcFSOhBBT917BwABoNPz6MVgThKn+ve+Ztvir0IP
 nj+YOBgPluu9fffQxjwrS3RKaUMLLeOxiRDFcljNYnUkr3JVQdM5vd6YUL1IAJUuIXJFKg4Eg
 ghlkPo7Yyp09kJ7MZ+Bze4nivErtYccfKb8yagFM8pkHPA3Ffer6htMBTolRpZ8DmQzxv1tj+
 Fi+5+m5ORmSe38QPIpEheM+amcEHxFUEGoOPoq4sl6YNO/ENb0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Apr 2018, Phillip Wood wrote:

> On 12/04/18 23:02, Johannes Schindelin wrote:
> > 
> > [...]
> > 
> > So: the order of the 3-way merges does matter.
> >
> > [...]
> 
> Those conflicts certainly look intimidating (and the ones in your later
> reply with the N way merge example still look quite complicated). One
> option would be just to stop and have the user resolve the conflicts
> after each conflicting 3-way merge rather than at the end of all the
> merges. There are some downsides: there would need to be a way to
> explain to the user that this is an intermediate step (and what that
> step was); the code would have to do some book keeping to know where it
> had got to; and it would stop and prompt the user to resolve conflicts
> more often which could be annoying but hopefully they'd be clearer to
> resolve because they weren't nested.

I thought about that. But as I pointed out: the order of the merges *does*
matter. Otherwise we force the user to resolve conflicts that they
*already* resolved during this rebase...

Ciao,
Dscho
