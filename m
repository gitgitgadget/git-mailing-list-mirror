Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FCD1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbcIANFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:05:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:59419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754126AbcIANFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:05:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LdIBN-1bFQKe0sJl-00iUtr; Thu, 01 Sep 2016 15:05:05
 +0200
Date:   Thu, 1 Sep 2016 15:05:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/34] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <1472668773.4265.75.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011504550.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <1472668773.4265.75.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dy2p51OWuE+63R3nfEVqe/ZVXU8ujdZMDsgapRDD31w3xkHylTk
 jmFK9bC6MMvQVnG0d8yrNyb90b3rUjEk0ljAGvxOlBNYkN55/EpJpJ8Y8Wa9T4BoWfooQlf
 VmY+l2RVcWZQrLiJX7cGpHnHV0GOU3WSMzE8VWpMbfIt6IRrU+uAJyCvh9ZqFVeZCWie1yN
 TI0N7xEeP19+WneaNT2YA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BEWbD55bg1o=:SBMsiYQv0L+XA7wr+qHNUe
 1r81QGcBknXclsF1QaUoMgrfa6RXTqINCqRqG0Q/XNY/lZkNqJKg9MYdXQ530KQGmgNtCkF2c
 bJJvGQ2bQnQ6WR/I4kFmmFxhaKMdO7JpVLlsMcRWDsii68gnXo+ZCSqfzhsKuxv1FbjoA9MXK
 2ybwVBb872fPSdMt4whPG6qI3Eys/7a/A/2yMWkutfTyNOB8kqCk03nIQoZAbgDWOFTkg0SUp
 YtUaMG0GZi3a9QW8ouBKEi9IID+7oUTbNATY4y/boWCwbdcGLzazregboG6xrOD8YEwSJEadc
 ySNVlvpdQij132ta37CoEipLjcD2hC3Jt4f+RslgaVqhkPcIVShWq094tRou25QNjT4v65JV1
 QXbj1gf1s5x53f7VU0mkM+kwF68PsDel4f5lDY4mF4VSW23l7XAH41LxLq3/aCZ314R6T+5ss
 pDUN79De9Cz0BC/wXaQGEoOw1wzn/oeNpdmsh5lyPn0eftVOSHu++8+cUU8IxFDB186ojx24s
 sEcHNVlOeaVfPBugmsQnaAbaqw75rbf/lLa6yh4sNxcUv4NkVuDFUmA6oKjeKogtxdVYJAlbu
 FT+jDYBm+rNpA2SfXctNf52JxG2LfFSzqtp5xB6sl1pR5rzaV9wCHd7LB0IcFEgezfnuQ4b+o
 ADrH+bFDesAuu/+shw2uXi61P/EFWSsJdfFMc/TwckDHgXFgaMo1hK8ZsN8tQDdZnDuyiMnfx
 0lHdzFl5ccH2uBGH3asvavW7ZV+Npgxk/vHKehY6IDqVmf3++WC3GcLsBR65ACa3ovW/Yp5wK
 skaWy36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Wed, 31 Aug 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:53 +0200, Johannes Schindelin wrote:
> > This marks the count down to '3': two more patch series after this
> > (really tiny ones) and we have a faster rebase -i.
> 
> I got to 16/34 (and skipped 07/34), will continue tomorrow. I hope the
> comments are useful.

Much appreciated!
Dscho
