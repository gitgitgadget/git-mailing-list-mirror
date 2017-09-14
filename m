Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD06209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 12:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdINMpl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 08:45:41 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.103]:44973 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdINMpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 08:45:41 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dsTWU-00068L-BM; Thu, 14 Sep 2017 14:45:38 +0200
Date:   Thu, 14 Sep 2017 14:45:36 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 2/4] push, fetch: error out for submodule entries not
 pointing to commits
Message-ID: <20170914124536.GA66700@book.hvoigt.net>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173027.GC144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912173027.GC144745@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 10:30:27AM -0700, Jonathan Nieder wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> The check_has_commit helper uses resolves a submodule entry to a
> commit, when validating its existence. As a side effect this means
> tolerates a submodule entry pointing to a tag, which is not a valid
> submodule entry that git commands would know how to cope with.
> 
> Tighten the check to require an actual commit, not a tag pointing to a
> commit.
> 
> Also improve the error handling when a submodule entry points to
> non-commit (e.g., a blob) to error out instead of warning and
> pretending the pointed to object doesn't exist.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good to me.

Cheers Heiko
