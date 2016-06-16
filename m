Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.4 required=5.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896AF1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 12:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbcFPMO0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 08:14:26 -0400
Received: from continuum.iocl.org ([217.140.74.2]:32957 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcFPMO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 08:14:26 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u5GCEJs20728;
	Thu, 16 Jun 2016 14:14:19 +0200
Date:	Thu, 16 Jun 2016 14:14:19 +0200
From:	Andreas Krey <a.krey@gmx.de>
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	git@vger.kernel.org
Subject: Re: Code review tool recommendations - replacement for crucible?
Message-ID: <20160616121419.GQ30134@inner.h.apk.li>
References: <20160616094108.GA14661@inner.h.apk.li> <20160616105556.GA8721@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616105556.GA8721@salo>
User-Agent: Mutt/1.4.2.1i
X-message-flag:	What did you expect to see here?
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 16 Jun 2016 11:55:56 +0000, Richard Ipsum wrote:
...
> Have you considered Gerrit[1] already?
> It would seem to handle the cases you're interested in.

Possible, but only after a lot of user education.

We don't currently rewrite commits for review comments, and
neither can we get (all) people to create feature-oriented
commits, so we really need to review multiple commits in
one review, and assign reviewers to subtrees. We could do
that by repacking the changes into new commits, but that
would defeat the purpose.

Also, we often do reviews after feature integration,
and also do partial reviews long before a new
project is integrated.

In other words: Lots of impedance mismatch.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
