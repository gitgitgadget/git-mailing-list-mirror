From: Shawn Pearce <spearce@spearce.org>
Subject: Re: core-git and porcelains
Date: Wed, 11 Oct 2006 11:08:42 -0400
Message-ID: <20061011150842.GA31298@spearce.org>
References: <egivn8$5mf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 17:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXfhZ-0007r0-74
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 17:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWJKPIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 11:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWJKPIy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 11:08:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18610 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965218AbWJKPIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 11:08:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GXfhM-0003qs-Cv; Wed, 11 Oct 2006 11:08:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 00FE920FB00; Wed, 11 Oct 2006 11:08:42 -0400 (EDT)
To: Pazu <pazu@pazu.com.br>
Content-Disposition: inline
In-Reply-To: <egivn8$5mf$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28718>

Pazu <pazu@pazu.com.br> wrote:
> I'm a newcomer to git, and for the last few days, I've been struggling 
> to learn how to better use git in my day to day. One particular thing 
> that has been puzzling me is how much git is self-sufficient, and how 
> much I should depend on porcelains.
> 
> Apparently, I'm not alone in this: 
> http://thread.gmane.org/gmane.comp.version-control.git/6194/focus=6194
> 
> The above post was made about three months ago; where things stand now? 
> Do you feel that git-core should suffice for most developers, or should 
> I really look into something like Cogito?
> 
> Depending on the project, my git usage would fit one of two profiles. I 
> run some standalone projects, where I'm the sole developer. I was 
> looking into using cogito for this scenario, but one thing that baffled 
> me is how git-core and cogito use different branch representations.
> 
> For the larger part of my day, however, I'm looking into using git as a 
> personal tool in a very large corporate project; This project is 
> currently controlled using subversion, and my idea is to use git as a 
> 'staging' system, where I work (possibly offline) before pushing changes 
> to the upstream (remote, slow as hell) subversion repository. Here, 
> git-svn seems to be my best friend.
> 
> Any advice to this poor newbie?

I would just stick with core Git.  I haven't used Cogito in almost
a year so I can't say what I'm missing there, but core Git works
very well for all of my needs.  I use it in a lot of different
projects, some which require git-svn, others which require some
bastard git-svn-workalike for non-SVN systems, and others which
are just Git projects and don't have to cooperate with others.

Git has come a long way in terms of user interface.  It still has a
few rough edges but I think that there are less rough edges on core
Git's command line user interface than there are on the Subversion
command line client or the CVS command line client.

-- 
Shawn.
