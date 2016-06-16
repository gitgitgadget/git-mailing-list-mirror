Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B451FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbcFPK4N (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 06:56:13 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:39496 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbcFPK4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 06:56:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id C29C3463315;
	Thu, 16 Jun 2016 11:56:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIn4kY1xxRlV; Thu, 16 Jun 2016 11:56:00 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 3CD174630EF;
	Thu, 16 Jun 2016 11:56:00 +0100 (BST)
Date:	Thu, 16 Jun 2016 11:55:56 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Andreas Krey <a.krey@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: Code review tool recommendations - replacement for crucible?
Message-ID: <20160616105556.GA8721@salo>
References: <20160616094108.GA14661@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616094108.GA14661@inner.h.apk.li>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 11:41:08AM +0200, Andreas Krey wrote:
> Hi all,
> 
> I'm looking for pointers to review tools that work with git (obviously),
> and can deal sensibly with bigger reviews. Things we need:
> 
> - Ability to split (set of) commits into multiple reviews,
>   so parts of changes can be reviewed by the respective owners
>   (or assign different reviewers to different files/subtrees
>   in a review).
> 
> - Tracking of files (or changes) already reviewed (due to the large numbers),
>   and of the handling of issues found so far.
> 
> - Support incremental reviews, not just e.g. over the content of a
>   pull request (bitbucket) When review comments are processed people
>   want to be able to only review that change, and not to be forced
>   to find that change in the entire previous changeset without
>   the tool's support.
> 

Hey,

Have you considered Gerrit[1] already?
It would seem to handle the cases you're interested in.

[1]: https://gerrit-review.googlesource.com/Documentation/
