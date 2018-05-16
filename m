Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC09A1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeEPVwW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:52:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:36891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeEPVwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:52:22 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.106]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LmKOI-1ekHoy3Nsg-00ZxIy; Wed, 16 May 2018 23:52:14 +0200
Date:   Wed, 16 May 2018 23:52:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Brandon Williams <bmwill@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] refspec.h: reinstate 'extern' to fix sparse warning
In-Reply-To: <CAGZ79kbPNJPtcvbgu81y3UYmKsUd6UNNr9kmQ7qjEfB0ZBTJwQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805162351050.77@tvgsbejvaqbjf.bet>
References: <29f60a43-9c95-512a-ef85-558906a08ed0@ramsayjones.plus.com> <20180516214251.GA60301@google.com> <CAGZ79kbPNJPtcvbgu81y3UYmKsUd6UNNr9kmQ7qjEfB0ZBTJwQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/8RuNPVG4n/OW6Wc37nzDoCgwRbjeYJc2Li6fYS1fTYr2XszmWH
 SnSNrZwIZiFkhZxAO7VFfvSeT7YcIIkEE4lgyBUJCLcgN9aUGVjaNc5Js736ipl6ojw67Y6
 EOu2YJUQ/fAk6ojM0O/fS1eLO+t8f7dj06lNS0+ha3tXfBBQEtE6fGEnuAQF8LVehXEs7/V
 mgqaf5hW1Rscdvc+ojgXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:85obg4chwQo=:1KUAjhGY4h+oRMZl72wuyZ
 eQV+/VZsfys86zGds0IwQz9OFU0XC6lmwMmAp6b4weSxp+yDbFSTxKj8WdV3mbmKYQoLrSYX7
 e9rs2bj9h63LXbjjh6mwb2vwQa1axnVVWrYwh7GXn3xIdkL5Vgs6gUKWUnyppZcrnsqG1CJUk
 AcIaeFOcS2mfxKy819QjlwfqUgGwBo/a7q6WtdiY7a77Irkfdkj/DkhPcNB3UE4gvpmPy5xS6
 qmvPKfBbUiis6y4odj8RSPvnKHUDFot1PZfr1sulQFTL+DJ4wlio8vs6o8QdLMBlLcdL5Vu7O
 LKsc5vJcwWgrn8kn5iXZh+zpOXdCO7K3H2BUtdO5UnQjDUksg1ZhzxB7T+50eVy+C1OvKN6OG
 JpyjITL+FHJ4wd38MPGMHjTMe38r3cO7ClCa/8RNgzeKW4C2TL1TRf6pthx8Fdx8XpZKNm8FO
 rRTji3tBBEeRiFlDYiw6eiJJDwLDQEfNMbnj0jOjeOuvBIeXPJNPT6qnoMq3FRmQWEIprWMxR
 DMlW5IOPowTqvL8rx+zCpNzhPiSBnMOrwH9kP/D5UNeYLawv356mclDjQp931OXRBC+lumXSa
 MtZYljGQ7i+r8hDRhvXxctLJ4BQbDdalRqr6SHulwMnjC//xGciXYK4+cMXIKYZivdhLhArBt
 WbQvIJo75yGoF8VWUV2mGtp+TmZtMmfK9Uy7HcOtj9zvtxALTh45/foulCb4bg2NQ2PyfMb1u
 gLniFzY7uqLq9TcP/XKXhQsxhAeGKzhfo4hwicr6MIoe3MbOTEsrZzwakyYRxbzpOEb6MSfse
 e1nCzQ5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 May 2018, Stefan Beller wrote:

> On Wed, May 16, 2018 at 2:42 PM, Brandon Williams <bmwill@google.com> wrote:
>
> > Though now I'm confused, I thought we were going towards eliminating
> > using the extern keyword? ...of course I guess it means something
> > _slightly_ different when using with a variable vs a function :)
> 
> We're only eliminating it when it is redundant. :-)
> 
> For variables this is not redundant as we need it to tell apart the
> declaration and definition of it, so we have to keep it.

Otherwise we will end up with the variable *defined* for every file that
includes that header. And of course those different versions of the same
variable would have possibly different values...
