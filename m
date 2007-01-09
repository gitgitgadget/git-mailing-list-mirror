From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Mon, 8 Jan 2007 21:41:26 -0500
Message-ID: <20070109024125.GD1686@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org> <20070108140305.GE32756@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 03:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H46vd-0007Go-5M
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 03:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXAICla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 21:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXAICla
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 21:41:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59403 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbXAICl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 21:41:29 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H46vW-0000bY-4L; Mon, 08 Jan 2007 21:41:26 -0500
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20070108140305.GE32756@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36299>

On Mon, Jan 08, 2007 at 09:03:05AM -0500, Theodore Tso wrote:
> I would add a QuickStart Chapter before you start going into the
> "read-only" oeperations.  It would show how to create a completely
> empty repository, and add a few commits.  It would also demonstrate
> how to clone an example repository (with a fixed set of contents,
> stored at git://git.kernel.org/pub/scm/git/example and add a commit
> using "git commit -a".
>
> The basic idea is to show the user that git really isn't that hard,
> *before* you start diving into a lot of details.  If you don't tell a
> user how to make a commit until Chapter 3, he/she will assume it's
> because it's Really Hard, and you may end up losing them before that.

Yeah, I agree.  I just haven't been able to decide quite what to choose
for that purpose.  Some choices:

	- We could just pare down the tutorial a bit and drag it in as
	  chapter one.

	- I tried writing something modeled loosely on the hg quick
	  start.  It's a little out of date now, but that could be
	  fixed:

		http://www.fieldses.org/~bfields/git-quick-start.html

	- Or maybe a revised everyday.txt would do the job?

Any opinions?

> At least some discussions of branches needs to happen here;

The basic nuts-and-bolts (how to create and delete branches, etc.)
should all be covered, of course, but....

> it's really important to talk about different workflows, and how you
> use branches as part of your read-write operations.  Some folks might
> or might not use topic branches, but the concept of using temporary
> branches to try things out is critical.

.... Maybe it'd be fun to have a section called just "examples" at the
end of each chapter.  The sort of thing you're describing could fit in
well there.  I'd need some help collecting interesting examples.

--b.
