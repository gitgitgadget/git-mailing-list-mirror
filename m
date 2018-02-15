Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE071F404
	for <e@80x24.org>; Thu, 15 Feb 2018 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426512AbeBOQyc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 11:54:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:57063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426366AbeBOQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 11:54:31 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0Mg3Vt-1f72sG36YP-00NPjg; Thu, 15 Feb 2018 17:54:09 +0100
Date:   Thu, 15 Feb 2018 17:54:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Yet another approach to handling empty snapshots
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
Message-ID: <nycvar.QRO.7.76.6.1802151753060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu> <cover.1516791909.git.mhagger@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MVWbBxtg9akGsKdDl5/8HSPF9MmaKnYJJ5QeIfFGcvBI3/EB/GB
 yVTHc7a0yoxoEObYLNvxhD5rJamJAdR6my1LbG4HO26sodwnjDsQqdtuDIb7AH75ng5RM7j
 YdKEwkXT9NVbI1jtyYhNV3siQLk5z2oNQh1PvCOypWRSPgP+s5gH6l0UeCWf+2VfL+pjKCb
 hZac7DCdie0ZyxxlwMZeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nm3N23qjE90=:UbN209fOTd0FXgpjwC5XPF
 Jipsry/a8JmxO4x5n2zZmZcPhmjA7iliFpUCc5afdRZAUbpcprIqMBUygUSok8E/J83udKsJ1
 8FBNYgg/+les3OJer8hXs20LeGBc7DY6qJ0mqSR8LaHgKgzbSfPQRrtM99pDNc13fm3/TSLGk
 tVVHnwhFcaetLFB1TcsGIVEXwhKQ2pVIk5aHUw687KukN70Oakds6NASjNQsQlA4Auoa1v4Bx
 /3q3LNmu50Paoilf8hK793WdQleswKeIlO8WEI6hDb4j0lhzwK/lWeI2foowXhBN+g6GqinD8
 f3OLACKDARvGEwfWxfejsdeH1LNd1vIg7yhSJ/m8evBTYwF52j0BXA4cVmJG47tl8Y8KCarzc
 JlTHgs+ys4S8KtlWz0XWV7h9zR7NhKU5GHz3AFB8DM1rrpYhE9tMkzCUTLtNZoECI5ZajF6N3
 9zBXh7S+82mB6RnXJ6WAvyZ/hsB0lhZoqb7Saqdzzmj4TvPGTOZzqOwzwx0b6ULmDGC3D00+o
 lKMG2jEqaazj7W5rDzoN9gdEx9wesdBhrrTNBRJlJWrMscpl6360BnVB7vC2+Mt1U94EvIZqK
 1rr42NpDWAieTEqqrirGFn7QH2JjdQsZbJWJCOrZpPHswcNtwLUSkL1ColedUL8vdCDPsUXsP
 hQlz/oP/VOTWe1UCrLfAVw1bV1PAOM5o8dWvjp3WCqcQ7f+usUJfzYKjZKRV9jxBheasg0BiR
 nFT64n6a4gMPisIKq7Ap5xGjU7Zz4FPEdgzo/XGtYOEOb6ppYz51Y1/CI1QiC8L8Hy2Aajj5S
 VpKabXzNXsk6gK5p5zGMg+Y7ZHDQzAdCIPnWs7Y57hxRArs+1k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, 24 Jan 2018, Michael Haggerty wrote:

> This patch series fixes the handling of empty packed-refs snapshots
> (i.e., those with `snapshot->buf` and friends equal to `NULL`), partly
> by changing `snapshot` to store a pointer to the start of the
> post-header `packed-refs` content instead of `header_len`. It makes a
> couple of other improvements as well.
> 
> I'm not sure whether I like this approach better than the alternative
> of always setting `snapshot->buf` to a non-NULL value, by allocating a
> length-1 bit of RAM if necessary. The latter is less intrusive, though
> even if that approach is taken, I think patches 01, 02, and 04 from
> this patch series would be worthwhile improvements.

Thank you for Cc:ing me on this patch series. I tried to find some time to
review it, I really did, but failed. As I saw that others already had a
good look at it, I will just archive the mail thread.

I hope you do not mind!

Ciao,
Dscho
