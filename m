Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46E31F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeG3QST (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:18:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:46401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbeG3QSS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:18:18 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfC4q-1gLfzL0QDg-00orDR; Mon, 30
 Jul 2018 16:42:55 +0200
Date:   Mon, 30 Jul 2018 16:42:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/9] contrib: add a script to initialize VS Code
 configuration
In-Reply-To: <xmqq1sbt68ec.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807301635020.10478@tvgsbejvaqbjf.bet>
References: <pull.2.git.gitgitgadget@gmail.com> <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com> <xmqq1sbt68ec.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fZNZHBfR1n75k9z0lOk1L3pN1r0/DKZQVNVodYcRCU93Oe02Z8F
 n1vaI5yulmnovgYZIwg5RpOS7NGigycEXmIvKekE70ho2jZIBU7Jm9UJqt/k66woVJisTgc
 Ufv8K4GYWeT8jjHVWDzx/iZ0ihKKBoFBs0jZjRWtEnEqRcbN6DwryxqtBgcl6poDRBDfgpH
 KZLet0wASd+3ZvXemngJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dm5vQMsBN2s=:u5BF8Q0dH2sNJiKFb66eeb
 KVIZ1Emcgbh4pUn3TtLdEP4m78T3AVQbNxqRzESA733vERahK51WcEOsnaXDs1g3LfbRXoG9R
 KG3g1zM1m6MqUAt8uRo+GhORDWyxW3SbZ2KZFQ8QR8AxBE2EHv/FPRWQ5qfTMUcpOiW3HK8RI
 fqz9fvgzoITgpBW+4IAItOu3YCp6zipettEKSMvFBsW3DBlHO43ZUUGnL0DloxvoxVqx9T/Ef
 IRvx5lCPqUllpx4OQZq0EOZG/VpgopikPkAXMWE3+8tXKzTsNqEfgqudt/WCsKwOU204ckS8Q
 Qh9wCtulH88Bgn7GJDNsSC4DaEDd5hscEiTqpIdGNoYM2q9f5CC1N70GRtY2vlXH3sBCXkck6
 eX6r73sW45Wo010pNJISlmQFVJbytixb23m22qRyKitTT7gsuKTKEb0BRzUAEbX/y1mek0Fm1
 8Zb56KwQ+CH0GyUFOaQz+fJPaG2Pxg/A3RSAhKNi/yS0s+Gvta6mZnf++hcj49v3W6U88M3Is
 deDBmuNQu9oIqAOu4RRfZdTp9TkVQxXFx2IlbJ4nInfkVXz1uGMz+X4oTu2DXjW/D/r+SwCvn
 P6YrCtpzfGnQHUnQBC5B3IHw9ycfzU6MRyTdgTTjzd/x3BjeyQ7dYSragCaRRgpleogWMJ84D
 VRzN4Z8GJdemtSudxpreg3IA6GDs2DGSgeBkh4pgFbJtz24Z+H/o1SeEdl/R/gx9Kiyl6ziYR
 53AFxQf55doFjT1W0sjnL0wZWcua7gWCB+3+s/Xx10Z3/yRTYzq5+J6nCTwIZ0v8+SOt+tTR9
 9DBf5I6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Jul 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> > new file mode 100755
> > index 000000000..3cc93243f
> > --- /dev/null
> > +++ b/contrib/vscode/init.sh
> > @@ -0,0 +1,165 @@
> > +#!/bin/sh
> 
> This is caued by our usual "git apply --whitespace=warn" as it
> contains lines indented by spaces not tabs (perhaps the json
> literals?)

A `git diff --check` does not show any red flag.

> Can we have contrib/vscode/.gitattributes to tweak the whitespace
> breakage checking rules so that this file is excempt?

I would have appreciated quite a bit more clear a message, including how I
can trigger this, and what is the appropriate setting.

As it is, I cannot reproduce your problem with a `git show`, so I assume
that the main problem is that this commit *does* add that .gitattributes,
but of course your `git apply` ran before that file existed.

For your own pleasure, here is the link to the .gitattributes file in the
commit that you applied yourself:

https://github.com/gitster/git/commit/44559f0388a4e256bea3eb2f57b92a2b9e3d06f9#diff-046ba41c5a21694c62b8dc5e93d7f0c2R1

I assume that this is good enough for you, and your comment is moot?

Ciao,
Dscho
