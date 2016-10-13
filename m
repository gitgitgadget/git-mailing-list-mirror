Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F46920989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756704AbcJMQLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:11:18 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:49089 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbcJMQLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:11:16 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buiaJ-0002Sm-AQ; Thu, 13 Oct 2016 18:10:19 +0200
Date:   Thu, 13 Oct 2016 18:10:17 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Uninitialized submodules as symlinks
Message-ID: <20161013161017.GC29710@book.hvoigt.net>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 06:17:05PM +0000, David Turner wrote:
> Presently, uninitialized submodules are materialized in the working
> tree as empty directories.  We would like to consider having them be
> symlinks.  Specifically, we'd like them to be symlinks into a FUSE
> filesystem which retrieves files on demand.

How about portability? This feature would only work on Unix like
operating systems. You have to be careful to not break Windows since
they do not have symlinks.

Cheers Heiko
