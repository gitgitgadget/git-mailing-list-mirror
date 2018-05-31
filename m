Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6421F42D
	for <e@80x24.org>; Thu, 31 May 2018 16:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755831AbeEaQj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 12:39:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:58044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755697AbeEaQjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 12:39:54 -0400
Received: (qmail 11147 invoked by uid 109); 31 May 2018 16:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 16:39:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15166 invoked by uid 111); 31 May 2018 16:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 12:40:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 12:39:52 -0400
Date:   Thu, 31 May 2018 12:39:52 -0400
From:   Jeff King <peff@peff.net>
To:     Erika Voss <erikav@zillowgroup.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Vulnerability Announced?
Message-ID: <20180531163952.GA9423@sigill.intra.peff.net>
References: <D47B86A7-2E5A-4401-99B2-E59FD859C7E6@zillowgroup.com>
 <001301d3f8f8$65bc6660$31353320$@nexbridge.com>
 <E1D8F36A-9317-41ED-B761-2AE15B54B927@zillowgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1D8F36A-9317-41ED-B761-2AE15B54B927@zillowgroup.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 04:00:38PM +0000, Erika Voss wrote:

> Yes here is what was sent to me - 
> 
> https://www.theregister.co.uk/2018/05/30/git_vulnerability_could_lead_to_an_attack_of_the_repo_clones/
> https://www.debian.org/security/2018/dsa-4212

Yeah, the release announcement from the project is at:

  https://public-inbox.org/git/xmqqy3g2flb6.fsf@gitster-ct.c.googlers.com/

> The one that I could find from online was:
> https://git-scm.com/download/mac
> 
> But, the latest version available on this site was 2.17.0, which does
> not include the security patch.

The binary installs for MacOS are done by a third party, and sometimes
lag the source releases. You can build it from source yourself, either
from a tarball:

  https://git.kernel.org/pub/software/scm/git/git-2.17.1.tar.gz

or by cloning with git:

  https://kernel.org/pub/scm/git/git.git

There are some instructions in the INSTALL file, which you can also read
online:

  https://github.com/git/git/blob/master/INSTALL

You can also use Homebrew to install, which usually updates to new
versions pretty promptly:

  https://brew.sh/

-Peff
