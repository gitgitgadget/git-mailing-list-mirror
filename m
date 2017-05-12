Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6A920188
	for <e@80x24.org>; Fri, 12 May 2017 10:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbdELKTB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 06:19:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:58592 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdELKS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 06:18:59 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIuft-1dB2XG29nN-002TzJ; Fri, 12
 May 2017 12:18:47 +0200
Date:   Fri, 12 May 2017 12:18:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
In-Reply-To: <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EcllxRTXznHjKDVO7tEw7ZsMjBNUmoUB46/jF1eZPDL7GGDNkkn
 LENGjGuTKwMA6Zv8uXtXYC05ssoDBjyp1rbuk/q/xv/XBUuj5ZCiDTV9kbxGMv/Xbh0z0wy
 f06IP0XPRfQWXzV1fhIF9DfVRS5UyRErpwwSUUd1Fqw7SukB4Hl2XnPKApi1TwhlpP1VUy3
 9nTBEoXzARvGw8eeLBfXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q0Kvc8dCxJc=:ZRiQg+4DlhRv1j6kiMcoAS
 CqlY/IwKqKySblkVNheDSEEayxyZzVKH7guzt8rCTZUt26v5wC4/LHGXWqMfL+BoKyH6ImqdX
 ABZYi+s1WJqH4k6Uvaquri3vk0zcUA28vc+/PvNfNBeilE9ibesIqsdCLiCoPKiEKRvQPlOxV
 UplvKUzMk5bWOnaN9kK8J9nlD5ANT5LNYknKI4ILiAWTvo1N7CIX5c/9bxTtMPwntgzpNyO+5
 b4Admf9LJUG/D5fbOT/FOd8+eWr17svUo7ebN/oXSdySlNYPJqo6T47LXKoaF+lZ3OLXf/gyK
 xeicwsg8bJ2hO6xpABVoAtt6Tz5JguZcmZvdwWdbIRXEfxT2CrWDc/JWYA7LjCRmJFQbKWXDD
 bgW3lsFhZU1zShsjnhbvY8/j2uVH+/pmRNEpcGDIdwSODUHv9QkR9qKwmnWc7TBas3t3xIjH8
 GTTdTd+/53y5IjhNPmtsReAsPIJ1Q+SATC6Pr4/fc3vGqkK/PA/XOSM8I/bgT8uri7aP9/zB0
 rhxoaGf64HiP+kDOcaT3XUBzc6y7BkWd8BWE62O6vG+RaWcrxO0dYydpYyi0nrTn4jt+0DOhL
 blMZzQQbSyWuBKv8ZFJwvju83xwe1FucKHQEuH8L9i7JGNdaQwETxd/zoKp56jZQzsv2MKIPB
 Xpn12fQfMWylVnsrbfTZQY/Nk+tXebz8mPqGQ1g24JPLhFzZBVOUJxF/mss50qrtL2nBOdMaj
 33Z5K+g7mP/gtqtv75tSvwHD/2NwEsnUuvPefD3lXPjziPuCqeqOvumO5BYAfI5jGQghdlTqV
 fg5/gE5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Git uses the config for remote/upstream information in favor of the
> > previously-used .git/remotes/ and .git/branches/ for a decade now.
> 
> The last time I thought about trying this several years ago, I found
> that people who need to grab things from many places still do use
> .git/branches/ and their use case is hard to migrate to .git/config,
> primarily because the former is "one per file" and it is easy to
> add/remove/tweak without affecting others.  Ask akpm@ if he still
> prefers to use .git/branches/ for example.
> 
> Is it really hurting us having to support these old information
> sources we treat as read-only?

Well, you frequently complain about my patches, claiming that they place
unnecessary maintenance burden on you.

I would say that the .git/remotes/ and .git/branches/ code is a lot more
maintenance burden than most of my patches.

Also: I do not buy that it is hard to migrate from .git/branches/ to
.git/config. All you have to is to call git-config (maybe twice) instead
of pasting a oneliner into a file. I do not have akpm@'s email address
handy, BTW.

Ciao,
Dscho
