Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6492920989
	for <e@80x24.org>; Thu, 13 Oct 2016 19:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756609AbcJMTqc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 15:46:32 -0400
Received: from ikke.info ([178.21.113.177]:53790 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756513AbcJMTqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 15:46:30 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 28D6A4401D4; Thu, 13 Oct 2016 21:35:58 +0200 (CEST)
Date:   Thu, 13 Oct 2016 21:35:58 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Uninitialized submodules as symlinks
Message-ID: <20161013193558.GC1698@ikke.info>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
 <20161013161017.GC29710@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161013161017.GC29710@book.hvoigt.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 06:10:17PM +0200, Heiko Voigt wrote:
> On Fri, Oct 07, 2016 at 06:17:05PM +0000, David Turner wrote:
> > Presently, uninitialized submodules are materialized in the working
> > tree as empty directories.  We would like to consider having them be
> > symlinks.  Specifically, we'd like them to be symlinks into a FUSE
> > filesystem which retrieves files on demand.
> 
> How about portability? This feature would only work on Unix like
> operating systems. You have to be careful to not break Windows since
> they do not have symlinks.
> 

NTFS does have symlinks, but you need admin right to create them though
(unless you change the policy).
