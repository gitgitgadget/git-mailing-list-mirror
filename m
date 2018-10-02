Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FF31F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJBVTe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:19:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:38522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726118AbeJBVTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:19:34 -0400
Received: (qmail 440 invoked by uid 109); 2 Oct 2018 14:35:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 14:35:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28654 invoked by uid 111); 2 Oct 2018 14:35:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 10:35:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 10:35:51 -0400
Date:   Tue, 2 Oct 2018 10:35:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Stanis=C5=82aw?= Drozd <drozdziak1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-remote-helper list command question
Message-ID: <20181002143550.GA24480@sigill.intra.peff.net>
References: <e63531d2-d0d9-7b37-480b-b7f2a40782e4@gmail.com>
 <384e746b-4ca4-1f5e-0c58-accac06ffaf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384e746b-4ca4-1f5e-0c58-accac06ffaf9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 11:43:50AM +0200, Stanisław Drozd wrote:

> I'm trying to write a fast-import-based git remote helper, but I'm not
> sure what the output of the `list` command should look like. How can I
> find an example of the format in action?

There's some documentation in "git help remote-helpers".

For working examples (of this or any other remote-helper stuff), your
best bet is the git-remote-http helper that ships with Git. E.g., you
should be able to do:

  echo list | git remote-http https://github.com/git/git

to see sample output.

-Peff
