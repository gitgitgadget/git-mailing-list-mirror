Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EEE1F728
	for <e@80x24.org>; Mon,  4 Jul 2016 06:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbcGDGkQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 02:40:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:61995 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbcGDGkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 02:40:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lj1Xa-1brePK0zEs-00dGc1; Mon, 04 Jul 2016 08:40:04
 +0200
Date:	Mon, 4 Jul 2016 08:40:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	David Turner <novalis@novalis.org>
cc:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Subject: Re: [PATCH v14 00/21] index-helper/watchman
In-Reply-To: <alpine.DEB.2.20.1607031350440.8378@virtualbox>
Message-ID: <alpine.DEB.2.20.1607040838270.8378@virtualbox>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org> <alpine.DEB.2.20.1607031350440.8378@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CdLyMpu2qTfaGN3rdsw22bXaIhw47hMVGQe3VfUXX0m7ajfJN21
 Ac+1CbuNOCf0mQVGuafgX6hfYfLpJZu9qNiVEycUsSLfnvzRiv2FIrc3kuLevii2q0NQ7Ng
 xY7eY/+Yc2k/Qg7Frhk/lDPYOmDM+hUYMbMOIAyKYCffWoxIIRFpbUoXV9Y394MH+OMzGup
 XtuNalhuooEGRqx5dzY3g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fOERaXnQw/I=:rGud5/+VKOBw0TaG4R+dWm
 ZGGDm6AclrIkTMKGu5jed+ci1MXPx9mgFfnzTFEQuvbJZxF1XGTXEL32BVsl86g+eiE4c/yIt
 cGdV3yWUgcY5jcqRV2GFQ6fxbsfSMoCj/71QjZc1QJ+VEn+e7zZ3uwm747uIFmcuwDoBz4CI0
 LfL73U7gG3UP4IZojIcPo/un+YpWAweWEQo9i/6ytDJ7VTje6tZCmydEZxDgFw3RDDnaNZu5F
 TcMH3NY9OUmnrseFjiJbRLKuFRHFqa19SYmpFzucMx/honmX0JHDX23DpdMuxZawIUrCkDH1m
 MUyCPFiiX2U0qurw0q3mbS/15LYa9BqujlkVXAlu254zX/4xR3T8UeuOBaBDky+/qrUrMCI7D
 0l9+HLWev0ZueQ5/wJ2UEEi8/wF3+xiMwirMjFwcdxyHLZNQ8xkUaoj3R1VEYobnCJmVcleIt
 Jd8I8AXDqYvoICIXfDLydXb5ojF+AFaqjY2SlUiOPAXiEMIr3EzRN5AXHtQJNpr7sZeqc4rUu
 Yt8u0/APP7RreFEpZdj/tzvTkd+Hg4zW9mamcBkZrZw6nfMWu3PCrNEYEbtmT6YTCcdFvrsTu
 Zo8C8x46oATrLKAn/igAlIUuwUS0omJaozT3GHowGimMp55RPWBPV14Yd226wOlWuMs0XpqB9
 rngg96swx0jwGD9iru13np3oQaSH+t0UqkSjf/xRP5ggaLU/XT6vX5IZY6j08vTC+QDQP9iau
 4FLVb1bacvXa3z7pvMo86sdFVgDeBffWrV08hlPs7dYIBVhtRrg9TXuoU/m+cTkMnWlLb08/O
 eJrKvJ+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dave,

On Sun, 3 Jul 2016, Johannes Schindelin wrote:

> On Sun, 3 Jul 2016, David Turner wrote:
> 
> > This addresses comments on v13:
> > removed unnecessary no_mmap ifdef
> > add an ifdef in unix-socket
> > OS X fix for select()
> > test improvement
> 
> Thanks.
> 
> Would you mind re-sending 20 & 21, they seem to have gotten lost. Or is
> there a public repository where I can simply fetch the branch? (I am not
> really a fan of applying patches from my mailbox...)

The patches arrived, thanks.

For interested parties: I rebased the patches (adjusting for t/helper) and
pushed the result to refs/tags/index-helper-v14-rebased at
https://github.com/dscho/git.

Thanks,
Dscho
