Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6E71FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168460AbdDXK0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:26:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:50315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168454AbdDXK0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:26:17 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtEtL-1c0ufW0Olf-012sTR; Mon, 24
 Apr 2017 12:26:13 +0200
Date:   Mon, 24 Apr 2017 12:26:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, martin.von.zweigbergk@gmail.com
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
In-Reply-To: <20170424032347.10878-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1704241225300.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ClDoF31TMo6qrD/6yayUbUoYQ/apjFRWAuRYKywch09WPlFVkvl
 mRSdLu2GNl5g+wRfsPHApBqr3ZeXOtxlol9VRV97uN14irRNGdoUDMntZpqmi7qVewRmdgH
 9/8/fcdjH/w447NxzEGnnYNnCsk6kbnm7T5UjaLE54Nu+JYoZNDrST3ZKSOJZnP+GGFxi3+
 qENR9BmB/8V6JLeD+lvQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O6NgTUz5fy0=:DjIxao6JzSzHGbo46mVuwT
 nhisqp001ViVSaL5NNZO+lpYG5x71Eu1PUHIwt4lUjysuOASxnkh/MAgf0L/PipD0jvVlRH0C
 qOjBrIFplK9I3/sqoe7FglW2jVIeQ+TpMGnQaDlD31qJnZP0BhjVdkQ2AWeaVEpIRUljJ84m8
 eDCX6rAIntQ0AfhW7wPxh1FIUpH4ylNxTARuQ6+oDKO6hg+tCf4ZBag0/cqeLnFEUYChWp0m/
 Ol3/Q7nxWXVjrYqzjjPGBVLDBbXnjkfzdHlsbRASFr6sfi5KHQ9s2m+h8bc7dPDCHW5W9V/gR
 EyqGMDm3UwCnfSqFeVxb40H7HewjeOEua5nO7m4jNIhFnh/wbEYCzg3gVtNHXcG7crROlLRxm
 IspS6j38/pY8X/9uk0mH5/Axer0H4MT+UbftsFITwPE55fUYztgxRVyeshWNevF80FuXqSrW3
 DPvOGx1WQlR9oqBsrNs+cBZT7yhArIt+g1a7tMuoPdPdAcWK4EpIpZ00IOLlqdBgm50TPu85v
 Aov14MEtjsZoJG/98ZxUfAFS82xPH7OmMJx9FnkQKsPMCEZS59k1Cm45eg5opkYCwRBQHnDam
 9ygNjh2SLYinmeZ9n/FdgC5rUCIg7A6WoJ8YJcANPpZmVctN9ODHFPY4reiAodzOEZf6mIYD8
 CvFguC7I3Uxq4OMR8B12PStqvFv9q4J3nlfYPCuZVUu+Wv3LXoFrUzqkT90bQT9KdHiVVRx3G
 cVpkGwOpcIwYAhij2a9KVu9s6vm2QPW/yYzj0SF8m867WiuiEMuPsZkQtZkVDrTCr8dFiSE39
 31wVuOp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 23 Apr 2017, Liam Beguin wrote:

> Add the 'rebase.abbrevCmd' boolean config option to allow
> the user to abbreviate the default command name while editing
> the 'git-rebase-todo' file.

This patch does not handle the `git rebase --edit-todo` subcommand.
Intentional?

Ciao,
Johannes
