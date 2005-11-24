From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/9] remove git wrapper dependency
Date: Thu, 24 Nov 2005 00:50:21 -0800
Message-ID: <20051124085020.GK4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <438577E0.30109@op5.se> <7voe4awii5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 24 09:51:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCoK-0000aq-DH
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVKXIu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbVKXIu0
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:50:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14314 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1161057AbVKXIuV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 03:50:21 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 134C32DC033; Thu, 24 Nov 2005 00:50:21 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7voe4awii5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12697>

Junio C Hamano <junkio@cox.net> wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Eric Wong wrote:
> >> use git-diff-files instead of git diff-files so we don't rely on the
> >> wrapper being installed (some people may have git as GNU interactive
> >> tools :)
> >>
> >
> > This one should do
> > 	git --exec-path
> >
> > first to get the proper path to git-diff-files. Fall back to it being in 
> > the path if finding out fails.
> 
> Eric is worried about the case where git on your PATH is GNU
> interactive tools, so "git --exec-path" would not give you what
> you want ;-).

Right on.  I'm actually not a GNU interactive tools user, but I do have
empathy for them being a cg (cgvg) user myself for many, many years.

-- 
Eric Wong
