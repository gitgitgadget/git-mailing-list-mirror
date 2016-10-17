Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE51920988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbcJQJ2q (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:28:46 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:58598 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbcJQJ2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:28:45 -0400
Received: from [88.217.180.208] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bw4Dn-0004du-Sd; Mon, 17 Oct 2016 11:28:39 +0200
Date:   Mon, 17 Oct 2016 11:28:38 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Uninitialized submodules as symlinks
Message-ID: <20161017092838.GC43997@book.hvoigt.net>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
 <20161013161017.GC29710@book.hvoigt.net>
 <20161013193558.GC1698@ikke.info>
 <xmqqr37izxkf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr37izxkf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 09:48:16AM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > On Thu, Oct 13, 2016 at 06:10:17PM +0200, Heiko Voigt wrote:
> >> On Fri, Oct 07, 2016 at 06:17:05PM +0000, David Turner wrote:
> >> > Presently, uninitialized submodules are materialized in the working
> >> > tree as empty directories.  We would like to consider having them be
> >> > symlinks.  Specifically, we'd like them to be symlinks into a FUSE
> >> > filesystem which retrieves files on demand.
> >> 
> >> How about portability? This feature would only work on Unix like
> >> operating systems. You have to be careful to not break Windows since
> >> they do not have symlinks.
> >
> > NTFS does have symlinks, but you need admin right to create them though
> > (unless you change the policy).
> 
> That sounds like saying "It has, but it practically is not usable by
> Git as a mechanism to achieve this goal" to me.

Yes and that is why Git for Windows does not use them and I simplified
to: "Windows does not have symlinks". For a normal user there is no such
thing as symlinks on Windows, unfortunately.

Cheers Heiko
