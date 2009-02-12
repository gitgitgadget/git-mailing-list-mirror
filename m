From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 17:17:32 +0900
Message-ID: <20090212171732.6117@nanako3.lavabit.com>
References: <20090212062514.6117@nanako3.lavabit.com> <7vljscbp60.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 09:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXWnM-0007FD-K3
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 09:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbZBLISE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbZBLISC
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 03:18:02 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55432 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbZBLISA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 03:18:00 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id F067611BAA1;
	Thu, 12 Feb 2009 02:17:59 -0600 (CST)
Received: from 1625.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id J0VP8IRGFU6I; Thu, 12 Feb 2009 02:17:59 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hzyj1JIW4DAfrRlbBD+JKEs2nk32eZo37A3Qk+slFSKgLp26awd3Aty+bVTOl3uMTqKP3pnwPX6nZpZX5zq7GlDcpVgEVzovXYk6xFAzX6sHNxK+1De+yrS2qJ7TTRBHxjdHR2rXdLPHCIUpnnvrgJTeIMZVENJ93uZJDBqP2pg=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vljscbp60.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109583>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> But I somewhat doubt if this line of change is a good idea to begin with.
>
> All talks about using stash --no-rest and snapshot share this problem.  By
> not making regular commits, you are denying yourself the rich set of tools
> git offers you to use on regular commits and the ancestry chains between
> them, and nobody explained what the benefits of not using normal commits
> on normal branches are, nor how the inconveniences from this aversion to
> branches forces you are justified by those unexplained benefits.

I'm sorry. I didn't think about such a negative aspect of adding the feature.

I can imagine that, after using many 'stash save --keep', I'll naturally want to manipulate changes between kept stashes, like running 'git log' to view the difference between each step and cherry-picking a change between ones next to each other etc. Because a list of stashes doesn't support such operations, additional support for them is needed to make it useful, but I agree with you that such additions are not real features that are necessary, because git already supports these operations if I used commits on a normal branch instead. Use of 'stash save --keep' is making it necessary to implement duplicated features for no good reason.

It may also confuse users by unnecessarily adding another way to do the same thing. So I think you're right to point out that this is not a good thing to add.

> This topic won't go beyond 'next' during this round because it started way
> after -rc0 was tagged.  It is not urgent to decide what will happen to the
> recent "snapshot" related topics, and we have plenty of time to toss ideas
> around, but currently I have to say that I am not very enthused about any
> of the causes mentioned in various discussion threads.

You already applied my patch on pu branch. It's OK by me if you dropped it.

Thank you for your comments.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
