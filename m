Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13882202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdJ2Me6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 08:34:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:53666 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdJ2Me5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 08:34:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y47-1dJ9U01f0p-00vAAr; Sun, 29
 Oct 2017 13:34:55 +0100
Date:   Sun, 29 Oct 2017 13:34:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v3] 0/4 fsmonitor fixes
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710291334290.6482@virtualbox>
References: <20171027232637.30395-1-alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lA9R6ejpiFoJX+i+FcHZ4jlwg+WjJPOZgkRNXbrBclUZYHEn8xz
 ZbF1YMDyIRCMDMSOPVsSOmMyB4WUVoivv8PS7XkxhkkrsHBPTcvOPuF9qO7nMPm5Yf95/V7
 RpsDURGlrJCXiHDn4sLZasVm1d7JH1kfvdOcfDiuSCnj6bWQC1HdknW8uGHA+hzyRyVTLqU
 SjvJ9bxh2xAN2nIohFu3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U0khXfAxcEI=:kv3Hw+V2vKKsP7eYH7wjT7
 wmz27npRgMAwK5t75rxxwiMNVtTidxpKBJGjVnIF7DiWQzl4TtDiq2CIgq4wO1bd96XnbLfKD
 TPADL2CH9F9QVx5qAwlsX1OrJotP32MygnFFRJIdFSjx5v/CUw0wU+AEAP8aUzGuH/jreiSV3
 dIamLsmIT3k85lNzRnaGGG7QvUJvAdBnXnEKrqNTAMvxKK0k1wss2/xM5kSBs9fihouT6LNoB
 X6l568Vhchqc+8VZVxhN1CaoC7Jrs1v7DVioQsw/dX1DPkP7o/GKfup/gqHieTHYTrDn5RWu6
 pKOpcvDPbpa6odg4Akb+a0DHWnQ0fguqnzBncyiMlKKGmLmEGLxyAdCQjTAx9mDQdEsblrYgH
 pQDVVpsYU3uApjuRNclVAPd3Rbw3FhKZgZuJ3VlgHtqzubE1x9ytnYGmZ3CMJbKpFAWe0x3Rd
 bKwdIypf1wtFJnXyotiAqdO2Aj6ih0A/OnDplbxNLNCILfmbznc2IbuGiSacnxBFykQd2XTQg
 kMyn7ifKuBB2dDC0hzYqv7CLVsjUUq9+Ab4+80bMCYRvccUkbEA9qGW2DQXdrHw8vzTdBLH7g
 Pp9LiTQGJNyvsFg2WuDXiJZ7OOCA8vR5jvJdVwjCy5MwW5g287V/hukeKG/xIMHiqHDHLjMBz
 pt9xvL2oBBYqnKt1SEb9o8mFYd/6Zc9USDsUbbrLN6issYTaU9anwCTqwIqwZ+q0OzFq7TxyR
 jSrlQaIROqWYk0neoYkVkPPRHExHQWlK61AuAMc2nj/+CHsjEU+oyy1dbcdVVTtK6bYhW79Wr
 o/pcOOvZQcyQ1sr6mZRvqEMaWu8xFSewPKMiEVuUzjnuRw11JLMi8QRvdy3Xx89eUFkglma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Fri, 27 Oct 2017, Alex Vandiver wrote:

> Updates since v2:
> 
>  - Fix tab which crept into 1/4
> 
>  - Fixed the benchmarking code in the commit message in 2/4 to just
>    always load JSON::XS -- the previous version was the version where
>    I'd broken that to force loading of JSON::PP.
> 
>  - Remove the --no-pretty from the t/ version of query-watchman in
>    2/4; I don't know how I messed up diff'ing the file previously, but
>    if there are already differences, it makes sense to let them slide.

Sounds good!
Dscho
