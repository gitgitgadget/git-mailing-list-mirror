Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974BF1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 13:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeCGNRC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 08:17:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:39851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeCGNRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 08:17:01 -0500
Received: from [172.16.5.73] ([84.88.84.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtZcC-1ejQ1E0nCu-010tiu; Wed, 07
 Mar 2018 14:16:56 +0100
Date:   Wed, 7 Mar 2018 14:16:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Siddhartha Mishra <sidm1999@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
In-Reply-To: <CAMOtk6BafDOX6PkOs=KVPp5rf1wF3Zq9ZWMAiKgw+EN2KTsndg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803071416350.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180305200400.3769-1-sidm1999@gmail.com> <xmqqpo4i6lj0.fsf@gitster-ct.c.googlers.com> <CAMOtk6BafDOX6PkOs=KVPp5rf1wF3Zq9ZWMAiKgw+EN2KTsndg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QizMwgkoK4A8b/mQO+d97kBXNK+PxfrW+G38N/XffPRcxsc4LBX
 GPptQwQg9KqnnETxrlfPM2XUvF7SZXPO3VduGnRlmvIkUPdAVM+oHqrPWZil0ObCNKV7MfJ
 rvmhd0M7096fUDt3WkTJHClKbLKKDTUhHoukV3CSFp9CGxMod9dUzkZ3YBtJqbm0sTOoiB2
 8VR4RX6UWQenBiM+RPp+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k309/jwv0c4=:hP37rV6jo3g4WRK75XxHX3
 b0Tdb36wZyYsvvI2u7zlSa44AH8F4HhScwh0UPu0v1v4wGvoi2a63YZ2yyGnN+TRY66ZBxuU/
 4K2SilxR37tDwO+I1/KeM52rEX8g6he0Lc9duXYr6lIPcZXw5+zStVecOHJFOTyxEjFD2a0rv
 nXdHosJm/cd1SszEc1tKTqXphl6dehbQ2EgsN1YnvP6EaVLpr3w5BcLnAW/YdyVONvYSIYcwG
 Dm7JTEdJSOSZRW3cOjo09x10kmdmPCHzRrdcQCWVXKBzsOTrBdNjSNkE/jyu6wn9YKM1c7HhF
 Lk9g/T6gTjNzyGIysqJz+7ph+KPkIi6mCoYjz/xcBYF7MzbW6CBi2HSRGfzjMcNKN4hf7xnNu
 JfJ59fKvLb3hsReiEp9IXVP+Of8HcpSHRP/RjO93XMUMLjfG+RVtQ8FvPBZhkxdQa0Kb7bmNI
 uxCLtmg8M1VjzyXvsPK7R208+gDXcihtQsQQf5Z9jPSTM3T8jGlt9t2A4uD97MWtEIf6vfXCQ
 tcYDdRT0/4DY7h8ghEAvbCuQ+1y/gPJE2LK/in5W8/XNhKsyTTsGnL5fjwY3S4hkKrwrXZq06
 KohEQFhcrSSDiHlg4lxngYKuKjQv82h6pwr7H1FXTYo/+K+RuDKNkCHbDeT688AviCTixfXSn
 uHOclhs4qW1GZ6CfRiqzIGRaF/1fTakxcywc++xxRbgcvZDK+mqZEef/yBhlgELEI8D5LYpGA
 EpPCLqhPXOFofNZZpZBBhCJdKGRv6prtneEC30+VeMF93f43VJM/69FQRBwGPifCcLVl6+kvA
 OxxUV/fVwpDvPpFuZNES+huoY5N4ShPE4zd9fiCHtNAu7DwO+4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Mar 2018, Siddhartha Mishra wrote:

> Are there any other glaring issues you see in the code?

The rest looks good to me!

Ciao,
Johannes
