From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: allow git-svn to update remotes outside of
	refs/remotes
Date: Mon, 10 Aug 2009 01:38:18 -0700
Message-ID: <20090810083818.GB8698@dcvr.yhbt.net>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com> <1249350039-7338-2-git-send-email-adambrewster@gmail.com> <1249350039-7338-3-git-send-email-adambrewster@gmail.com> <1249350039-7338-4-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 10:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQOh-0001fY-7I
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbZHJIiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZHJIiT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:38:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50255 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbZHJIiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:38:19 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 2BD431F585;
	Mon, 10 Aug 2009 08:38:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1249350039-7338-4-git-send-email-adambrewster@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125408>

Adam Brewster <adambrewster@gmail.com> wrote:
> It may be convenient for some users to store svn remote tracking
> branches outside of the refs/remotes/ heirarchy.  [1] and [2] indicate
> that there is interest in making this possible.
> 
> [1]  http://www.gitready.com/advanced/2009/02/16/convert-git-svn-tag-branches-to-real-tags.html
> [2] http://kerneltrap.org/mailarchive/git/2007/8/30/256359

I definitely agree with the direction of this...

We'll need a mechanism for migrating existing repos from
.git/svn/foo/* => .git/svn/refs/remotes/foo/* to avoid breaking
things for people with existing repos.  I guess that's why
you've been looking at (and helping fix) the migrate test :)

-- 
Eric Wong
