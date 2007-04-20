From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Contribute a fairly paranoid update hook
Date: Fri, 20 Apr 2007 10:59:23 -0400
Message-ID: <20070420145923.GB17480@spearce.org>
References: <20070420060847.GA8255@spearce.org> <7vmz131fzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 16:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeuaA-0001OG-Dl
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 16:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbXDTO71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbXDTO71
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 10:59:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40680 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbXDTO70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 10:59:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HeuZz-0007cv-VX; Fri, 20 Apr 2007 10:59:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A629A20FBAE; Fri, 20 Apr 2007 10:59:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vmz131fzz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45110>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +$ENV{PATH}     = '/opt/git/bin';
> 
> This caught my attention ;-).

What, is replacing PATH in the hook really all that paranoid?
Its a perfectly reasonable thing to do.  ;-)

Someday I'll post the patch to receive-pack that I use to run
it setuid.  That thing is also fairly paranoid.  I won't submit
it for application to git.git though, as I don't think it really
belongs in the main receive-pack code.  So it might be a patch file
for contrib, or just an article in the mailing list archives that
people can link to.

I also recently hacked some semi-useful features into gitweb.cgi.
I need to finish those for our local use, and then see if I can
extract them enough to make them publicly available.  gitweb.cgi is
probably going to become a cornerstone of our main development and
testing workflow, especially for managers and testers who don't want
(or really need) full repositories on their deskstops.

-- 
Shawn.
