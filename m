Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4601F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeCWRrN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:47:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:37029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbeCWRrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:47:12 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lzsf1-1eV3zk3ywF-0151hb; Fri, 23
 Mar 2018 18:47:08 +0100
Date:   Fri, 23 Mar 2018 18:47:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
In-Reply-To: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803231845520.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:S/eY24g/Nr0JKF7msE6fPJJP90swGeYsV00jS3cd3Fj62gf0g2D
 CPhgdctzpfVtB6TYk8oKF1T+tkvzeK6JTv3Q4W4Ifng+PTabK2V1XfZdYtPAKfEv3LyYgqD
 +kLkFowK91lyAvA8CD49SI18jS0/HTeCUkYE7RhEbvViP2o8x+BcZ9cGOb6UoHIwLs739gY
 Ze9P737Q5kEa6gJ11s+sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4Zy/MoVGYrw=:luCC78ZaP85jNPtklXh/z7
 htczSnIjIa6Pi6ae3Mcyhq2v5b2KNqxxE6uz4nKpOWigL5RGR4Xxe7LKDUJZs+BFsMPMH3+7S
 us8xwDXpuBp9Ci6sCfDal69TmNS1hGSk5YMoQORNVmNc2YWoAWeTTmPb1WvJPY8pVWKvAC5gw
 Nqcia9ud3sAPuuZ5aIAD3N8dzLGlXTzbhTKvW/MG9fEBc+pfwx0v8lN4p6mA26ShExn4QzWDA
 w/aG6yIxDX5Aeja1OkZG6FjSIvhqHB8YI2BUiA0Wxr4jX+wVuhJggV2/cgmw2TSJY/344XU9P
 7FX1dbuztX4UdH83tmGgvVWEs4vAHPPD8FSAWwdZlHv47emmSMhH22MGurhjj6+baC+xdNHJI
 VRchl/+NBSPumjuePO1W1EZMBynqgU9kUe2qAXAwLbt2oNjTTCr4C9EPAdiR+I+XhQt84qUEE
 SWfdOpLq4qRMt+jeTkbG1UG5yIRv/+4UEgNsdYHkVvSHVFWCwY+RMfDzjOvxjpQTEmCNfz9Dw
 ajnLxC+MniPa1CzeNmSY/9hK1T6CbmUZv1UA/J5tQ1H48PwX+3umO7zhEzXMXzHrOEs5m2hw0
 OsRVzjwssPIALN2SyCpvFOEFwFuEncrfR4M5UJri1YvlIFpTQ60OH08pye+QMaZuRBgCwCQl1
 IVWmLgjniqJcXNjzQmoCPenOzGmNlowAi/eHdHHAjeISvqpXTLaKWFhAKxPMYENWzU4qhclWJ
 5kmLkqSFRDu2ZrPqhpE+vICT0vGNQ0U77ZpCIDRVfztYBDUUGk5y545z+sGcYYpQDzghDzqiF
 msJ7tNN+5Ak9ikoaUS3sz/xbxX4sDNxXFT6qn1jIruMHel9X9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Wed, 21 Mar 2018, Junio C Hamano wrote:

> A release candidate Git v2.17.0-rc1 is now available for testing
> at the usual places.  It is comprised of 493 non-merge commits
> since v2.16.0, contributed by 62 people, 19 of which are new faces.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/testing/

And Git for Windows v2.17.0-rc1 can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.17.0-rc1.windows.1

Please test so that we can hammer out a robust v2.17.0!

Ciao,
Johannes
