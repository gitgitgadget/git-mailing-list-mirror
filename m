From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Git User's Survey 2007
Date: Sun, 29 Jul 2007 23:35:43 -0400
Message-ID: <20070730033543.GP20052@spearce.org>
References: <200707250358.58637.jnareb@gmail.com> <200707271320.06313.jnareb@gmail.com> <4d8e3fd30707290950lce19ef4g103cbb7ad1abbe23@mail.gmail.com> <200707300221.23511.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFM34-0004Np-6l
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936944AbXG3Dfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936881AbXG3Dfs
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:35:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59882 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759911AbXG3Dfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 23:35:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFM2f-0007qU-17; Sun, 29 Jul 2007 23:35:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C764E20FBAE; Sun, 29 Jul 2007 23:35:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707300221.23511.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54175>

Jakub Narebski <jnareb@gmail.com> wrote:
> Paolo Ciarrocchi wrote:
> > git-gui ?
> > 
> >>     9. Which git GUI do you use
> >>        (zero or more: multiple choice)
> >>     -  gitk, git-gui, qgit, gitview, giggle, other
>           tig, instaweb, (h)gct, qct, KGit
> 
> I consider git-gui an UI (like qgit or tig), not a porcelain. To be
> a porcelains tool need to add some SCM functionality not present in
> git-core.

Odd.  I consider git-gui to be a porcelain, just as I consider
tig and qgit to also be porcelain.  Though I think git-gui is more
of a porcelain than the others, as it tries to rely *less* on the
core porcelain and just on the plumbing.  I don't always succeed,
but I'm heading in that direction.

To me a porcelain is any tool that layers over the plumbing and makes
it easier for the end-user to operate it.  Early git only had things
like read-tree/write-tree/commit-tree.  Tying that all up into a neat
"Commit" command for the end-user is the job of porcelain.

Anyway.  Just so long as git-gui is included in the survey.  I'm
interested in seeing how many people use it, because I know it has
a pretty decently sized userbase.  Which is probably going to grow
in the future with the i18n work going on.

Do we have any questions in the survey about the user's native
language?  About their desire to have git translated into their
native language?  Folks are now working on translating git-gui,
and that work will be in git-gui 0.9.x, if not 0.8.1/2.  So it may
be nice to know what languages our users are interested in.

-- 
Shawn.
