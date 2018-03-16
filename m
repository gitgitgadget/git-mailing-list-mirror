Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D21FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 11:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeCPLtJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 07:49:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:50167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbeCPLtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 07:49:08 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgKUo-1fJQnY0SrG-00Nf9X; Fri, 16
 Mar 2018 12:48:38 +0100
Date:   Fri, 16 Mar 2018 12:48:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries
 to bin/git
In-Reply-To: <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803161248040.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com> <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com> <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7fL3N9S53svnc76S9U9c7rDt9lw4upuD3pGMXVtmjU9zTqFytQY
 FPBJqzkUO4kqTpPmFqJN7+AgjxJEv3n4YdRMT37xpdcq/qXL2Bu2ubwfjOAKL/QvpvZK6x9
 Q19lQKzfFMzbujzmyExE6hsofKXJscA7T0JIRYNEQ/zjrPAn0pnWeQCHR5cvjrwhjlAqXqD
 8oTZszdaAUNudpe8Q2rJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:se+ydwj0rPE=:7KKsPHCyeFry9/xRcpoDqq
 RneplKBC59NYNuBFHY+cG4nnx481+084q+7suf4q98sftDY1XcuGrfOZHdydCr/L/+zRvkqbT
 xU5WLARuKk0JCu5lSHEOTkEJkPbp5emYJ22/a1VV+N1WgIcZG6v3vQpMTPPLYaA+pmP76fbdf
 Y7RTbuqhDTmZh9VgWZZNmUkP9WlfYAB3x9jFy5C3slcxN6RFLII97dkoWjdtUUvImWO8GgQdw
 hBzIIkVRwau7mHSIxlOigxv3KjNCsyXr32i84Rgl57uV/Ud2h3o63/w/wsb+MYHf/VDnZTIVv
 uofuArhSXYW6aJUFYXgC3ppaZahm5iTHHvPUs2bDNbrNIkabnY8gZFxK/EUhYMmk7d2IN4Qvf
 W9Dfh6AfiPxUo0aaCzdqnPgTA+Jppbm//CK5W6G0UJ0ZYitrwakr23bAfwkqJf+Ym0+yZj0I5
 9h0HYHiYy2+kLpeUHCqytcpQ/+yp4xonA+Emugj88a7S+u6lYKFEVLM5aWSFC8AzfgF5PPHQP
 FncNTC7FZj5DL60wByFxW5eq2/+srAR8QXyvlRKIwqGZTiGT4rE/gxF6QTaIX7ycrC4Yv49ni
 P93SClM51YJRNEPYSuowFcdTIFJu9iQD2FdSdCLImsgGfBNmndEVxpNMkxPZ9u4a6n0Z2hYgS
 vK20/tge8FHWlNSqmuO1e0xjdJn7LGbe0CyXnGuS7mybSVpf5VE72S1c81z3UV2RMFqboTwyk
 bKTdLkfeDZInPx+go6qdR4GCCXZ24lh3SJhwK+mG2HNE6nM2c4W4h1Xfik5tIBpyiyfh+jwJS
 asYh98bCVs6uGAKuiKcsl72fqNQAwkIfiP0UlSri1/yqu9WVjY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus.

On Thu, 15 Mar 2018, Linus Torvalds wrote:

> We do end up still using the dashed form for certain things, but they
> are already special-cased (ie things like "git-receive-pack" and
> "git-shell" that very much get executed directly, and for fundamental
> reasons).

Please do elaborate.

Ciao,
Johannes
