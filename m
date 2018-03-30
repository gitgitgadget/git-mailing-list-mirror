Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4F31F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeC3Kep (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:34:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:35679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Keo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:34:44 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1ehBBn0eXk-00uFLa; Fri, 30
 Mar 2018 12:34:43 +0200
Date:   Fri, 30 Mar 2018 12:34:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Wink Saville <wink@saville.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
In-Reply-To: <cover.1522190580.git.wink@saville.com>
Message-ID: <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522190580.git.wink@saville.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ms4cQSK35LIY65pOm/O+BEGQOyjL+0mc3Kjwg+10Awq2PrX0X+/
 zREBu+pYDKS30jC4kZ7Br3ypef8dF+NTSZQS57hSrtOM2hglQftJ0k1PtZK4aDH5JWnZa1y
 Nu3Mh26VVlorFg3AL3dCropASufYSO4LWxckuleRk2reIds8EThqNsE7hVx7B+AWLlq2DZf
 LyeM08BACF+kElL93fccQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7Y+MlsI0r0=:vqve5/4zyPCT8QyKtDPhUh
 AkWuwYUnttj2z80p13f1ly9Cten/RXKaBrRDt4fvSlM6qNt1gCOnBSQgIJuwl6GlVI92LWhtt
 T5J5KFTFQtOaS97Px888I9VH7CH42nxhyL8akXNWFGD5jXSb+WtrlL6Ngw3Yem1yShpbgNTix
 7w8mvZd2Exej98GVSPW7XekBU/mtw6/37VS7VDTA7HyKVRwIcDARlx2+0oZwXvcpcWOdjzDJe
 WhtdhfkEB2kt/uLDQjz+Cdn7fPVYWogcgFR2t7apaJjqCzbpWj10tLk9XQZOSoqslvj2U33c2
 5fWThC9GHBt8EL0TI3QcfuA2neTKvlzN7gVfaNe7eQstYgNc8+2Vx+pPjvCpqML1IhRyJ7oIq
 8CoR+AJjsFeWXwE/72svDSyfKcROHcMiwYIb90Mp5WQ29c6/WfS4Y/lJBfts8Z96KzjWVqZSR
 5vE0yN6ytzW30m5VlAH+rtYj4U6CNNiQuLEqN9c2A1HCJWKpAmT7Y2Wi4LOmalnbYP/+WvITK
 0Pgpthr/oqb77os+oI4dec2bW+IBT7M/WDQdpwwnUYk1/W8+EgBNmTzqgAZQ2jg9CMiQFOG9O
 +uLlS0NBaLYUUIFhAu+LNBydmolUjbOuB0gCaPA3yXvYJBIDeOsXqS6ERPlDtAg/cBbA8vRB6
 nTi2FrpRvbIoMZRtFyKTFJFxHlqzUv3+znO9q2yV6ax5ifTDiEFBuJDkMMwjSpn16FrAqhiaz
 FsxqKO/G2wsuIG6M4vPvnzdMoVFC+su+9Gv2gBPhZqJayH4OE7QSwyN5U6UNyHiCekkGG9HoC
 Dt8IIB3IQmnto2FM/x2vdzgWfwvc0Jlkck1qSC1we5k3a1uhCT/5HO7e9U7tjReiToCnOwT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Tue, 27 Mar 2018, Wink Saville wrote:

> Add bdl-lib.sh which provides functions to assit in debugging git
> shell scripts and tests.

Interesting idea. It is Bash-only, though... (and it is not a secret that
I want to discourage using Unix shell scripts in Git's production code,
they are a decent way to prototype things, but they fall short of being
robust and portable in practice, and don't get me started on speed
issues).

So rather than spending time on making it easier to debug shell scripts, I
would love to see us going into the direction of a consistent C source
code. I still believe that we can get there, and that the benefits are
worth the (huge) effort.

Ciao,
Johannes
