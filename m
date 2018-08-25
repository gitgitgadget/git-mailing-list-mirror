Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDB61F404
	for <e@80x24.org>; Sun, 26 Aug 2018 00:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeHZD0s (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 23:26:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:55719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeHZD0s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 23:26:48 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX4u-1fx0Zs1nUC-003JGu; Sun, 26
 Aug 2018 01:46:12 +0200
Date:   Sun, 26 Aug 2018 01:46:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive
 rebase
In-Reply-To: <20180823024856.GH92374@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <20180823024856.GH92374@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xMRlllGBOjB/RAOi++XV5NdcYpqTGLhqP6khbH9ttMvyVXnI2rM
 UF0b6B51O8u33iw0l0XUnu8AIks8tc5nqZ2/OtLME3OWcxrraZYVetVSXtJf2TJ9iX0oOhv
 pwApj9AFNf2JXw+GyMB87TsUHNtv/BnRcQ2kU9HL/wpMw+FrDy0bmYjo2cMPP8PfWekOpzd
 nGvQ4/wro0V0cDC0Hzorg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TKHCIYtaraw=:AOCE68ZBD3nNmdXRIWVJmS
 dc+fIn8QW5gUIyWLOuewdTW5sO+61+dX4QW1Zw7zK9ys87rwqo/+msihIF+qvcBA6s9iJ/6Br
 NF0DK3WEKplpjwnfFd9W5ewJjX/1qMsByDXQfGawc2wPfSnWqmj8CkqDHupTXmTFJKdGvBYmW
 smsPbc+Q4mJL2tU5zjCntinANH70r7MnXMEV5UHHWhdKQ2HpDNFfMNxlY9O+7gx+IBFyLAeRA
 L3TbBrslsENup3zIcEOjj95H//7NVevCg55vL2mXzYqkPCjdWynyM+SHdOF53619Y6cF8UGiw
 3nmQD6ZeiJ9eg/jK1OjAYVXiqekWbPU6w0GaDn8kBoqeLK+OFaLHHNbM/KQzHQyEl2cxUw5OA
 /7f83TQqgIewNZjlm/zxi/oCWhf589Fx4A5+y73oymyGM+fhchxwaqDwwrfJcIu56HfNmbZYq
 v6AUdm6kmewoqyqm0R2fCA+t8mrvhTNJnsGZ8f82Yx8fdVp6Fjb5+4tXjNY/NBHUbePe/KrqI
 yWpMpr5UZOPbLRCUYU+vCMS/uWfxGi9fsZ6sDRns6IySQH+h9BPWkxD7F2e98k211dMap0q79
 2/7ldkFH3OLq66nta/R4Vm8eeMLbsaTpYP9v7qHjn7nauvm54ANTNCFu9eFRbAfcjz4rQk2tO
 Cpsar7gGJCwPeLv4mHyENJ7eA0lDGyOenr/EsK7CebU6RwUyTe1iBXi3wFFbYogdQWnOWD13H
 h/SKhdX+41hvvh7W3bgCg69tIfmC9LSV8+74y9ey9nsOl1riYMbphVv55wZHoR75b3b6Xv6eq
 QRg24e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Aug 2018, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> [nice description snipped]
> > This patch fixes that.
> 
> Please include this information in the commit message.  It's super
> helpful to find this kind of information about why a patch does what
> it does when encountering a patch later "in the wild" (in git log -S
> output).

I thought I did include the relevant part? As to the full back story: I
was repeatedly dressed down by Junio in recent attempts to include more
motivation in my commit messages. So I am reluctant to do as you say,
because Junio is the BDFL here.

Ciao,
Dscho
