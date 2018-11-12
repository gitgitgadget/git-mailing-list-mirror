Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9621F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeKLVEb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:04:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:46303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeKLVEb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:04:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1gQohO1RmF-005GTa; Mon, 12
 Nov 2018 12:11:37 +0100
Date:   Mon, 12 Nov 2018 12:11:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
In-Reply-To: <20181109195934.GC4938@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811121211040.39@tvgsbejvaqbjf.bet>
References: <pull.72.git.gitgitgadget@gmail.com> <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com> <20181109101148.GB7410@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
 <20181109195934.GC4938@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/9vhqGJfn6Rau3gIom3ZSZaFgzVs9roQ8z5dhatW7ctY0OcV9jn
 ctiwvurO3ePutxTKq1fGM6RrQl0PvrL/q0OO4H6aCzzADl91pDqeULJJTYUe4B434jeMwqu
 3Gi5M8Rj2NKRjxARk6oS4ABmqAlgF6Cc01AnRCJ6efMRX9PFinv0OWBObdP1dep79emoVKH
 WNb2bdUrE9D1HBCAf9lGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oZz6/xnahJs=:SOtFr/dYvXxRoT8IyX2Vhd
 YZvYaZBh9xWC3/3UU7BRR4/xXQciTDaNgXTyk2GOGTukcGy0rw3Ndhg1xtSacTZ96WWs6Cw/7
 eM/u/pgb137R0SDhdc6eJjZ7ohyY3N7yfLKc+gdwfmejlMesU//iJL7qmKxNXncIxYAp4Y0IO
 HSieqzJ89tHpU9Jtmz6Scjg2g+PQl86h4PaVFhI8BYOldyhH6q7QbToqECxaiYObsSoANx4g9
 JICJVI2PX/8A+wdEr1upeExZjl23sLfH0upxC5mcrm+kwmI/ABTcn2V+LKL0mkGWdPedMnov5
 004bJCNAqRDYAgmUSpFwrx9fJTBDEd1KshPvnnR5rdipTgDxUgG2ln0j9p2YOfqlZVISYhhCm
 cEowzKN/xRwhA1qHKNmOLb8YqHHTrj/jO1MklDpxzDrliVAWgILLYqf3YbvgmCCJbySdvvkEq
 yczBTp/iUEwbMXO3l+sjD2DqhR19IkEBuFQRLoswN7sGcPTMTAujmPCwjaM7YHkmz+2+QEaAw
 gOqaL74WR6vRFVPhy1pM8voZmxa9HwNpGOND2g+GvSpAlbtFR8UirMR7q+Nj8icEkt7JPrsvJ
 0e2ez1aOzrY9vHDtgPb8oul+J05R0qUxfdoAiW2Mxdj6Y0NRai5zeuuezso9eH4ftnYRZUbLa
 Jk/86p3xjCitrbavBq5W/dq4oCTcmcfN2TPXfZSdhhbEkEfELyg0QwSrAzH5dSSFFPLXAD3s/
 37OTJ/CDLworxCQ6RKFCV33Dce09GhCWiApQ1wUZnvr1cVle20phg84p1npnG1pWYrv/tHyS5
 e2mA19VLUZ7uGJ/u84D+fGtND0Et632V1p75QJHxZsuzZ19J99VrfSEAPichEND+uuTaxXUT5
 n+sVO3dR1ZT1vJc2E1SIliIQwTwqU5/CA3NBGwVbsIwp2EUeG8995p4Iqwmd347d7PL9M4738
 bu5BlIqShwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Nov 2018, Jeff King wrote:

> On Fri, Nov 09, 2018 at 06:21:41PM +0100, Johannes Schindelin wrote:
> 
> > Actually, you got me thinking about the desc.buffer. And I think there is
> > one corner case where it could cause a problem: `struct tree_desc desc[2]`
> > does not initialize the buffers to NULL. And what if
> > fill_tree_descriptor() function returns NULL? Then the buffer is still
> > uninitialized.
> > 
> > In practice, our *current* version of fill_tree_descriptor() never returns
> > NULL if the oid parameter is non-NULL. It would die() in the error case
> > instead (bad!). So to prepare for a less bad version, I'd rather
> > initialize the `desc` array and be on the safe (and easier to reason
> > about) side.
> 
> Yeah, I agree with all of that.
> 
> One solution would just be to increment only after success:
> 
>   if (fill_tree_descriptor(&desc[nr], ..) < 0)
> 	goto error;
>   nr++; /* now we know it's valid! */
> 
> But there are lots of alternatives.  :)

True. I simply prefer to initialize it and be done with it. ;-)

Ciao,
Dscho
