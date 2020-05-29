Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4FC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E858E207D3
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436522AbgE2Ddq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 23:33:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59644 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436471AbgE2Ddp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 23:33:45 -0400
Received: (qmail 1007 invoked by uid 109); 29 May 2020 03:33:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 03:33:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20567 invoked by uid 111); 29 May 2020 03:33:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 23:33:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 23:33:44 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
Message-ID: <20200529033344.GC1271617@coredump.intra.peff.net>
References: <20200528231608.59507-1-emilyshaffer@google.com>
 <83936F1F-BFA8-4F74-8C24-07D42B1A044C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83936F1F-BFA8-4F74-8C24-07D42B1A044C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 09:49:51PM -0400, Philippe Blain wrote:

> > In the index.html.erb diff I'm interested in wordsmithing feedback; this
> > is the page which appears at https://git-scm.com/community. The diff in
> > _debugging.html.erb is modifying the list of references in
> > https://git-scm.com/docs - I'm interested in feedback on whether this is
> > the best header to include git-bugreport under.
> 
> I think maybe `app/views/shared/ref/_setup.html.erb` would be a better fit ?
> That's the section at the top of the page, with `git`, `help` and `config`, called
> "Setup and Config"... 

Good suggestion. Most of "debugging" is about debugging your own code.
And I think it's good to have this up near the top, where people are
more likely to stumble into it while trying to figure out how to report
a bug. :)

-Peff
