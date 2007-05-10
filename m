From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 22:29:28 +0200
Organization: Dewire
Message-ID: <200705102229.29221.robin.rosenberg.lists@dewire.com>
References: <1178794261.5806.98.camel@murta.transitives.com> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu May 10 22:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmFGW-00013k-5a
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbXEJU31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbXEJU31
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:29:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:24593 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXEJU30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:29:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 127C0802655;
	Thu, 10 May 2007 22:23:17 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01396-02; Thu, 10 May 2007 22:23:16 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 91D56802802;
	Thu, 10 May 2007 22:23:16 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <87tzuk31fu.wl%cworth@cworth.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46897>

torsdag 10 maj 2007 skrev Carl Worth:
> But there are still some places where an experienced git user runs
> into some awkward situations trying to use stg. For example, "stg
> refresh" is basically always doing the equivalent of "commit -a" so
> there's annoyingly no way to refresh only some of the modified state
> into the commit.

List the files to refresh and you get what you want.

	stg refresh file1 file2...

> Also, if I want to edit a commit message while under the influence of
> stg, how do I do that? If I do "git commit --amend" will I seriously
> confuse stg, (I'm guessing I would, but I don't know).

	stg refresh -e

[...]
> Plus, all the stuff that stg provides to allow it to be used
> standalone ends up just being noise to the git user that just wants to
> do some stack-based manipulation of an unpublished branch, for
> example.
>
> So, I'd really like to see something more integrated into git itself
> that provides some of the missing functionality.

I agree mixing stgit and git is not really comfy until you learn it and still
I mess things up somtimes. Also rebase seems quite a bit faster than stgit, but I
have not intuitive understanding for rebase so I get scared everytime. Having
a gui that lets me mark commits and "drag" them to the new location would
be nice.

-- robin
