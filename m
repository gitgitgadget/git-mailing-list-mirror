Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996681F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbcJENxc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:53:32 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:49311 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbcJENxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:53:32 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brmdT-0002PM-4t; Wed, 05 Oct 2016 15:53:27 +0200
Date:   Wed, 5 Oct 2016 15:53:25 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
Message-ID: <20161005135325.GC30930@book.hvoigt.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004210359.15266-1-sbeller@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:
> Jeff,
> thanks for the suggestions, both git_path(..) as well as checking the config,
> this seems quite readable to me:

When reading the discussion I thought the same: What about the
"old-style" repositories. I like this one. Checking both locations
is nice.

Cheers Heiko
