From: linux@horizon.com
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: 7 Jun 2007 12:51:50 -0400
Message-ID: <20070607165150.27434.qmail@science.horizon.com>
References: <5971b1ba0706070057l2d4b170emd8af733d888d6a56@mail.gmail.com>
Cc: git@vger.kernel.org
To: godeater@gmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Jun 07 18:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwLEJ-00076u-Ad
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 18:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765650AbXFGQvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761828AbXFGQvx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 12:51:53 -0400
Received: from science.horizon.com ([192.35.100.1]:10931 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1765431AbXFGQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 12:51:52 -0400
Received: (qmail 27435 invoked by uid 1000); 7 Jun 2007 12:51:50 -0400
In-Reply-To: <5971b1ba0706070057l2d4b170emd8af733d888d6a56@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49375>

> Thanks for this extremely length and informative reply - it's answered
> all our concerns, and we may well move to git sooner rather than later
> now!

You're welcome.  You just seemed to be under some misapprehension.
Git can certainly do all the basic things that svn does, and just
as easily.

You'll only have to learn more because you'll want to do more.

There are three big things that you'll want to get used to
when coming from CVS or any other centralized version system:

1) Don't blink, you might miss it.  If you're used to CVS, you might
   wonder whether git actually *did* anything.  Commits, in particular,
   are instantaneous if the necessary data is cached in RAM, and it can
   take a while to learn to trust that everything worked.

2) Commits can be undone.  It can be a bit scary the way a command
   like git-rebase will make a whole bunch if repository changes and
   then maybe get stuck with a patch conflict.  You want to be
   comfortable undoing things, or amending commits if you're
   not happy with what happened.

   This is why novices (and I used to be one) are reassured by the
   existence of "git merge --no-commit", but experienced users don't
   see the point.

   With git, pushing (or asking someone else to pull) is the
   moment of truth.  Committing has no lasting consequences.

3) Branches are your friend.  CVS users think branches are a big
   deal and require careful thought and planning.  Git users branch
   almost as often as CVS users commit.  A typical "big change"
   that might be a single commit in CVS would be a branch of
   several commits in git.

   In fact, a good piece of advice is to NEVER commit directly
   to your trunk ("master").  Do ALL development on branches, and
   merge them into the trunk.

   I cheat on that a lot, but I also know how to fix things if I get
   caught becauee a quick hack is proving not so quick: add a branch
   reference to the tip I'm developing on and then back up the master
   branch to where I should have left it when I started this project.
