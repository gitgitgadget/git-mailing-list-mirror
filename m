From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: merge into branch currently not active / checked out
Date: Sun, 17 Jun 2007 12:16:35 +0200
Message-ID: <20070617101635.GK23473@cip.informatik.uni-erlangen.de>
References: <20070617072225.GF23473@cip.informatik.uni-erlangen.de> <7vmyyzylpl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 12:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzroI-0007F9-03
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 12:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728AbXFQKQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757755AbXFQKQh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 06:16:37 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:46899 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757683AbXFQKQg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 06:16:36 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 838313F42C; Sun, 17 Jun 2007 12:16:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmyyzylpl.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50346>

Hi Junio,

> If you plan to eventually ask somebody who integrates the 'master' to
> pull from you, and keep the resulting development history clean, (1)
> is _NOT_ a good reason to merge 'master' into your topics.  Because
> after your topic finally is finished, when 'master' pulls it, it will
> see many "senseless" merges from itself.

the problem is. Getting a patch into mutt takes several years. At least
it took for the hcache. So what I do is keep my patches up2date on top
of there HEAD. So I prefer topic branches. And my patches throw _once_
in 4 years a conflict that was not automatically resolved. I used
bitkeeper before, now I use git.

> Such "an integration testing" is better done, instead, by forking a
> 'test' (perhaps throw-away) branch from 'master', and merging all your
> topics into it.

I dislike it myself.

> Also, if you do not publish your work-in-progress topics, you
> might want to consider rebasing on top of 'master', instead of
> 'merging'.  Rebase can take the topic branch name and switch
> your current branch for you when you give it, like so:

I don't push my work other than in patches that is, so I am going to
give it a try. I always wanted to try rebase, but I never actually did
try it.

Thanks,
        Thomas
