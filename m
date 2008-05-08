From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: creating tracking branches with git gui
Date: Thu, 8 May 2008 19:41:14 -0400
Message-ID: <20080508234114.GZ29038@spearce.org>
References: <2e24e5b90805070104i337f9196g90134d11f35a1094@mail.gmail.com> <2e24e5b90805072006j311b276cpe0a0d0eea9fa13a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 01:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuFkY-0002Ny-Bh
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 01:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYEHXlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 19:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754300AbYEHXlT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 19:41:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52771 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYEHXlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 19:41:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuFjV-0008Qi-Jr; Thu, 08 May 2008 19:41:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6D08E20FBAE; Thu,  8 May 2008 19:41:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <2e24e5b90805072006j311b276cpe0a0d0eea9fa13a0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81578>

Sitaram Chamarty <sitaramc@gmail.com> wrote:
> 
> Over on another thread I found a config variable called
> gui.matchtrackingbranch, but setting that to true only saved me a
> mouse click -- it didn't really create the tracking, as seen by "git
> remote show origin".

Yea, I think that option actually predates the --track thing that
git-branch does these days.  Its designed to save a mouse click if
you are working in a corporate centralized repository model and
need to switch branches multiple times per day, always grabbing
the latest from the centralized repository when possible.

> On Wed, May 7, 2008 at 1:34 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> >
> >  Using git gui to create tracking branches only creates the local
> >  branch, but does not establish tracking.  Using the command "git
> >  branch newbr origin/newbr" works as expected of course.
> >
> >  I clicked on "Branch", then "Create", chose the "Match Tracking Branch
> >  Name" radio button, chose the appropriate branch (origin/newbr) in the
> >  list below, then finally hit Create at the bottom right.

Right.

I don't use the --track feature (branch.$name.remote, branch.$name.merge)
in my own work, so I have never had the desire or need to make sure that
git-gui sets this up for you.

I'll try to work up a patch this evening.

-- 
Shawn.
