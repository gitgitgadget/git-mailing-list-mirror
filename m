Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2528D1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbdA0OMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 09:12:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:55706 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbdA0OMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 09:12:16 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTBsk-1cy1vE4BxG-00S9Fh; Fri, 27
 Jan 2017 15:03:19 +0100
Date:   Fri, 27 Jan 2017 15:03:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: on FreeBSD, look for unzip(1) in
 /usr/local/bin/
In-Reply-To: <20160721171025.GA30979@plume>
Message-ID: <alpine.DEB.2.20.1701271502420.3469@virtualbox>
References: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de> <20160721171025.GA30979@plume>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:im/b89O2LlgSZDSiRtnOcnQv7YayYZ1aRV7LQpigQ3QoDN65Lrs
 FvqtRdnWS9K2QEBtDnLDGeCy2w2MSUceaeZsOKWVNk7bQSlCLteFx1iuMnE0y7LMEmIdJgl
 pv8wfyLwmFz8AZSuVBKO6bpvdQANh8qXsl8nnCsCOJ86h+e2am8r0fqZFjpwXNSBWadUO3g
 dC9iIEz/ZCp39C/7St/mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XB99e+uvBjY=:7R5/Rb5HMI8r7b7rRkIqrQ
 1AFYDDAgdnsgrk/gz02NN8PqUVC6JMoZmV3Ko5eCbGqwSokOeMLq6aDaobRDHcVp39zAS3yPX
 60RpPATuvPIljpq06cBGVGEtKVw1ut4Hj7jE+5Xcs22CbAHQh1SqH+T056EGQwm2sSyuInseu
 54Koio09CP7aS7tHCetRhkp51erPlsPr50CR5z/dZboKgrIXG8MRFCjmC8Bb2iDb1ROlto+/Y
 +/cw7cG8ZFBC4u7Dj/A14zFX42g538YfjrLXAbiHDOZhB7am9m+voTH+0K6Jq+hzHRR8taDyE
 fy8Stc1xa+F0HASztZx0pLVGG4QyIKbbjmqA7bZqGRVMKKWvKhH2wextdgn/3sB0FIZQ1oWaS
 G5LHFxYUvR/SHKt/lGwDoxl3mAKVwN6DXSjc5pthXUrsJKbADki3fAgKNeFddiTPBfJSpyfGY
 gODUhu4pi8u0OTlP4e8PW8BwIEmJCMt2gXh8p1P57zKkjEnesOmw8/20b4XVzAWlIOU4iXj2Z
 HHb3kp7J6N69xIDF7ahxagdW6jX9sWC/G4cFzazboO9cTWohTDf1qhF7gNGdhbh4Cg/oK4XDi
 Y88GY8mfgDI3/Z6YikFI9dhgoBRuBwJPREQ7Gqz1MiCOqv4JSW538fVzsZU6CDK40ClfRPDMz
 plSH3B2bEC+xfO6AzESG7+twc88lOIXf/N3MZkcBn6+6OdY2hDFh3Fb5ji0kLuy5Xku3Gfzge
 TXYxunZV7V+FZh5nJNkxXBCaFlqrlYOTX8it1mf/Mr3J2qwcz0Zj9uJ2bhcD/vGkm9y6UPFcC
 ZIurnv/qWDssRNQFdNWNRqn/M9E6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Jul 2016, Eric Wong wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > The common work-around is to install Info-Zip on FreeBSD, into
> > /usr/local/bin/.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thanks, t5003 now works out-of-the-box.
> Tested with Info-ZIP unzip installed and uninstalled.
> 
> Tested-by: Eric Wong <e@80x24.org>

Did you forget about this?

Ciao,
Johannes
