Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77F0206A7
	for <e@80x24.org>; Thu,  3 Nov 2016 16:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758762AbcKCQvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 12:51:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:57539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756737AbcKCQvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 12:51:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mcyxq-1cJJt21ul8-00IAO1; Thu, 03 Nov 2016 17:51:22
 +0100
Date:   Thu, 3 Nov 2016 17:51:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: Help with vger's rules, was Re: [ANNOUNCE] Git for Windows
 2.10.2
In-Reply-To: <20161103153845.nhquuoko4utecit2@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611031750590.3108@virtualbox>
References: <alpine.DEB.2.20.1611022158140.3108@virtualbox> <alpine.DEB.2.20.1611031554100.3108@virtualbox> <20161103153453.4aipi5lxkmkt3kco@sigill.intra.peff.net> <20161103153845.nhquuoko4utecit2@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pRHuK+2JW3CckxOe9ouWYYethhGBuLWo4mgvGTEDTyxuYC1wgCr
 5y/uCE7XFZGXp4ui0tUVrgHkDZGryz5aaC5l3X9EWzaH4xAfBF1jPOjMbhDt6RvHXh2qv8R
 RvGI3uXyJgdN9bm7Pt+7pOw5Ta6dhKxDZZZy88h+6Hiegm/6VG3MtCQdTPrDbTz80F/LJg9
 RtBbmrgDLt/b4FvikIThA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e0Vlc7fvdp8=:3dWdoAN0/BSV/VUc2/Wz+b
 Ex7W1ASc2ee1Y2f2BMxV0c7bHSzirTOmBkpTumowSaaQ8RFZ1ce58MP5D2QrQ1cxoMu3FJi/u
 ZuLNQpflwn5IIvrRSyrgAv0Dzx5JhT9rdc5TF8i6TfSk+n09wkPXCLEBr9J7VZQJ8ecBOLJjS
 I6qC1p4gMLMZ7zEq4HyngsGW7VQhpCUBCmbW+3+retIGRGkx7EWDZ6Rc2jI8yUmTLegUnaOQP
 0SaJwidY6mqfeFfeODQECK9Y5x17maYqqvjdQhIuho2oIaRjqjBUr6isS36utjyL+F+r4hBLj
 fpCoATqbOkMyHe9Xm1/SfEGPxjey5r7nex6nl+IkofCa1y/fd2AEFBeofsr5JxN5UaQl1Q468
 aFZmsUsD3U056+pZxPWJnVpPknZ3KP7vYRwFyjfS61ZyKu7UFpGnLdfAorVj0+6iIFzgvolPR
 H6uZvT92/CVHT0eUe5Y+yZGAzAIh9eeE94qj0IDlUEvDtZCDbcR6y0LI8FDtmcEh2PseI2EFq
 7mMVHLO9jIJ+FwVALFeG9fKJkdW8R4pXUnKgc8AWm8YMngZPld+u0VzWnmlRUpS21pPG9k4yc
 Pwu25XdYhjAOv+g4AqjQoBgrPFq56OCacfFHjFXEYWuV3eVAbt/1VJsreSWTWBbsrl7AvDEHE
 yxku0Sf30dMZV/LknGah46oRWZSFfcRsvXLce27XRLXM+ZPH4gwUY1nVLBvOLHc8216w6u4sW
 QYk9HZNFGZR6nFoBEtSK2gcQzw7/96BOY75xL0qAKw0MECDPdiP5UpEC0wzz63zM6JFOa44Dv
 yluCelm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 3 Nov 2016, Jeff King wrote:

> On Thu, Nov 03, 2016 at 11:34:53AM -0400, Jeff King wrote:
> 
> > This is missing a Content-Transfer-Encoding. I think the default is the
> > traditional 7-bit ascii encoding, but your body has characters with the
> > high-bit set (your UTF-8 bullet).
> > 
> > Try adding:
> > 
> >   Content-Transfer-Encoding: 8bit
> > 
> > I haven't seen this before, but I do recall that vger's MTA is very
> > picky about this and wants to rewrite transfer-encodings, so it seems
> > plausible.
> 
> Technically, I think you'd also need a:
> 
>   MIME-Version: 1.0
> 
> header.

That seems to have done the trick, thank you so much!

Ciao,
Dscho
