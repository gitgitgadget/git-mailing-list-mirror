From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: creating a new branch without an ancestor
Date: Thu, 4 Feb 2010 22:24:29 -0500
Message-ID: <20100205032429.GA23285@cthulhu>
References: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Wookey <michaelwookey@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2W-0003Bj-98
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647Ab0BEDYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 22:24:30 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59422 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab0BEDY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 22:24:29 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 26238822099; Thu,  4 Feb 2010 22:24:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139026>

* Michael Wookey (michaelwookey@gmail.com) [100204 22:20]:
> Maybe I'm missing something from reading the docs, but I couldn't see
> how to create a new branch in an existing repo that has no ancestor. I
> would like to do something like what git.git does with some of the
> other ancillary branches like "man", "html", and "todo".
> 
> I was hoping to do something like "git branch --no-ancestor
> new-branch-name" but didn't see anything in the documentation that
> describes the necessary branch options.
> 
> Or, am I looking in the wrong place?

git symbolic-ref HEAD refs/heads/whatever

That'll leave your index and working tree alone of course, so if you did a
commit right after that it would match the content of your current branch but
not the history.

    --larry
